Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3FC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2AE20878
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2AE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgm1-00056A-Ap
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 11:58:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgl6-0004hi-4g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgl5-0001Dd-35
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgl4-0001CH-TA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:57:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 26so4124333wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vkQAtDfMoIc/AqOZqt0xBI/A7og4dZgLq1NgZdkCB4Y=;
	b=jbBq1raHn0Xu+dA+sr0zKCZm4/tAj4PQaf2MV+mYrg9nnYqPW3aeEBL1l3uFjFFjaY
	6HJSHotT+fUor02ga8kDI4fVCjWwElihd3LSYSKT1Vz9TGThfweTtNgan/Urt24CJO1I
	Z/ZBrqgFJTFmOqmXnYtxpgIgumQNql0R8CwFY3Xc8m6ayYZTRcPHED8WE8tYlmU+RVXY
	pECsjHyjrWE+WSE7j7cFE00b+z6xsSxIFpELiwuaXoA6jXopKJYG9g5TPfLReMW8kXo8
	d5//iAf+5H5QHWe8we1t60xkOhrAv8LLZ6kZO2d7PBwLoSnG4f3gm1VyppT1CxaX2M+0
	T9Zg==
X-Gm-Message-State: APjAAAVhDmGXBNTjLTjpyJn4+dBeFr36msIVZQT9DSCLIsIDjrvTy1wG
	88xUWwjCzMPcRsA+FBmcsuZLuA==
X-Google-Smtp-Source: APXvYqyGR1nt3XnirIyEsBuEOkbWajiVJMOgbLnbKph9NMWTKhXk+qIAx2kx+BwxDLzDJfy7tsJfew==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr4286172wma.17.1556207877990; 
	Thu, 25 Apr 2019 08:57:57 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	m17sm3486401wrq.27.2019.04.25.08.57.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 08:57:57 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-19-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c6269d8-f4ec-04d2-8a17-81e00a2f26a0@redhat.com>
Date: Thu, 25 Apr 2019 17:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-19-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 18/29] hw/arm: Express
 dependencies of allwinner / cubieboard with Kconfig
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
Message-ID: <20190425155755.AIS2AIEPVDaQFkvlEv-zy0OK2eM05Hr8Zp29j1eohTE@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add dependencies for the Cubitech Cubieboard.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 6 +-----
>  hw/arm/Kconfig                  | 9 +++++++++
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index c86a9f5427..a0b9016e3a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -7,6 +7,7 @@ CONFIG_ARM_V7M=y
>  # CONFIG_TEST_DEVICES=n
>  
>  CONFIG_ARM_VIRT=y
> +CONFIG_CUBIEBOARD=y
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
> @@ -32,7 +33,6 @@ CONFIG_NETDUINO2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> -CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  
>  CONFIG_FRAMEBUFFER=y
> @@ -60,10 +60,6 @@ CONFIG_IOTKIT_SYSINFO=y
>  CONFIG_ARMSSE_CPUID=y
>  CONFIG_ARMSSE_MHU=y
>  
> -CONFIG_ALLWINNER_A10_PIT=y
> -CONFIG_ALLWINNER_A10_PIC=y
> -CONFIG_ALLWINNER_A10=y
> -
>  CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 49306d6419..2ef5696900 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -25,6 +25,10 @@ config CHEETAH
>      select OMAP
>      select TSC210X
>  
> +config CUBIEBOARD
> +    bool
> +    select ALLWINNER_A10
> +
>  config DIGIC
>      bool
>      select PTIMER
> @@ -245,6 +249,11 @@ config ARM_V7M
>  
>  config ALLWINNER_A10
>      bool
> +    select AHCI
> +    select ALLWINNER_A10_PIT
> +    select ALLWINNER_A10_PIC
> +    select ALLWINNER_EMAC
> +    select SERIAL
>  
>  config RASPI
>      bool
> 

