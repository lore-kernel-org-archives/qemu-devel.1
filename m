Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2FC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BAF2088F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BAF2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgir-00048r-Ts
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 11:55:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgho-0003QM-Fc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJghk-0005yI-Ut
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:54:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJghk-0005vE-Oh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:54:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so9884783wmf.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LohXC0yeWaYs5NCSykzb6Caf/iFjyRtIugeMKT3Ooyg=;
	b=ifTeIyhj23laqWf+ZxdFJWpgeo9BfDDMJd49A93O5e5R4xUp4aw2WMfOy7Kgket1oH
	6/1S1XlTNaMopqJY119r/7T7WZsRoL0JvIydDzvrQ7Irl0dqxAzaZrq6lgRuSQqXP/dp
	bdny4sMJ2LHT5MVcYmPxBy6Vw9eVbaY79gNoZ5oFVXC+jWABNSgugBQtjXA1oqSZ0Fy+
	uhVIl8SqjuP7ySvL8aBCjmzMc6mvLeJm4NScEA0EZ0u+5aoViZz2bcQaJy9zO50gp9hD
	Tra0uaUYOfZdKh0f9nmpRtL0ZNU1H56D5Ks1FV9CTA6VHC1QEEo1UfTIpFuZ7MIXBTvA
	+tUg==
X-Gm-Message-State: APjAAAUb1M1s6TfwosAiYLpS4kmUTooh0wFBmnuNRw7o6ngmvdeTwUjl
	IWsw38wCd7BsZkpEavaz6zYduQ==
X-Google-Smtp-Source: APXvYqz3T4J42gHH/+c157Wm5Kcw91xb5I5hGV3FB5rliKMRTSPUhupO1HlcIJaYdMucX1mHTsY0lQ==
X-Received: by 2002:a1c:a5d0:: with SMTP id o199mr3917377wme.28.1556207671403; 
	Thu, 25 Apr 2019 08:54:31 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	v14sm2984795wra.58.2019.04.25.08.54.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 08:54:30 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-21-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bd069b29-2bf7-b468-fe91-d90a339ea1b1@redhat.com>
Date: Thu, 25 Apr 2019 17:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-21-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 20/29] hw/arm: Express
 dependencies of the raspi machines with Kconfig
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
Message-ID: <20190425155428.GPr1up9--qeBj-TN1Ytj47L68FcX-RIbABQncCU7QIM@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Most of the code is directly controlled by the CONFIG_RASPI switch,
> so not much to add here additionally.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 4 +---
>  hw/arm/Kconfig                  | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 31d31d3f4a..22bff20b32 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -31,15 +31,13 @@ CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
>  CONFIG_MPS2=y
> +CONFIG_RASPI=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>  
> -CONFIG_FRAMEBUFFER=y
> -
>  CONFIG_DIGIC=y
> -CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>  
>  CONFIG_FSL_IMX6=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 466b143fdf..e68a29ca2b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -257,6 +257,9 @@ config ALLWINNER_A10
>  
>  config RASPI
>      bool
> +    select FRAMEBUFFER
> +    select PL011 # UART
> +    select SDHCI
>  
>  config STM32F205_SOC
>      bool
> 

