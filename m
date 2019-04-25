Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46223C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8042F20878
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8042F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgnB-0005tN-9M
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:00:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgm4-0005Gb-Pi
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgm2-0002aj-Mo
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:59:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJglt-0002OH-39
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so131250wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pEWvzxKrJwtzvLjDQ9cAayn3b/wqzcTdETdW+QzgY3Q=;
	b=TDeFL+HHiSNDjH/nJ5pPdOTg4CajEcpMglxcSOGADBvRDiIoWtvY6LYTSKg/pw3/wr
	wS5i/Pxt5lxp2HkVq1QU5rejqAGSPT+ftE47pivKB5URXjNyBgNHddzMyVi463bHLjK5
	1GEZMKGk7SYKgvsXbreIMcxmeh89GxXpM5QCvzqZJYRWPcHmRZNA1UpGKc+XDh1y81qO
	qqufYVBPIDYt/HxPPScYnB0xpQgN3LCFigrvOrApObvJKzj8KamFRoyKUIvo2K3g2pib
	XD21r413WcsLB9DgM5fUU/Ia53ThFXBr+uew9PPGoyQrnT+l0l4Mo1aPvwwr6S78wlCn
	RfUg==
X-Gm-Message-State: APjAAAUTDhI0I/tlZHGlRLNx+dENb6h4ZyjisK1hOktu7BP7oCym8A7r
	OiSkffhue0Or5LPa1bVQiH44qw==
X-Google-Smtp-Source: APXvYqwL2UHv29cQtPgaLZARFi0YZUfNC6KrHnGXkplEy8uOSO6dWouekAVQj8DFGHANGKfrY/2yhQ==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr5248385wrq.279.1556207927111; 
	Thu, 25 Apr 2019 08:58:47 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	192sm31407411wme.13.2019.04.25.08.58.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 08:58:46 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-15-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <46bcb836-b4db-db2f-26a3-c2827c95e940@redhat.com>
Date: Thu, 25 Apr 2019 17:58:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-15-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 14/29] hw/arm: Express
 dependencies of collie with Kconfig
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
Message-ID: <20190425155844.na2UooUO-1i4GmjevvqiNjl99a-rwZYbTAnMqnGa2pk@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the Strongarm collie machine.
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 7 +++++++
>  hw/arm/Makefile.objs            | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index af78e7c892..25e8f717ac 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -25,6 +25,7 @@ CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
> +CONFIG_COLLIE=y
>  
>  CONFIG_VGA=y
>  CONFIG_TMP421=y
> @@ -97,5 +98,3 @@ CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> -
> -CONFIG_STRONGARM=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 785e383411..325133c129 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -168,6 +168,13 @@ config STELLARIS
>  
>  config STRONGARM
>      bool
> +    select PXA2XX
> +
> +config COLLIE
> +    bool
> +    select PFLASH_CFI01
> +    select ZAURUS  # scoop
> +    select STRONGARM
>  
>  config SX1
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 00328d1b0b..729e711b87 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -17,7 +17,7 @@ obj-$(CONFIG_TOSA) += tosa.o
>  obj-$(CONFIG_Z2) += z2.o
>  obj-$(CONFIG_REALVIEW) += realview.o
>  obj-$(CONFIG_STELLARIS) += stellaris.o
> -obj-$(CONFIG_STRONGARM) += collie.o
> +obj-$(CONFIG_COLLIE) += collie.o
>  obj-$(CONFIG_VERSATILE) += versatilepb.o
>  obj-$(CONFIG_VEXPRESS) += vexpress.o
>  obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
> 

