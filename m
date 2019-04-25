Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7A8C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7E32067D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7E32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJghj-0003HV-2z
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 11:54:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJggm-0002st-5Y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJggl-00057u-2Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:53:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJggk-000578-Rr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:53:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so163969wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yE8k0+31sTN30zo+DkawuBrPvUnsBCgNFhrlkCG9Czs=;
	b=n/+uo3UoT+BC9Jw8uKAS6kLWtmPCGkgI16TTgoY+LcqJ6wF1tNtTXqm5MNyDWd+qL9
	EV29tH5rMcaVsQGHnx7D94331vSpdjKtwV3lsai1AzUOFNh/NutOUKVf2pCjN2YNfvhE
	jex+GfOzf1BV5gElKeLcIow1rgGe+byjgmazoUzzAu1YO+RcaowpV+Qrfiodr05miz69
	MVcW9rj3WuDxZVH2hS69z3DdMO3nj5fJMN4TcqrfMQUoFDFssA8b7dcbQVcxmtZqVPev
	vn+VFXzGamgaHzAY1JrbjzJ8jnuUO9skGIdEzIJQSgddNhfIx4RFlzTCS2cPTlbIxnFW
	4toQ==
X-Gm-Message-State: APjAAAW+J2UFblqfqJp9/9xVjUTQvbscqLTNve4iR7ff8kJsRt1nvs+Y
	j/ZXoi2T4TJj6NGVo2TQaemn0Q==
X-Google-Smtp-Source: APXvYqxzW6smh2M8kgPMl8FN3Oe4eg0oCPWIQk07mRC2pR0VnD/dS6PZKnwzTJeX63ctorDSEMlPaw==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr4761590wrs.265.1556207609905; 
	Thu, 25 Apr 2019 08:53:29 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122])
	by smtp.gmail.com with ESMTPSA id q3sm498080wre.31.2019.04.25.08.53.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 08:53:29 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
Date: Thu, 25 Apr 2019 17:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-17-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
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
Message-ID: <20190425155326.Bhg-Xn1aoWFOnQGvbN2-Hbpf8lvHhI9aenmpoEIOc-4@z>

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined by looking at hw/arm/virt.c
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 11 +----------
>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>  hw/arm/Makefile.objs            |  3 ++-
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2580584281..f440a2b1cd 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=y
>  # CONFIG_PCI_DEVICES=n
>  # CONFIG_TEST_DEVICES=n
>  
> +CONFIG_ARM_VIRT=y
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
> @@ -32,8 +33,6 @@ CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> -CONFIG_PLATFORM_BUS=y
> -CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_NETDUINO2=y
>  
> @@ -68,9 +67,6 @@ CONFIG_IOTKIT_SYSINFO=y
>  CONFIG_ARMSSE_CPUID=y
>  CONFIG_ARMSSE_MHU=y
>  
> -CONFIG_PCI_EXPRESS=y
> -CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
> -
>  CONFIG_ALLWINNER_A10_PIT=y
>  CONFIG_ALLWINNER_A10_PIC=y
>  CONFIG_ALLWINNER_A10=y
> @@ -86,10 +82,5 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_ACPI=y
> -CONFIG_ARM_VIRT=y
> -CONFIG_SMBIOS=y
> -CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
> -CONFIG_FW_CFG_DMA=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index abeaa54d88..4d0febf644 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,6 +1,24 @@
>  config ARM_VIRT
>      bool
> +    imply PCI_DEVICES

Without -nodefaults I get:
qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
This is expected.

> +    imply TEST_DEVICES
> +    imply VFIO_AMD_XGBE
>      imply VFIO_PLATFORM
> +    imply VFIO_XGMAC
> +    select A15MPCORE
> +    select ACPI
> +    select ARM_SMMUV3

You forgot to remove ARM_SMMUV3 from default-configs/aarch64-softmmu.mak.

With it removed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    select GPIO_KEY
> +    select FW_CFG_DMA
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select PLATFORM_BUS
> +    select SMBIOS
> +    select VIRTIO_MMIO
>  
>  config CHEETAH
>      bool
> @@ -298,6 +316,7 @@ config A9MPCORE
>  
>  config A15MPCORE
>      bool
> +    select ARM_GIC
>  
>  config ARM11MPCORE
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 729e711b87..4f591ca487 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -1,4 +1,5 @@
> -obj-y += boot.o sysbus-fdt.o
> +obj-y += boot.o
> +obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
>  obj-$(CONFIG_ARM_VIRT) += virt.o
>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
> 

