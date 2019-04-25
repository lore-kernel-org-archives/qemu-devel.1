Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808FC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D5206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhDU-0001ff-Rn
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:27:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhAR-0007dE-EU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhAP-0007uz-G1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJhAN-0007lO-Fi
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id k16so264477wrn.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Yirb3BB0GvqyFLEMdufU+A6oW4jk59sdATnvk/Bs9kA=;
	b=T7eidGtGziOHf3xDQ76e6GW6I1m7SrsGFPgSAIIxe+B0929lxcnCfLznvKCTMUJ5l3
	qaKi5hSQMDcrdwkl/N2QCfQane3tvxzfNHZ7+eGoSk9/KNlPKT6TbFlZc99LbU0B9vq5
	eOFrCkGPIZg7P/8XbcEv2WjOn10DANNbGGsXfSnaSN3gw1wF6XnEVeyOZFdhFhxijMw4
	zYxmP1GdUjBmIuEcflKqSG1ZCa+rV/sv/f73cxhXL4q8wct3I3mTt0bvLE4hpiVgSc/N
	3HHB/5ObBuPGgX3ZaJ/DwrNCZY6TsizsVdaaE7h4OKIN4l9Glu8M4GfcQkVCYkpZLFdV
	64ew==
X-Gm-Message-State: APjAAAVl5hF+LhuGkhaaYuucJ+mNhGBYzdcDCOSbU8ANpsAeWQWoRClA
	/d8VXrVahYjIa+8S4zIA5W5c3g==
X-Google-Smtp-Source: APXvYqwuWNPhPLDIQuNXAd3ILLOEmkBO0eVUrcukG3jDcF38BfuiipAaKaWhoo8smNAtPowOvAtpqw==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr8247795wrr.261.1556209436174; 
	Thu, 25 Apr 2019 09:23:56 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	j9sm24345731wrr.93.2019.04.25.09.23.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:23:55 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-27-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <06ddd0d3-c036-f9dc-fc12-041a674a7808@redhat.com>
Date: Thu, 25 Apr 2019 18:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-27-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 26/29] hw/arm: Express
 dependencies of the ZynqMP zcu102 machine with Kconfig
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
Message-ID: <20190425162351._88PAjS25T2dgF7n0hb6xNmccOEDH0LiD9Rzj2QTVRU@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This cleans up most settings in default-configs/aarch64-softmmu.mak.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/aarch64-softmmu.mak |  4 ----
>  hw/arm/Kconfig                      | 11 +++++++++++
>  hw/display/Kconfig                  |  1 +
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 4ea9add003..3a4b15e7e8 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -3,10 +3,6 @@
>  # We support all the 32 bit boards so need all their config
>  include arm-softmmu.mak
>  
> -CONFIG_AUX=y
> -CONFIG_DDC=y
> -CONFIG_DPCD=y
> -CONFIG_XLNX_ZYNQMP=y
>  CONFIG_XLNX_ZYNQMP_ARM=y
>  CONFIG_XLNX_VERSAL=y
>  CONFIG_ARM_SMMUV3=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 708eae19e5..32e4cc50e5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -277,6 +277,17 @@ config STM32F205_SOC
>  
>  config XLNX_ZYNQMP_ARM
>      bool
> +    select AHCI
> +    select ARM_GIC
> +    select CADENCE
> +    select DDC
> +    select DPCD
> +    select SDHCI
> +    select SSI
> +    select SSI_M25P80
> +    select XILINX_AXI
> +    select XILINX_SPIPS
> +    select XLNX_ZYNQMP
>  
>  config XLNX_VERSAL
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 0577e68c8e..bb95f8d6a4 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -108,6 +108,7 @@ config VIRTIO_VGA
>  
>  config DPCD
>      bool
> +    select AUX
>  
>  config ATI_VGA
>      bool
> 

