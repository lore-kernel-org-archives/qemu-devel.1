Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B446EC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF601206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF601206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJmZ9-0002YK-Mh
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 18:10:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmXF-0000eg-Eb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmJX-0006YZ-N6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:53:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJmJX-0006XB-52
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:53:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so1433446wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NaPGrJILZE4qFy8xmfe+rJXg3UuxeRMh9zAw451xYLI=;
	b=gU5Job3qdeoHM9nbS0tsBsvU8JGJAWNodjRWhxYG3DFL19NkjPDiZVMQtx8H9CJT1S
	ttO5oPZ7P5enXd5+1dq7pzZJEp9Zh36iTULRQyXX9T6A8fSoMFrRvbidz+LGjXPZjYVY
	Bbpm8v4uk0Kv8BxqhZya/PV2u2iUdH4vUZlFX+u1HyzgMRJ3o7DOVMJHYneE7HwuXWv2
	vAf63ZcElfiDsOyYQMZxn8PuFOx70XYjH4L5d9H4V6p6ms8NmIwlqSF5SzTHpZ22hSMA
	w61MAA5aeGAYuObgubnEpaNNjG/HfonoNAH+HwJpMTYX1VOgbSVRDFSf9cVfgrdclKAP
	OZhw==
X-Gm-Message-State: APjAAAWHGcloxrx+stg3HFUk9w41ru3RGTkRVshK7rJtyP4hT2tPUbDJ
	Lnb80avrFZOjVQTovMGq/FVcMA==
X-Google-Smtp-Source: APXvYqx/smG8qPLwxxWw4MT4iNvMXZ0AWXam4AerDTF0aClxTkQPz2rG9J1yCzznl8R3j51MWvNiwQ==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr11613229wrp.96.1556229234042; 
	Thu, 25 Apr 2019 14:53:54 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	d10sm5794015wmb.15.2019.04.25.14.53.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:53:53 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-20-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8c7e6aa5-3f74-7c63-486c-80e3e21e9da5@redhat.com>
Date: Thu, 25 Apr 2019 23:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-20-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 19/29] hw/arm: Express
 dependencies of the MPS2 boards with Kconfig
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
Message-ID: <20190425215351.h2qj7UHHSk9dgFAddmGB9I6IHYJqsxY6p2v5TnHgMcw@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the mps2-an* machines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 20 +-------------------
>  hw/arm/Kconfig                  | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index a0b9016e3a..31d31d3f4a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -30,6 +30,7 @@ CONFIG_Z2=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
> +CONFIG_MPS2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> @@ -38,28 +39,9 @@ CONFIG_IMX_FEC=y
>  CONFIG_FRAMEBUFFER=y
>  
>  CONFIG_DIGIC=y
> -CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>  
> -CONFIG_CMSDK_APB_TIMER=y
> -CONFIG_CMSDK_APB_DUALTIMER=y
> -CONFIG_CMSDK_APB_UART=y
> -CONFIG_CMSDK_APB_WATCHDOG=y
> -
> -CONFIG_MPS2_FPGAIO=y
> -CONFIG_MPS2_SCC=y
> -
> -CONFIG_TZ_MPC=y
> -CONFIG_TZ_MSC=y
> -CONFIG_TZ_PPC=y
> -CONFIG_ARMSSE=y
> -CONFIG_IOTKIT_SECCTL=y
> -CONFIG_IOTKIT_SYSCTL=y
> -CONFIG_IOTKIT_SYSINFO=y
> -CONFIG_ARMSSE_CPUID=y
> -CONFIG_ARMSSE_MHU=y
> -
>  CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 2ef5696900..466b143fdf 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -301,6 +301,12 @@ config ASPEED_SOC
>  
>  config MPS2
>      bool
> +    select ARMSSE
> +    select LAN9118
> +    select MPS2_FPGAIO
> +    select MPS2_SCC
> +    select PL022    # Serial port
> +    select PL080    # DMA controller
>  
>  config FSL_IMX7
>      bool
> @@ -340,6 +346,18 @@ config ARM11MPCORE
>  
>  config ARMSSE
>      bool
> +    select ARMSSE_CPUID
> +    select ARMSSE_MHU
> +    select CMSDK_APB_TIMER
> +    select CMSDK_APB_DUALTIMER
> +    select CMSDK_APB_UART
> +    select CMSDK_APB_WATCHDOG
> +    select IOTKIT_SECCTL
> +    select IOTKIT_SYSCTL
> +    select IOTKIT_SYSINFO
> +    select TZ_MPC
> +    select TZ_MSC
> +    select TZ_PPC
>  
>  config ARMSSE_CPUID
>      bool
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

