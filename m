Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D526ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC230205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC230205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhbg-0008Cl-Ff
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhRu-000781-HC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhRs-0004nQ-Vk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:03:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52119)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhRs-0004hv-LT; Thu, 24 Oct 2019 14:03:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MoNMu-1hdMBn0gP2-00ooUK; Thu, 24 Oct 2019 20:02:27 +0200
Subject: Re: [PATCH v2 01/14] hw/timer: Compile devices not target-dependent
 as common object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <9f57c1e8-5a2b-7caa-6461-139ad60b57de@vivier.eu>
Date: Thu, 24 Oct 2019 20:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z80SXNsCVhYNz63rVP2KGCGWwdR8wt/pnIvrQ3jqtGavyV//WPJ
 bQagSEvEd3l8nC8U5jLJFC0nIi2IuBVsUfYSHIAzoQNbYUAGyjU5sDsbDj5c9ZYluZjFKMc
 D3to3HuDEPii1H78ZgAh/EjqxCzG3xH+9Mn9c/8BfCmbDiYBVhM79w5w7EqbXN1U8hNELG8
 8BUlxXH2nklanQsAw9LXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZKwRa20/Rpw=:x0uD0v+dRzkj/yurXCNZbR
 QpX9Ur+x/SubNAA8qMxVyvjN1WgjgVv+uGZoWxUismyy4VCN3F+lQDYDAMQZZIHqQ9ekRb/FR
 ynfOaAXGBawAGKNLLa6rJUUZkercygk8RO5rSQ7ZnMNrr57w0wak3izPXTDGAIK1t4y7mN4zU
 NMbZes7s2As0CRgAAQVfyVNKxBbHP0vszQW5yd97cQNq7Elqe7qjrPt5xKtOcmUkyleNDdLFS
 x229sUecBhdfhu6jv82gERtHgZX3WYP2lRUGbc4dmhnh3i5y5vzSzV6T2ZAF07RlbfB54KIer
 uO7Uw29XYTdkZBQ1Ee5ytihWzXNOyBQTvYtRJvAe1DhOT+51vYgTq/RMtMY6W1GnIvP9HBINj
 9ZMaT5TovI6myKbyJJ52QxKl303ZTjdvYrBDUCOrP0rGfk2abN3NMmaJuGQU6ceVUcmsJKtkL
 MbKXL7VUiSUTSqyuMJYGVZGWkRcGhcfwuZ6X/4VTuKBZCRH5OgWOBdzFJUgr6+AfAbbuIiHyn
 a+x/aYeeAjb0qXij5nkZz9uPJTNJ5J9Nxta6C0Ufk/s/Vb+VLjMuUmhvpOZaPSzzxZM4MGkuN
 i+2xUNCPk0KqzeX/vuJ//XontKvUWGWtbB+hNtLMAtCUzStmFvBHNx2YYcPLIDLXNHGJdgOfL
 Iy/FZnZ25hC2WCivWtv/6G0HCq3aDj+gTVoSF9dOaPsYNRWAu2czoX5CTZZLsTn5yQcnkPkJX
 d0zGNGi+5m7vu0FU51dkVmFIPJXdJlOLzNPIqT2S/zPN11CZijsU5Av0YOqxDFE81SH9PZT5T
 y8kGc+7QRqdOoGKmiXurNkAKW5GqZFy1nchOgL++CtK1agltUSr6svSAJpbAv2ZqHOKDti/Si
 DxBMVi/HMmbuscvxmTw5b7+aeTLnlvTVKtm3iz8IQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/10/2019 à 01:03, Philippe Mathieu-Daudé a écrit :
> All these devices do not contain any target-specific. While most
> of them are arch-specific, they are shared between different
> targets of the same arch family (ARM and AArch64, MIPS32/MIPS64,
> endianess, ...).
> Put them into common-obj-y to compile them once for all targets.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/timer/Makefile.objs | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 123d92c969..f407523aa4 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
>  
> -obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
> -obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
> -obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
> -obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
> -obj-$(CONFIG_OMAP) += omap_gptimer.o
> -obj-$(CONFIG_OMAP) += omap_synctimer.o
> -obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
> -obj-$(CONFIG_SH4) += sh_timer.o
> -obj-$(CONFIG_DIGIC) += digic-timer.o
> -obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
> +common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
> +common-obj-$(CONFIG_OMAP) += omap_gptimer.o
> +common-obj-$(CONFIG_OMAP) += omap_synctimer.o
> +common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
> +common-obj-$(CONFIG_SH4) += sh_timer.o
> +common-obj-$(CONFIG_DIGIC) += digic-timer.o
> +common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
>  
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>  
> -obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
> +common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>  
>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

