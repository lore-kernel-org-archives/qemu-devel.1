Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F9C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B89720675
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B89720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJlx3-0007A4-BE
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 17:30:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJluR-0004bc-8I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJluQ-0003zL-27
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJluP-0003yg-S3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so1362905wre.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qGURUPMmUmHajOvtglo+W0q/YFgEp7ZhhCqqLRRXN4w=;
	b=nqrPAMFQX0XUTf10yR7hHbY0vQgQirwk3Lm8/JR6IDkAos18FJ7hQrjRKJylPCs8Wq
	wH54xCRkfC4G3Aj30k00kZHpBYAOvGGYP598sTpAyl94JjlHLmKGmx52zh3MWR90ObWW
	1HZ60PfK9KC1lw6KOKjHoQFo7G96hwBJwtU4QPbVeH3YmEJ5zrnWwcYvGrC9L+uiRoxz
	WD/Ad4/dKe+6cVHrJZnuytaG5lvw11Ppj3QAoZ4HcRv0MCzV84wjd+uLsjA4DRUS0CQw
	5USXEftnwV+j5v2Mzb0S2VZRF4Me9IC7Nym/i4qgz5nmwVu0z6cSKZfXnQJD8PgscgCj
	iTqA==
X-Gm-Message-State: APjAAAXgem7G4rulAd3syHLqUTMMXbLQHJDPrtzeodjiZFRVxTaxmdQN
	c/XdSLES1P4MMtf6gaiIUMYPcg==
X-Google-Smtp-Source: APXvYqyuXXqKMVc05Al1NWO2HzvQpExc9dh8OypCiaNY7Y8brHGdlFs0l6fXnrwnk/exa947jzkeKQ==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr6786874wrp.241.1556227676874; 
	Thu, 25 Apr 2019 14:27:56 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	o2sm17194498wrs.89.2019.04.25.14.27.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:27:56 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-26-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d672400a-0a96-c811-a063-672f697a9366@redhat.com>
Date: Thu, 25 Apr 2019 23:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-26-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
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
Message-ID: <20190425212754.YHbfB7hPi2KAYOL6xxZpXo65gMsPMLEUX2KM0SjKdBw@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the NRF51 / microbit machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 

