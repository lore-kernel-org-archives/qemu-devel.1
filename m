Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9761C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E672087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E672087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHnd0-000644-SN
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:53:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnc2-0005cn-HO
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnc1-0003Hk-I7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHnc1-0003Gn-CH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so8762765wmf.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 03:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9fLo6aj0WpQCkEqmOePI40fU/0sjDuqe+FIpqDtnu2M=;
	b=ZR+KUu2B6ZIWDXEqS501VxdeZRQmJQ5z4yuNzzKITogkxHSlmG+B795f4aTs3LoOYY
	ukqMir3pG6dVfXBUZgEFktZZBJcU/Az/BfOSzV3WRPuwgZlOOV9+d5ilB2iK+m9Ml7kN
	IZr4Dr20mdkiu+8CUDUCdxsKoSdFyI7ooK49ZMtzu3U5e6PQ2QH8yfyqxENIeCJiF4ji
	9ZJDX1lO5oMEJhVHD6o0KQYkK3KxKOf/IwrwoLHUSmaQmUzAG4rEiLis8Ot5jO96vens
	7cj7mpUQXO7phkGoUc2LOWf4Hd4OZc1k+kScpJDnsN/jpfJ0ruYGXv8oE2RzKKYms4LS
	tjdw==
X-Gm-Message-State: APjAAAUOjF3YC97XUZ4/vvuZL7YkQCJkS4s86m/Xymg4UhG55i2uhDhV
	Jqq4aZAF/w/PvQC5O1apzIYffQ==
X-Google-Smtp-Source: APXvYqwporyGpEAIlaHCYqqg1wdM9DraSVR5JXjhM/msnfWc74DlvQD05ETvMYlrSbuMm2D3/+g3Nw==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr5879138wmh.18.1555757568143;
	Sat, 20 Apr 2019 03:52:48 -0700 (PDT)
Received: from [10.100.97.143] ([213.174.99.147])
	by smtp.gmail.com with ESMTPSA id
	o4sm10558747wmo.20.2019.04.20.03.52.46
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 03:52:47 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-24-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <50de0d04-04ff-726f-ac39-c0f804dc7ea4@redhat.com>
Date: Sat, 20 Apr 2019 12:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-24-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 23/29] hw/arm: Express
 dependencies of the MSF2 / EMCRAFT_SF2 machine with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420105246.QSw5sMJyJ_vnkK4k3oqKyxPSYECVDZE1O-TvajKON6k@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the emcraft-sf2 machine - we also
> distinguish between the machine (CONFIG_EMCRAFT_SF2) and the SoC
> (CONFIG_MSF2) now.

Thanks!

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 8 ++++++++
>  hw/arm/Makefile.objs            | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index ef7dd7156a..1455d083d8 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -34,9 +34,9 @@ CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
> +CONFIG_EMCRAFT_SF2=y
>  
>  CONFIG_VGA=y
> -CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
> @@ -49,5 +49,4 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_MSF2=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 065c7acf1b..f5cd63860d 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -331,9 +331,17 @@ config FSL_IMX6UL
>  config NRF51_SOC
>      bool
>  
> +config EMCRAFT_SF2
> +    bool
> +    select MSF2
> +    select SSI_M25P80
> +
>  config MSF2
>      bool
> +    select ARM_V7M
>      select PTIMER
> +    select SERIAL
> +    select SSI
>  
>  config ZAURUS
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index fadd69882c..eae9f6c442 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_VIRT) += virt.o
>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> +obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
>  obj-$(CONFIG_INTEGRATOR) += integratorcp.o
>  obj-$(CONFIG_MAINSTONE) += mainstone.o
> @@ -41,7 +42,7 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>  obj-$(CONFIG_MPS2) += mps2.o
>  obj-$(CONFIG_MPS2) += mps2-tz.o
> -obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
> +obj-$(CONFIG_MSF2) += msf2-soc.o
>  obj-$(CONFIG_MUSCA) += musca.o
>  obj-$(CONFIG_ARMSSE) += armsse.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
> 

