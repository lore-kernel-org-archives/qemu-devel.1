Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE656C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E01321479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E01321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHnIS-0001sq-KL
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:32:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnHK-0001QG-If
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnHJ-0008TH-Ja
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHnHJ-0008RF-DK
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so8719122wma.2
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 03:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UbMcmqbOd9VRLv70hQuWKZuCvQLNHN/aTnQnKReWt1E=;
	b=Wrgi81DvBqZu1KqsF/eVd8V4ueRO9R/ERxFxXATrP7tjH/6Mn5n3fZw/L9pZVAyhiF
	3HLr25gyD9Gez6CgdiWFpw/3TFdt4mRLhKTH7QnQLfb0870mr6ImOPQd0+j0BZvXsM7o
	t/i4NF01sojPRTICxOahd6IjZTyLKgwvD2IzyYpIvPlCGrDjAaDVfZZKTH0TPGeRHI0A
	I4R4/zSgUMDPYu0I7+weozbd5cHrTUwQaG1oIFcmhMfec/Y51rzSDf3rL8qlIChmFMUG
	N+DjKvE83yQNUg6x8blslytqM97sg9RxH3MliV+YziwZcO79+0K8glkIeoG0k0vGXSnE
	7IZA==
X-Gm-Message-State: APjAAAVVipyGII8sC0a3UVc560eO4V7PYohfiqLgMQScntzvH4MeyMu3
	jjpR5cdA/jAPccAp6UinTge3nw==
X-Google-Smtp-Source: APXvYqzaZjNcKemMaq28qgqu3NiotgtGHq+xqfL+2AGhwCerT+xM+s1xkrKb+UZkmLrBJeF/IhdkTg==
X-Received: by 2002:a05:600c:249:: with SMTP id
	9mr5566420wmj.149.1555756283318; 
	Sat, 20 Apr 2019 03:31:23 -0700 (PDT)
Received: from [10.100.97.143] ([213.174.99.147])
	by smtp.gmail.com with ESMTPSA id
	v17sm5694712wrv.30.2019.04.20.03.31.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 03:31:22 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Date: Sat, 20 Apr 2019 12:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-3-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 02/29] hw/ide/ahci: Add a
 Kconfig switch for the AHDI-ICH9 device
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
Message-ID: <20190420103121.pwsg2ocAqAT7GI1kuHbUGYumNFijnT0_eX5oThvGaAM@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHCI
> sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
> bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:
> 
>     ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>     hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>     hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>     hw/ide/ich.c:147: undefined reference to `msi_init'
>     ../hw/ide/ich.o: In function `pci_ich9_uninit':
>     hw/ide/ich.c:158: undefined reference to `msi_uninit'
>     ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
> 
> We must only compile ich.c if CONFIG_PCI is available, too, so introduce a
> new config switch for this device.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/ide/Kconfig       | 6 +++++-
>  hw/ide/Makefile.objs | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index ab47b6a7a3..5d9106b1ac 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -43,10 +43,14 @@ config MICRODRIVE
>      select IDE_QDEV
>  
>  config AHCI
> +    bool
> +    select IDE_QDEV
> +
> +config AHCI_ICH9
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> -    select IDE_QDEV
> +    select AHCI
>  
>  config IDE_SII3112
>      bool
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index a142add90e..faf04e0209 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) += mmio.o
>  common-obj-$(CONFIG_IDE_VIA) += via.o
>  common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
>  common-obj-$(CONFIG_AHCI) += ahci.o
> -common-obj-$(CONFIG_AHCI) += ich.o
> +common-obj-$(CONFIG_AHCI_ICH9) += ich.o
>  common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
>  common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
> 

