Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CB0C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17B22075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17B22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLNkc-0004GP-41
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:04:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNji-0003kD-PO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNjh-0002l0-Op
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLNjh-0002kT-Gy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so7913263wra.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=aMlaK8oo+b1EkNynelRQjG176jij1j2U61jeW1rlgm4=;
	b=ocljlqYdnw0Qm6R3s5u0anhUty7xT/enm9QdXl/UZSUxnP5sIo3q/m9RhfoKx3Ymvf
	LBluC42j+pe8UFVAn/EK10yBOW+uLRy1G9gHfRpfJaZ+stoIlsy6ZR65WHqbz4cmfRpW
	eP7GIKC6Kq2YLJ4Rtbyf+5OHd9qg3EfIKI5Z7bez8hvcFkrj9WpHWaZZlD+3f34Cb6UY
	fukqzqWyYL+Jq6wsJOalrs6PWhxmPTwdUYPYdkcZoDYly+LNKsdFtpMM7EIYrBZBMUB6
	xzsJ9xQFIM3dLZvzqvOiAa/uLRfQs5vcW58kfG99JV9bGhfgnGyyRmh0HOrvelZEwZzb
	wJFw==
X-Gm-Message-State: APjAAAXEzHi9aNan8hjp2MSdXcSJFJRB8fvOdosQBvoQppZ0UDMn5lW2
	wnOXUlqll6j6g3fV4BVm9xhK6g==
X-Google-Smtp-Source: APXvYqwLqOqAP/hm4o7s7mwPbGSLb33QM59YQj4y0OampFxiHQGP2dfeV+Y4RxfQOqazbKroxRf8QA==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr44560327wrn.51.1556611410777; 
	Tue, 30 Apr 2019 01:03:30 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	192sm2544533wme.13.2019.04.30.01.03.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 01:03:29 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190430071405.16714-1-thuth@redhat.com>
	<20190430071405.16714-12-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8b16e1b6-08a5-5f7a-1a59-f37679cd1fff@redhat.com>
Date: Tue, 30 Apr 2019 10:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-12-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v6 11/30] hw/arm: Express dependencies of
 stellaris with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Peter Chubb <peter.chubb@nicta.com.au>,
	Philippe Mathieu-Daude <f4bug@amsat.org>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430080328.NyblHaBOZPRVcAwt9jjmUULoKrnNZkq0PKBqPAPNLvs@z>

On 4/30/19 9:13 AM, Thomas Huth wrote:
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 6 deletions(-)
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
> index 71126254ff..e5a8ae5ef9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -91,6 +91,17 @@ config REALVIEW
>  
>  config STELLARIS
>      bool
> +    select ARM_V7M
> +    select CMSDK_APB_WATCHDOG
> +    select I2C
> +    select PL011 # UART
> +    select PL022 # Serial port
> +    select PL061 # GPIO
> +    select SSD0303 # OLED display
> +    select SSD0323 # OLED display
> +    select SSI_SD
> +    select STELLARIS_INPUT
> +    select STELLARIS_ENET # ethernet
>  
>  config STRONGARM
>      bool
> 

