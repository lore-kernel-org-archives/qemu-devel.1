Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E43C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8962B216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8962B216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjU5T-0003Cq-QX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjU4w-0002oJ-4t
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjU4t-0004aB-97
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:41:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjU4p-0004T6-KT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:41:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so10702536wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oca/SvrvcPFJh9jjl695Eix/jMCghmhCnd35eJim0mk=;
 b=XLqzNwqpq59pVSrpNdS2RYkDAMEKMEjUmIDemOcPAhIYaZ406aVBhGtPFEmWBSbW8s
 RlEywqXxle71vw+5bCJoVh5KepvcWZ5LF43ANZyM/MlGttSbp9XL0RQsld4a+Mq1S5q3
 eMN2hBPNw6qK8vHzRz9JnWwuONtLpV3Q+YDb9kthskmFF2qcWUl93FG9nI8yzVd9w5n3
 iqSwv5YDpE9YfMMhCWmuTCI5fgQClFU+FazURlDyYkBygCCx5MNCK5KyjbBfT939UWU3
 e7IwWH+qH8hmd8weX2o057+jUziPfqGwsWJPZPolIJwtoBDGqnkOT1vYWFWkt+SHOusD
 gTmA==
X-Gm-Message-State: APjAAAXO5/bSgPJcL9RKYn9MN5n9g0vUi58s5ZODfd6fZn4ouiKg8ehN
 dzIeM1fJ8Qwwi4mPJDZPVPZWzw==
X-Google-Smtp-Source: APXvYqzHektSEEx71ZewM/0jJ89TiZozGpZ6QGHAhh+PUZVIsvSO+okoT2lMiYJqOiTwIv43koKtgw==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr4404331wmj.94.1562355656768; 
 Fri, 05 Jul 2019 12:40:56 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id z19sm7164399wmi.7.2019.07.05.12.40.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:40:56 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190703154958.29004-1-julio.montes@intel.com>
 <20190705143554.10295-1-julio.montes@intel.com>
 <20190705143554.10295-2-julio.montes@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <efa960f6-76cd-84e1-0e30-7c1a8312f263@redhat.com>
Date: Fri, 5 Jul 2019 21:40:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705143554.10295-2-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/i386: Fix linker error when
 ISAPC is disabled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus, Peter.

On 7/5/19 4:35 PM, Julio Montes wrote:
> v2: include config-devices.h to use CONFIG_IDE_ISA
> 
> ---
> In pc_init1(), ISA IDE is initialized without checking if ISAPC or IDE_ISA
> configs are enabled. This results in a link error when
> CONFIG_ISAPC is set to 'n' in the file default-configs/i386-softmmu.mak:
> 
> hw/i386/pc_piix.o: In function `pc_init1':
> hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
> hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
> 
> Place ide_isa code under #ifdef CONFIG_IDE_ISA to fix linker errors
> 
> Signed-off-by: Julio Montes <julio.montes@intel.com>
> ---
>  hw/i386/pc_piix.c    | 11 ++++++++---
>  include/qemu/osdep.h |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f29de58636..c7d4645a3f 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -61,9 +61,11 @@
> 
>  #define MAX_IDE_BUS 2
> 
> +#ifdef CONFIG_IDE_ISA
>  static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>  static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>  static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
> +#endif
> 
>  /* PC hardware initialisation */
>  static void pc_init1(MachineState *machine,
> @@ -254,7 +256,10 @@ static void pc_init1(MachineState *machine,
>          }
>          idebus[0] = qdev_get_child_bus(&dev->qdev, "ide.0");
>          idebus[1] = qdev_get_child_bus(&dev->qdev, "ide.1");
> -    } else {
> +        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +    }
> +#ifdef CONFIG_IDE_ISA
> +else {
>          for(i = 0; i < MAX_IDE_BUS; i++) {
>              ISADevice *dev;
>              char busname[] = "ide.0";
> @@ -268,9 +273,9 @@ static void pc_init1(MachineState *machine,
>              busname[4] = '0' + i;
>              idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>          }
> +        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
>      }
> -
> -    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +#endif
> 
>      if (pcmc->pci_enabled && machine_usb(machine)) {
>          pci_create_simple(pci_bus, piix3_devfn + 2, "piix3-usb-uhci");
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index af2b91f0b8..f1c682e52c 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -29,6 +29,7 @@
> 
>  #include "config-host.h"
>  #ifdef NEED_CPU_H
> +#include "config-devices.h"

So now a Kconfig change will update this header, and all our codebase
depends of "osdep.h", so we'll rebuild the whole project...

However so far only one (which happens to be arch-specific) file
requires this header: pc_piix.c.

If we move this header inclusion in "hw/hw.h", this already reduce the
impact (of invalidating ccache, and so on).

Another (not good enough) idea is to only include it where we need
kconfig definitions to be accessible, this single file?

>  #include "config-target.h"
>  #else
>  #include "exec/poison.h"
> --
> 2.17.2
> 

