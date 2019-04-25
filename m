Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3EC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EDF206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EDF206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfKa-0002CP-EE
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:26:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfJE-0001Ed-A9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfJD-0005LZ-8T
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfJC-0005Kg-Ue
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so9550099wmf.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tjNSeGqW5ltbIALXlNRkf09d8BwHxi8TlGUDyry9ra8=;
	b=Pjjndiw0Y5VVm9tomqp9cpI3fYt8AfCgCW6HVnyhIyrvT3dppEACPeRsK5lsPx5aZg
	v9Yqwb48ypxuSN4viP0LPMNDhDAbNoeXONyeLADjByDSqX/HLpJoIzjVKMhyqIZPlI7o
	+Lwo+ox8cmiOu1wcQSr1U1GvYOI26Fdn872qWNFxl9hQfZjSQImSNaHOUtTKrNLWGtjJ
	fUso3yKAXc6tAWD3dsZeTDgsKPUUyND9EZq6iPArMAIioRDOWKs8UHQ2f1FavQRDYbYm
	b2eWClk4PdV26WPgKa+L12aDf56b19YaYI9GzMay76wCaEDzw6Ghmo5kWAFy9xrzPIKp
	bdLw==
X-Gm-Message-State: APjAAAX9IKtJs7oZfGSiW5ioAUCamBdKPp4diqqTNoOi4Z4oQ6x5pJvV
	IGpnEcjlyJIK1sX6HPN4f3qjTQ==
X-Google-Smtp-Source: APXvYqwgWvvGsIRt23DHdjkaUcHQORseWua2pxBF65CJbKg84DvPJUAH4YqcC4tgDf85B+os48f+bg==
X-Received: by 2002:a1c:3507:: with SMTP id c7mr3598956wma.20.1556202305924;
	Thu, 25 Apr 2019 07:25:05 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	j190sm28069868wmb.19.2019.04.25.07.25.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 07:25:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <acc9802b-5f72-f9f5-32dd-a03d9b6d7e4e@redhat.com>
Date: Thu, 25 Apr 2019 16:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-6-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 05/29] hw/arm: Express
 dependencies of the highbank machines with Kconfig
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
Message-ID: <20190425142503.Y6u0tAU-dyTB7PQfIDUvt0_Wb9aT15dH404_yNxwFAU@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the highbank machine (and the midway
> machine).
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  9 +--------
>  hw/arm/Kconfig                  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2a11e76cc7..50a4be3cad 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -8,6 +8,7 @@ CONFIG_PCI_DEVICES=y
>  CONFIG_PCI_TESTDEV=y
>  
>  CONFIG_EXYNOS4=y
> +CONFIG_HIGHBANK=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -45,24 +46,17 @@ CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_ARM11MPCORE=y
> -CONFIG_A15MPCORE=y
>  
>  CONFIG_NETDUINO2=y
>  
> -CONFIG_ARM_TIMER=y
> -CONFIG_PL011=y
> -CONFIG_PL022=y
> -CONFIG_PL031=y
>  CONFIG_PL041=y
>  CONFIG_PL050=y
> -CONFIG_PL061=y
>  CONFIG_PL080=y
>  CONFIG_PL110=y
>  CONFIG_PL181=y
>  CONFIG_PL190=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
> -CONFIG_XGMAC=y
>  CONFIG_PXA2XX=y
>  CONFIG_BITBANG_I2C=y
>  CONFIG_FRAMEBUFFER=y
> @@ -150,7 +144,6 @@ CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> -CONFIG_HIGHBANK=y
>  CONFIG_MUSICPAL=y
>  
>  # for realview and versatilepb
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index acd07b2add..0ba377ac18 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -18,6 +18,17 @@ config EXYNOS4
>  
>  config HIGHBANK
>      bool
> +    select A9MPCORE
> +    select A15MPCORE
> +    select AHCI
> +    select ARM_TIMER # sp804
> +    select ARM_V7M
> +    select PL011 # UART
> +    select PL022 # Serial port
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select PL310 # cache controller
> +    select XGMAC # ethernet

Similarly to my comment on patch 6 of this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  config INTEGRATOR
>      bool
> 

