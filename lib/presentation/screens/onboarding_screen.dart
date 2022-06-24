import 'package:fast_food/generated/resource.dart';
import 'package:fast_food/logic/cubit/page_cubit.dart';
import 'package:fast_food/presentation/widgets/app_button.dart';
import 'package:fast_food/theme/colors.dart';
import 'package:fast_food/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<String> images = [R.ASSETS_PNG_ONBOARDING1_PNG, R.ASSETS_PNG_ONBOARDING2_PNG, R.ASSETS_PNG_ONBOARDING3_PNG];
  List<String> titles = [
    'Save Food with our new Feature!',
    'Set preferences for multiple users from various restaurants!',
    'Fast, rescued food at your service.'
  ];
  List<TextStyle> textStyles = [
    typoPoppinsThin55.copyWith(color: colorWhite),
    typoPoppinsThin40.copyWith(color: colorWhite),
    typoPoppinsThin55.copyWith(color: colorWhite)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colorFF4B3A, colorFF470B],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'SKIP >>',
                    style: typoNunitoBold18.copyWith(
                      color: colorWhite.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(32),
                height: 75,
                child: Image.asset(
                  R.ASSETS_PNG_LOGO_CIRCLE_PNG,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (index) {
                    BlocProvider.of<PageCubit>(context).changePage(index);
                  },
                  itemBuilder: (context, index) => OnboardingItem(
                    image: images[index],
                    title: titles[index],
                    textStyle: textStyles[index],
                  ),
                ),
              ),
              BlocBuilder<PageCubit, PageState>(
                builder: (context, state) {
                  return state.pageIndex != 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              3,
                              ((index) => Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: DotIndicator(
                                      isActive: index == state.pageIndex,
                                    ),
                                  )),
                            ),
                          ],
                        )
                      : AppButton(
                          buttonTitle: 'Get started!',
                          textStyle: typoPoppinBold17.copyWith(color: colorFF460A),
                          boxDecoration: const BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? colorFFDFD4 : colorFF855D,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    required this.image,
    required this.title,
    required this.textStyle,
  }) : super(key: key);

  final String image, title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
        const Spacer(),
        Image.asset(
          image,
          fit: BoxFit.fill,
        ),
        const Spacer(),
      ],
    );
  }
}
