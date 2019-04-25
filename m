Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7229DC4321B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8731E2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8731E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJm8I-0001cg-DK
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 17:42:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJm7J-0001Ay-QH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJm7I-0004th-Oe
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:41:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJm7I-0004sS-I0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:41:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so2527734wmf.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tTfceA5UaoyjTV9PTdaEm84vFPbIbm3ou+o6zkMHdoM=;
	b=X6RqT4JKTAngo11HyLNZ2TnbyqzPJ6Ki49cZX/OHflpOHjqflpQK634wrhMyTjyipu
	NLiMsWyr8DRn8Ky81Ps3iO7QR4fSzrIasmeZv6VRoTfy9ctBYkmeRX68PVkXMWj6Cvt5
	BwUZRK8wAI/nuf9Ad3AAPirowkzZR11KqgkrPo5zY345oK7rcrmccoEHWQdsvWm6WX8U
	qblX2xS+AaYBdws0nl6JENJZLALH8vPV9b4rsd4U/tqxyI2CYLsfQQjGOo6dlkHVezrV
	xBh3xVRJ0BbVytAgDwJa5ElgreYHY+Pi8r6IvWNWR6+Ezv/jiDhnWi0ZR9GtnoE1CVNB
	am/Q==
X-Gm-Message-State: APjAAAWTlDv8nE7qRykh7v9FqYmtaqEvHpoLEc51c8UNjJPDk9EG2IAN
	3giO1AVu07iEmSGTbUFtD1eicA==
X-Google-Smtp-Source: APXvYqxAhzSuOCw5EVHW9VgnGPj8qUN4Za+GMchXS6oiubQ82BRgXiy5P9++5sFqUyi/P/ykccfb6Q==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr4939651wmb.84.1556228475435; 
	Thu, 25 Apr 2019 14:41:15 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	c139sm12300783wmd.26.2019.04.25.14.41.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:41:14 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-11-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <377a2033-504b-a84d-0eb0-765de81af730@redhat.com>
Date: Thu, 25 Apr 2019 23:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-11-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 10/29] hw/arm: Express
 dependencies of stellaris with Kconfig
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
Message-ID: <20190425214112.V7jucprPpcR9UP7oG-XzyryL4anGAEDm8IFp_lqyZGE@z>

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index b7ed3c530b..3f82d635e4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -16,6 +16,7 @@ CONFIG_MUSCA=y
>  CONFIG_CHEETAH=y
>  CONFIG_SX1=y
>  CONFIG_NSERIES=y
> +CONFIG_STELLARIS=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -24,16 +25,10 @@ CONFIG_SERIAL=y
>  CONFIG_MAX7310=y
>  CONFIG_TMP421=y
>  CONFIG_PCA9552=y
> -CONFIG_STELLARIS=y
> -CONFIG_STELLARIS_INPUT=y
> -CONFIG_STELLARIS_ENET=y
> -CONFIG_SSD0303=y
> -CONFIG_SSD0323=y
>  CONFIG_DDC=y
>  CONFIG_SII9022=y
>  CONFIG_ADS7846=y
>  CONFIG_MAX111X=y
> -CONFIG_SSI_SD=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 71126254ff..b91503f5a6 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -91,6 +91,16 @@ config REALVIEW
>  
>  config STELLARIS
>      bool
> +    select ARM_V7M
> +    select I2C
> +    select PL011 # UART
> +    select PL022 # Serial port
> +    select PL061 # GPIO
> +    select SSD0303 # OLED display
> +    select SSD0323 # OLED display
> +    select SSI_SD
> +    select STELLARIS_INPUT
> +    select STELLARIS_ENET # ethernet

This one misses CMSDK_APB_WATCHDOG:

$ qemu-system-aarch64 -M lm3s811evb
qemu-system-aarch64: Unknown device 'luminary-watchdog' for default sysbus
Aborted (core dumped)

(gdb) bt
#1  0x00007fbee955d895 in abort () at /lib64/libc.so.6
#2  0x0000560905068f6a in qdev_create (bus=0x0, name=0x5609053b9e5a
"luminary-watchdog") at /source/qemu/hw/core/qdev.c:131
#3  0x0000560904ec1afc in stellaris_init (ms=0x560906d82c00,
board=0x5609056e79e0 <stellaris_boards>) at
/source/qemu/hw/arm/stellaris.c:1344
#4  0x0000560904ec22ff in lm3s811evb_init (machine=0x560906d82c00) at
/source/qemu/hw/arm/stellaris.c:1468
#5  0x000056090507326a in machine_run_board_init
(machine=0x560906d82c00) at /source/qemu/hw/core/machine.c:1030

It works with the following snippet:
-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
@@ -200,6 +200,7 @@ config STELLARIS
     select SSI_SD
     select STELLARIS_INPUT
     select STELLARIS_ENET # ethernet
+    select CMSDK_APB_WATCHDOG # Luminary
---

>  
>  config STRONGARM
>      bool
> 

