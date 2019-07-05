Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C280BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9918E216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9918E216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRBu-00048d-VC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjRAa-0003SU-Ee
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjRAZ-0002fd-FF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:34:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjRAZ-0002Yh-8H
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:34:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so9800232wms.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fr2kXBCduSPIsghpXfkFcQnUi2J6tezzdHcEXQiqW7s=;
 b=G5luhCNGAhpfHamWy2w8njK0ZfdiZ+9Lw6X9vk6ruttSqxQ9wxtIVlFoj7XCY/IDGI
 QJvJVlJvfTXtnMY03dm2on5pSWFvlZkcdzLLFxnMV/qg95B5F9tPOC6jx3YGlMVVGBoK
 jb4NPeqev/XzhWypYg8JA6l3+dLyApRQE+VGIKYrIQ9/V3sB/8Q5chvncMh8Y63PtZu9
 wU3QwdvfrQ2Q7mGKXkeCF96QOj0RL9Hypfodwv5ZXdL6Aqln5UjKzvUfrFXlOk2T4Y1E
 OCoYIg8Qz6D+mCYXGUFhwWUoh3Pgk9tcOzB6LBlt/erG8WZHR6qlGQURmQ1zadYz9atw
 QPjg==
X-Gm-Message-State: APjAAAUpLkVLecL4TAYrPVfgJDDXmb8SqAxWIJkvrAcH+xgjgWhggTug
 bHEtrMZx4FhGfTsVzfdwgr9Wpg==
X-Google-Smtp-Source: APXvYqzBFc4ZxfMvtuL2D1VIqqzmxQ9JxGrtgnlQX3OpBGu6aLoB49MOTTc99WVJa+XZkqfZpYou2A==
X-Received: by 2002:a7b:c356:: with SMTP id l22mr4110865wmj.97.1562344481115; 
 Fri, 05 Jul 2019 09:34:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a?
 ([2001:b07:6468:f312:e943:5a4e:e068:244a])
 by smtp.gmail.com with ESMTPSA id z6sm7026708wrw.2.2019.07.05.09.34.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 09:34:40 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org
References: <20190703154958.29004-1-julio.montes@intel.com>
 <20190705143554.10295-1-julio.montes@intel.com>
 <20190705143554.10295-2-julio.montes@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9e3630f-1ce1-2833-8133-336de83faab9@redhat.com>
Date: Fri, 5 Jul 2019 18:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705143554.10295-2-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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
Cc: sgarzare@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/07/19 16:35, Julio Montes wrote:
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
>  #include "config-target.h"
>  #else
>  #include "exec/poison.h"
> --
> 2.17.2
> 

Queued, thanks.

Paolo

