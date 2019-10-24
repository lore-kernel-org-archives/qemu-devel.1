Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409AE21906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409AE21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhym-0003Hj-2L
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhpY-0003x6-8c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhpX-0004i3-0w
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:27:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhpU-0004gz-Bg; Thu, 24 Oct 2019 14:27:24 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPaQU-1ibPBU0sd8-00MaBY; Thu, 24 Oct 2019 20:27:02 +0200
Subject: Re: [PATCH v2 08/14] hw: Move DS1338 device from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-9-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a0e69faa-1705-a82d-8739-d0de2cf565d3@vivier.eu>
Date: Thu, 24 Oct 2019 20:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2wv/Ey8ZDlOtDKHKnWMlRBZgXCI0L8BthzwmAbilyfhnT64/Lnu
 N2tuPD+J0H1AZpTPFYBPw6Srx84z9RSCI0Snodn2cD8xfGMRih6mJ9TA780u3MkVn/gpmNz
 GhbuwjW0eBjnrC60GSz3hUfl18ODWDC5vlwyer6iGsVkviikb50TZzF5eWa5Wn0Il8cNX1R
 DZp1bebw/Q5qwUe4FfEOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b+9L5jeWurA=:9yQWWKB9f0JWG5ht2E2M7R
 0m+JfF/qT1ZWnyxPtff+VedBPzmvABSK7exFGDsDKHGOOpOYGQmYrTN5sauifnqZAm7ku6dKX
 lwmUfQJ7+y0tfenn3FHtaM1EK5sKnmr1LUvm7TWCTUAKLFV3nYu7/1sAq+OULEQ90EXRasYlV
 YoQc/ic37VY0b3ZSdH9MTRzNhsmCbYGQrycFrHWFmC74VGclENlFbt7XErl5WV0auuQo7hy9n
 ScK1DdCAcrMmUD6hyvVqIMPPVXghaeb7iAdrC5bAT0Pvg82boQjqxIfz//CNiN0WfmzVM2oNc
 j7nxzIN/TG7hynxeXmeCMM0bPheOXjZb7HtqnOQEBi1JElDWQiu2VKbIHJkNEyC2V5My9MiDi
 jzZeyU/nM/9r9xHImX3OlWC+guSA+2m0LH9GMsRyf8dI97ZwpoFBNJ9bzOswnd1BCxD4NjnTT
 pb5loJwRpoFJKplhCNZ14Tez5Z5DTA1kPp9v9BYEmIS5YE///G/Cqj3fTNGJYCjnMzoYyb6PF
 etYQtyE5sRrtR+vXnDgv8H3zGJvde+nq4HoeXEfSabVuW2w0jGOKmSPc9M6nx4U+j9VVt72JY
 wmOMXdi3Xz6G4AKZxzr3GpijEmRyH6hTvrauGyzjPY8UxjSxRrBzORWRQ/GD9z2rqUaSzb881
 In7lU2hvU/MP20OcmIBQrDos3VewAQanYkl73/stQ5zqDj85dzV6IDtM4P2p6tqeALTcQmccy
 8qmmi3CfyfW4hSzN0Iu5hzFpqjWwejcfaeHt1KKFxd2lE0gjPZLGk0RkW2bldc8azN5nFuH29
 3w0nk86uz91tejBVSFHLldLjnTK/qcAOpT3LYDpEDeVhmb07+EeI1zx3GNcwZ5O2I7982sOHY
 h8scTxPwmOrUr7gA77pWmw82Ecj9QdzQ1L4739ViY=
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
> The DS1338 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/rtc/Kconfig             | 4 ++++
>  hw/rtc/Makefile.objs       | 1 +
>  hw/{timer => rtc}/ds1338.c | 0
>  hw/timer/Kconfig           | 4 ----
>  hw/timer/Makefile.objs     | 1 -
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename hw/{timer => rtc}/ds1338.c (100%)
> 
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index dff9d60946..45daa8d655 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,7 @@
> +config DS1338
> +    bool
> +    depends on I2C
> +
>  config M41T80
>      bool
>      depends on I2C
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 810a38ee7b..b195863291 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,3 +1,4 @@
> +common-obj-$(CONFIG_DS1338) += ds1338.o
>  common-obj-$(CONFIG_M41T80) += m41t80.o
>  common-obj-$(CONFIG_M48T59) += m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
> diff --git a/hw/timer/ds1338.c b/hw/rtc/ds1338.c
> similarity index 100%
> rename from hw/timer/ds1338.c
> rename to hw/rtc/ds1338.c
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 9357875f28..a990f9fe35 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -9,10 +9,6 @@ config ARM_MPTIMER
>  config A9_GTIMER
>      bool
>  
> -config DS1338
> -    bool
> -    depends on I2C
> -
>  config HPET
>      bool
>      default y if PC
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 23be70b71d..70b61b69c7 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -3,7 +3,6 @@ common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
>  common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
> -common-obj-$(CONFIG_DS1338) += ds1338.o
>  common-obj-$(CONFIG_HPET) += hpet.o
>  common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
>  common-obj-$(CONFIG_PUV3) += puv3_ost.o
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

