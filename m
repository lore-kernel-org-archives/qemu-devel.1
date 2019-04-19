Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB6BC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A725F21736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpUvNhUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A725F21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHb40-0001hI-ND
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:28:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2R-0000ba-Pm
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaq4-0008Jt-Fj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:14:29 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHaq4-0008JL-5y; Fri, 19 Apr 2019 17:14:28 -0400
Received: by mail-lj1-x241.google.com with SMTP id p14so5587217ljg.5;
	Fri, 19 Apr 2019 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2tubYGVGC+zztlt6H1UAeONkKsPTLRYswJfNrPrC5Zc=;
	b=LpUvNhUmOQX3fz46wwSsfI9LqQRXqt2Je5AW90smgfQ2bc20skwxySvSvMZIcD7HwX
	p0cxPaNUzIkTGI48kxmCgRpGCMI0leEhqy84JT2floiTBO3l4dBdy9nwF6qXl8qk83mY
	kR0ojbgsxX0RtB+hNI9+DtzmYXI/ItFiKXjYDE4p+ZgK7clTAhAMGWFbk/WCYTq5KFFd
	emMPmQcn6GekW0FkwKo+3nrp6VpvqyeT9Rc6ajcTrNskiIhPWBYTqDtKLAiH9iPyvjfj
	nBHdmfHdscfAc3ylt7FI0MoOQufsLodwOhAN3v7cqPdYXEdXLCYQ+EwUJKCjDk77bAC2
	SB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2tubYGVGC+zztlt6H1UAeONkKsPTLRYswJfNrPrC5Zc=;
	b=j8z3ocq7v2AiLdF9AgQgST36p+2nf14RRYYyu6xOZipiy5P1A9vzPHgk8tZTsjogc1
	MJ8rn2/Jt6JIbVd2xhanbcI6Dj5wR5C85DtNwHfPlNANsL1XMlvovBrFQfxpAeqPQuLE
	I3DUfikWL2M7r/rGmcOtPsnOPYNPadEHHbrQ9V9mfbPRl2CHDJg00HDrKIlSNrPhkPXQ
	TdvzjcfooJar+nIoJyU8H9HfH4OsV8oEiDLD9uX7fbMYwTIwj5fw/mU57mn7sh5K6flt
	5Yb6uOzl1T9YmTbOSaL+K47XpwCOZHfrkLIwxU7qJFM3tB5Z658AB5nhTG/nlVwGJ8Jz
	/o+Q==
X-Gm-Message-State: APjAAAWoXdcgqoKcqIUSUmObmN+WnzrViG9ud8dTGEY9sJNyWcsmb7Vl
	Sm4xnTSjrXUieLBoIJ7pWNf4VrtQ1qRFu8t25qM=
X-Google-Smtp-Source: APXvYqwNNqKthg3dDQIQc8yQcPziQzkNf/21OOrqalz70x8XJqJrVbHb8kdm32CkL1C4h5b0Wzuf5sHWx0QrPutHkg4=
X-Received: by 2002:a2e:974d:: with SMTP id f13mr3377594ljj.140.1555708466431; 
	Fri, 19 Apr 2019 14:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-26-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-26-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:13:59 -0700
Message-ID:
 <CAKmqyKM4ZtUmT6U-9Nv=S_3KMVnPzogOkNPrtyqvKz=b+u1AYQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 25/29] hw/arm: Express
 dependencies of the microbit / nrf51 machine with Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Yang Zhong <yang.zhong@intel.com>, Rob Herring <robh@kernel.org>,
	Qemu-block <qemu-block@nongnu.org>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419211359.exeHUyBfQCjdBYLHQk5kYBwN3TXpSfkM9ADxl8e4IHo@z>

On Thu, Apr 18, 2019 at 11:23 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Add Kconfig dependencies for the NRF51 / microbit machine.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 6 ++++++
>  hw/arm/Makefile.objs            | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6dc388c43e..233937f394 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -35,11 +35,10 @@ CONFIG_RASPI=y
>  CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
> +CONFIG_MICROBIT=y
>
>  CONFIG_VGA=y
>
> -CONFIG_NRF51_SOC=y
> -
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 58439c492a..708eae19e5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -347,8 +347,14 @@ config FSL_IMX6UL
>      select IMX_I2C
>      select SDHCI
>
> +config MICROBIT
> +    bool
> +    select NRF51_SOC
> +
>  config NRF51_SOC
>      bool
> +    select I2C
> +    select ARM_V7M
>
>  config EMCRAFT_SF2
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index eae9f6c442..994e67dd0d 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -8,6 +8,7 @@ obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
>  obj-$(CONFIG_INTEGRATOR) += integratorcp.o
>  obj-$(CONFIG_MAINSTONE) += mainstone.o
> +obj-$(CONFIG_MICROBIT) += microbit.o
>  obj-$(CONFIG_MUSICPAL) += musicpal.o
>  obj-$(CONFIG_NETDUINO2) += netduino2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
> @@ -48,4 +49,4 @@ obj-$(CONFIG_ARMSSE) += armsse.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>  obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
>  obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
> -obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
> +obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
> --
> 2.21.0
>
>

