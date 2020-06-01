Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D94C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F294206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwoQq5Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F294206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhUj-0005zm-PU
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhU5-0005ZF-Be
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:15:57 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhU3-0007le-5q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:15:57 -0400
Received: by mail-ej1-x644.google.com with SMTP id z5so8714211ejb.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UOnkjTRjCT/pIju6vypRqyHeNEoIr7vkJue17/ffWvU=;
 b=jwoQq5Yy4w040P53669ZNL5bIWwZ910Bmz76Wi3Ubtx8xT4EfWEtZkVXklwu305Kag
 ovG9zwPmP/zafsg+xPaJfNFkeK4hQuHwhWYz7nfgmVQ+ndjrwEBlHrDec+AnAw0gGAd8
 knDifeLuWrIb6HdIQ7wb0cFHW2vlbhDDBYKA/e2bz6SYfCt7rsjylabiFU4graKk05SJ
 hz30+Ulx4pMfDO+Ew/JK8nbrhbDYtHgEIqgiSF0ESQxdS4i3EyEV2o2VYaKEkkN1svl3
 DMzJIu53uz5oZXkwyDJqTK58DHRFXrAH08+jkBb7mSmpnrtdxqGmLeuS5bq1+eEebxPz
 viAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UOnkjTRjCT/pIju6vypRqyHeNEoIr7vkJue17/ffWvU=;
 b=PYAAw/xqp3GSRe0mOYyknqLybFmwq7R1WJWD1/MPJLt+/mZP34sOBB567p3CPc/jYJ
 MukkdjgLPtHPjEYiIWfjz9RA48xKmUhAkdTrTWbR4jxjlEMoySHZiRuiE9ocfU+1zNV6
 Ic16MD6j5uRMpyhQtNG7fonuqu5RBTDO5K3t28mQLlefZDQYaxOSJ7SRvQ0jK/axqXlm
 LBKmQRciXO4UTfvdG+nEOJ6PbsXbAutpNZ9K4AMqk2PON57BXmZcUYEsMSENp2Id7AAs
 aeShZLtPKoqj41Y7oSejpe6bo8T6G2BhE58wZkkb0rRnssppWTHMrLDmSyAMBQoq8To4
 WXfA==
X-Gm-Message-State: AOAM531nk3lfpPWkkZP8bLoznwjdKn3a3MDK0ZwbnhzkMhk57romvM76
 rrU9OgZg64tu0ZP6j72WkWD/6f6rEdHqpHNAq5w=
X-Google-Smtp-Source: ABdhPJz4aCIC21GBSilBq3JzNuuOxuNkKyLsSCR/dJKbg2SjJntcwAMTfou8P8acvq/+e2iLkqYDOil13d80wohENR0=
X-Received: by 2002:a17:906:46d3:: with SMTP id
 k19mr19452766ejs.349.1591006553534; 
 Mon, 01 Jun 2020 03:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-3-git-send-email-chenhc@lemote.com>
 <CAL1e-=hVq4eSoh8pr5sOykJe9kP0-xjEybwFWPb7m5nWh34RVw@mail.gmail.com>
In-Reply-To: <CAL1e-=hVq4eSoh8pr5sOykJe9kP0-xjEybwFWPb7m5nWh34RVw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 12:15:42 +0200
Message-ID: <CAL1e-=jG0nAce7Un6WYAwA50v+qaOcWvfMEsWWeKY1VE4jUgfw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 2/7] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 11:01 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Sun, May 3, 2020 at 12:24 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
> >
> > MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> > can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
> > MachineClass. Besides, libvirt uses a null-machine to detect the kvm
> > capability, so by default it will return "KVM not supported" on a VZ
> > platform. Thus, null-machine also need the kvm_type() hook.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
>
> Applied to MIPS queue.
>

Huacai,

There were some problems during integration of this patch that I do
before any pull request. I will for now omit it from the pull request I
plan to send today. I leave to you to integrate the patch in some future
series of yours, the one that will complete KVM support for Loongson 3.

In other words, this patch is "unapplied" to MIPS queue.

Best Regards,
Aleksandar

> Best Regards,
> Aleksandar
>
> >  hw/core/Makefile.objs  |  2 +-
> >  hw/core/null-machine.c |  4 ++++
> >  hw/mips/Makefile.objs  |  2 +-
> >  hw/mips/common.c       | 31 +++++++++++++++++++++++++++++++
> >  include/hw/mips/mips.h |  3 +++
> >  5 files changed, 40 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/mips/common.c
> >
> > diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > index 1d540ed..b5672f4 100644
> > --- a/hw/core/Makefile.objs
> > +++ b/hw/core/Makefile.objs
> > @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
> >  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
> >  common-obj-$(CONFIG_SOFTMMU) += sysbus.o
> >  common-obj-$(CONFIG_SOFTMMU) += machine.o
> > -common-obj-$(CONFIG_SOFTMMU) += null-machine.o
> >  common-obj-$(CONFIG_SOFTMMU) += loader.o
> >  common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
> >  common-obj-$(CONFIG_SOFTMMU) += numa.o
> >  common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
> > +obj-$(CONFIG_SOFTMMU) += null-machine.o
> >  obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
> >
> >  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
> > diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > index cb47d9d..94a36f9 100644
> > --- a/hw/core/null-machine.c
> > +++ b/hw/core/null-machine.c
> > @@ -17,6 +17,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "exec/address-spaces.h"
> >  #include "hw/core/cpu.h"
> > +#include "hw/mips/mips.h"
> >
> >  static void machine_none_init(MachineState *mch)
> >  {
> > @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)
> >      mc->max_cpus = 1;
> >      mc->default_ram_size = 0;
> >      mc->default_ram_id = "ram";
> > +#ifdef TARGET_MIPS
> > +    mc->kvm_type = mips_kvm_type;
> > +#endif
> >  }
> >
> >  DEFINE_MACHINE("none", machine_none_machine_init)
> > diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> > index 525809a..2f7795b 100644
> > --- a/hw/mips/Makefile.objs
> > +++ b/hw/mips/Makefile.objs
> > @@ -1,4 +1,4 @@
> > -obj-y += addr.o mips_int.o
> > +obj-y += addr.o common.o mips_int.o
> >  obj-$(CONFIG_R4K) += mips_r4k.o
> >  obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
> >  obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
> > diff --git a/hw/mips/common.c b/hw/mips/common.c
> > new file mode 100644
> > index 0000000..0e33bd0
> > --- /dev/null
> > +++ b/hw/mips/common.c
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Common MIPS routines
> > + *
> > + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
> > + * This code is licensed under the GNU GPL v2.
> > + */
> > +
> > +#include <linux/kvm.h>
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "hw/boards.h"
> > +#include "hw/mips/mips.h"
> > +#include "sysemu/kvm_int.h"
> > +
> > +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > +{
> > +    int r;
> > +    KVMState *s = KVM_STATE(machine->accelerator);
> > +
> > +    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> > +    if (r > 0) {
> > +        return KVM_VM_MIPS_VZ;
> > +    }
> > +
> > +    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
> > +    if (r > 0) {
> > +        return KVM_VM_MIPS_TE;
> > +    }
> > +
> > +    return -1;
> > +}
> > diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> > index 0af4c3d..2ac0580 100644
> > --- a/include/hw/mips/mips.h
> > +++ b/include/hw/mips/mips.h
> > @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);
> >
> >  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
> >
> > +/* common.c */
> > +int mips_kvm_type(MachineState *machine, const char *vm_type);
> > +
> >  #endif
> > --
> > 2.7.0
> >
> >

