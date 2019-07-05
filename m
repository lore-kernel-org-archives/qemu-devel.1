Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43306C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B36F218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36F218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjJYI-0000Rr-Dw
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 04:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjJXR-0007zt-2l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjJXP-0008Q4-UG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:25:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjJXP-0008PM-ON
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:25:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so6926435wmd.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 01:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ijr9xB0HmlC16hfv500/PucNjrTmQyG4jNm1zULTIH4=;
 b=kxwIvN2nARdAGHc1Fdc95WQ2T/bdp4Q2AUs4A2V35XGD2bSSNdlpKtIGrq2CIOlhb5
 P6QpoLGubf3Bbo3qtuDUBKODa0A4Tjot/gCcd0pjr4c5iOcR8uAeD0/0+piDGCIzV+xL
 femJiEwAutRpIr9KbP4OSEn7DMe2Uuh7aS7E5F3j8hlgL0rw5KqIsoyHBeiDcFCU2bMP
 m6yJvjs+Be1sin5/nE4LXHKztFqHpvRERON1udEOb0DjroHRJom66xLIUh8dNNDFqUyB
 3vbiVBWWYrxcllulAubJMrfo36PUcblLlYRzj0qCQn5hJYXJ/maNRsC8gf4dKBGr0cNY
 jfWQ==
X-Gm-Message-State: APjAAAXoFIDMpdzhtjshX64ExKWoWz0iyIphKvIqKbxv7rVUXpu0mbj3
 45c+WjKP2rca8+I4NRCEbfk5x2QQRy4=
X-Google-Smtp-Source: APXvYqyBstV+XdwAaphyeXvf2R1/2rmpOykK2ATEAnT0KJOwjDcZ+ntxVuZ1Shb3KtrhHb2uCR+H9A==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr2296706wme.145.1562315146473; 
 Fri, 05 Jul 2019 01:25:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id k63sm9222989wmb.2.2019.07.05.01.25.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 01:25:45 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org
References: <be6aa304-a8e4-d64a-432f-24d52e42c097@redhat.com>
 <20190704180350.2086-1-julio.montes@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ee9e6cd-52fd-af5b-f2d3-ac2881c27d11@redhat.com>
Date: Fri, 5 Jul 2019 10:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704180350.2086-1-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 20:03, Julio Montes wrote:
> How about a new header file with all devices? (see below patch)

Yes, looks good.

Paolo

> ---
>  Makefile.target       |  5 +++++
>  hw/i386/pc_piix.c     | 11 ++++++++---
>  include/qemu/osdep.h  |  1 +
>  scripts/create_config |  2 ++
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.target b/Makefile.target
> index a6919e0caf..65eda0994d 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -45,6 +45,9 @@ include $(SRC_PATH)/tests/tcg/Makefile.include
>  config-target.h: config-target.h-timestamp
>  config-target.h-timestamp: config-target.mak
> 
> +config-devices.h: config-devices.h-timestamp
> +config-devices.h-timestamp: config-devices.mak
> +
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp
> 
> @@ -170,6 +173,8 @@ generated-files-y += hmp-commands.h hmp-commands-info.h
> 
>  endif # CONFIG_SOFTMMU
> 
> +generated-files-y += config-devices.h
> +
>  dummy := $(call unnest-vars,,obj-y)
>  all-obj-y := $(obj-y)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c07c4a5b38..b93f9327be 100644
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
> index af2b91f0b8..83b49a1e63 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -30,6 +30,7 @@
>  #include "config-host.h"
>  #ifdef NEED_CPU_H
>  #include "config-target.h"
> +#include "config-devices.h"
>  #else
>  #include "exec/poison.h"
>  #endif
> diff --git a/scripts/create_config b/scripts/create_config
> index d727e5e36e..00e86c82b0 100755
> --- a/scripts/create_config
> +++ b/scripts/create_config
> @@ -58,6 +58,8 @@ case $line in
>      name=${line%=*}
>      echo "#define $name 1"
>      ;;
> + CONFIG_*=n) # configuration
> +    ;;
>   CONFIG_*=*) # configuration
>      name=${line%=*}
>      value=${line#*=}
> --
> 2.17.2
> 


