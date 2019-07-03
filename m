Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B89C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACCF218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACCF218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiWS-00035r-P7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hii26-0006iL-OC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hii21-0000Uf-Gj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:22:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hii1v-0008EL-Rj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:22:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id u18so3536930wru.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6RmxIM4fe5Vl/+TxoqcLq3BIswHoY1GawfaVfbmh8Sk=;
 b=gyVvKD+0RTS4wPuXFpKkzJQQKLGZqu7UMDTytCevimIqUm5wN09PGY5fcGU38EGu0Y
 YW0eqjBJRxIcvJuAATZT+CWAvWzL/GJGbmBBKZOEHCNnrsTMoYyRI1Z1zKxcPJakZx5S
 jSMMLNv02Nj7WOZQlHpZfZtb5zm0Hy7zyCZJopjsY5Hbr/xafcU+ZAawpz8raJoO+c76
 9QMjCGEIRBNt5CgMGgL6PgOlbf4paHkWx3ega1264P9ITNJjFEpymmgjEwXMmLzLYR6A
 MVcBpzGlTCrjtXsMb9bM8JqFgFR+tOGb2X9H04ppoESlWmpAuKCZT/hAglKOMF6wZTFs
 +t1A==
X-Gm-Message-State: APjAAAX/nA0/h5oIzMM3ZQmvWL81szTRJEDYuRc7+ZwWExm9vqmMmin1
 kMfM4ktnxZP8qsnR74hrtgLtvQ==
X-Google-Smtp-Source: APXvYqzQQ1ZamEEBKDdyhV7YCsTC5kJwPxqCUbo9zK/RlyPDuqtIT71T1xrSyehysFaooGjvN097xg==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr31964591wrs.21.1562170890029; 
 Wed, 03 Jul 2019 09:21:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9?
 ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
 by smtp.gmail.com with ESMTPSA id p26sm3759277wrp.58.2019.07.03.09.21.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:21:29 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org
References: <20190703154958.29004-1-julio.montes@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <366f287a-7f83-235c-5141-331117f50bb4@redhat.com>
Date: Wed, 3 Jul 2019 18:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703154958.29004-1-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: sgarzare@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/19 17:49, Julio Montes wrote:
> In pc_init1(), ISA IDE is initialized without checking if ISAPC or IDE_ISA
> configs are enabled. This results in a link error when
> CONFIG_ISAPC is set to 'n' in the file default-configs/i386-softmmu.mak:
> 
> hw/i386/pc_piix.o: In function `pc_init1':
> hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
> hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
> 
> Place ide_isa code under #ifdef CONFIG_IDE_ISA to fix linker errors

But there is nothing that defines CONFIG_IDE_ISA, right?

Paolo

> Signed-off-by: Julio Montes <julio.montes@intel.com>
> ---
>  hw/i386/pc_piix.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
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
> 


