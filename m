Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA1C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08643207DD
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08643207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXKGz-0004vf-5w
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jXKGI-00043q-17
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:51:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jXKGF-0005fZ-Oh
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:51:05 -0400
Received: by mail-io1-f65.google.com with SMTP id w4so4181468ioc.6
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 00:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=irClNz9HSFAI1UNO3+C6yA0USjnQWlAtgelkX/UdCY4=;
 b=aHPNWjxsgmGZ6l0lJ36xTDlHirkAWzuRtQbpMXpwP+NxeWCiB7VmMVo4bdbME3hRKc
 ma0IOLEFaOKTCvRuWBb/DxFTogjAHvcQbHWi0Qq3As2XhoHfUg2IJ/AsyLhqspRQ/GWj
 IiNGTGBZg7ZQhUDavPby2PH8WjTRFniT83DgiTx/5iLzTQb3lr8Dtx//I17hnNi81J6p
 uOo9l/ZZpBUkN6TjnGdMVUtD6KtkPQquVitcimrc3L8jd+qxsYNCivJmpGhNxU7NtnzI
 XRQHkyONF30LUYsqQ8GNjOyIoZnVhWIdAk0QPnYw8thSWyHOE9aTLkCKvlcMqlbif63W
 YXtw==
X-Gm-Message-State: AGi0PubMgv/LTsYzEl1pXk/BwFT++tWYK1IswysKrJdLXD4+g7RBs+Ns
 lFdwRk4SkZgQ500s7oaSAf9VKXTc/e3uBkpzeVc=
X-Google-Smtp-Source: APiQypKeSaQFn8SgcsCXCIgVVn768wqzxxuDa8fF7T+W07efG9KiaOCVSZVpyLTbwnmN3U1MwS2ehqdSGLjx170C8hw=
X-Received: by 2002:a02:966a:: with SMTP id c97mr6416395jai.106.1589010662407; 
 Sat, 09 May 2020 00:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-11-git-send-email-chenhc@lemote.com>
 <CAHiYmc4S=jH35B4OzfLZ7tVEUn--W3WrLPVnt2tZKbqv9f22WQ@mail.gmail.com>
In-Reply-To: <CAHiYmc4S=jH35B4OzfLZ7tVEUn--W3WrLPVnt2tZKbqv9f22WQ@mail.gmail.com>
From: Huacai Chen <chenhc@lemote.com>
Date: Sat, 9 May 2020 15:58:42 +0800
Message-ID: <CAAhV-H4O=RE7nAou=jetL7sjTVN4WVX_EPH6uEkCf8vmApEm0g@mail.gmail.com>
Subject: Re: [PATCH V3 10/14] KVM: MIPS: Add Loongson-3 Virtual IPI interrupt
 support
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.65; envelope-from=chenhuacai@gmail.com;
 helo=mail-io1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 03:51:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm <kvm@vger.kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:MIPS" <linux-mips@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Fri, May 8, 2020 at 7:23 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:14 Huacai Chen =
<chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE=
/=D0=BB=D0=B0:
> >
> > This patch add Loongson-3 Virtual IPI interrupt support in the kernel,
> > because emulate it in QEMU is too expensive for performance.
> >
>
> Huacei, hi!
>
> While, in principle, I support this patch, could you please, just for
> the sake of everybody being on the same page, describe the
> hyphothetical alternative implementation in QEMU, and explain why it
> would be more expensive than the solution proposed in this patch.
>
> No need to go into details, I would like to see just the general idea
> you had in your mind.
The current implementation of IPI emulation in QEMU is based on GIC for
MIPS, but Loongson-3 doesn't use GIC. Furthermore, IPI emulation in QEMU
is too expensive for performance (because of too many context switches
between Host and Guest). With current solution, the IPI delay may even
cause RCU stall warnings in a multi-core Guest. So, we design a faster
solution that emulate IPI interrupt in kernel (only used by Loongson-3
now).


Huacai


>
> Yours,
> Aleksandar
>
>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  arch/mips/include/asm/kvm_host.h |  32 ++++++
> >  arch/mips/kvm/Makefile           |   3 +
> >  arch/mips/kvm/emulate.c          |  23 ++++-
> >  arch/mips/kvm/loongson_ipi.c     | 214 +++++++++++++++++++++++++++++++=
++++++++
> >  arch/mips/kvm/mips.c             |   6 ++
> >  5 files changed, 277 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/mips/kvm/loongson_ipi.c
> >
> > diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/k=
vm_host.h
> > index a7758c0..f165902 100644
> > --- a/arch/mips/include/asm/kvm_host.h
> > +++ b/arch/mips/include/asm/kvm_host.h
> > @@ -23,6 +23,8 @@
> >  #include <asm/inst.h>
> >  #include <asm/mipsregs.h>
> >
> > +#include <kvm/iodev.h>
> > +
> >  /* MIPS KVM register ids */
> >  #define MIPS_CP0_32(_R, _S)                                    \
> >         (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
> > @@ -181,11 +183,39 @@ struct kvm_vcpu_stat {
> >  struct kvm_arch_memory_slot {
> >  };
> >
> > +#ifdef CONFIG_CPU_LOONGSON64
> > +struct ipi_state {
> > +       uint32_t status;
> > +       uint32_t en;
> > +       uint32_t set;
> > +       uint32_t clear;
> > +       uint64_t buf[4];
> > +};
> > +
> > +struct loongson_kvm_ipi;
> > +
> > +struct ipi_io_device {
> > +       int node_id;
> > +       struct loongson_kvm_ipi *ipi;
> > +       struct kvm_io_device device;
> > +};
> > +
> > +struct loongson_kvm_ipi {
> > +       spinlock_t lock;
> > +       struct kvm *kvm;
> > +       struct ipi_state ipistate[16];
> > +       struct ipi_io_device dev_ipi[4];
> > +};
> > +#endif
> > +
> >  struct kvm_arch {
> >         /* Guest physical mm */
> >         struct mm_struct gpa_mm;
> >         /* Mask of CPUs needing GPA ASID flush */
> >         cpumask_t asid_flush_mask;
> > +#ifdef CONFIG_CPU_LOONGSON64
> > +       struct loongson_kvm_ipi ipi;
> > +#endif
> >  };
> >
> >  #define N_MIPS_COPROC_REGS     32
> > @@ -1133,6 +1163,8 @@ extern int kvm_mips_trans_mtc0(union mips_instruc=
tion inst, u32 *opc,
> >  /* Misc */
> >  extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
> >  extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
> > +extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
> > +                            struct kvm_mips_interrupt *irq);
> >
> >  static inline void kvm_arch_hardware_unsetup(void) {}
> >  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> > diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> > index 0a3cef6..506c4ac 100644
> > --- a/arch/mips/kvm/Makefile
> > +++ b/arch/mips/kvm/Makefile
> > @@ -13,6 +13,9 @@ kvm-objs :=3D $(common-objs-y) mips.o emulate.o entry=
.o \
> >             fpu.o
> >  kvm-objs +=3D hypcall.o
> >  kvm-objs +=3D mmu.o
> > +ifdef CONFIG_CPU_LOONGSON64
> > +kvm-objs +=3D loongson_ipi.o
> > +endif
> >
> >  ifdef CONFIG_KVM_MIPS_VZ
> >  kvm-objs               +=3D vz.o
> > diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> > index 754094b..3946499 100644
> > --- a/arch/mips/kvm/emulate.c
> > +++ b/arch/mips/kvm/emulate.c
> > @@ -1600,6 +1600,7 @@ enum emulation_result kvm_mips_emulate_store(unio=
n mips_instruction inst,
> >                                              struct kvm_run *run,
> >                                              struct kvm_vcpu *vcpu)
> >  {
> > +       int r;
> >         enum emulation_result er;
> >         u32 rt;
> >         void *data =3D run->mmio.data;
> > @@ -1666,9 +1667,18 @@ enum emulation_result kvm_mips_emulate_store(uni=
on mips_instruction inst,
> >                 goto out_fail;
> >         }
> >
> > -       run->mmio.is_write =3D 1;
> >         vcpu->mmio_needed =3D 1;
> > +       run->mmio.is_write =3D 1;
> >         vcpu->mmio_is_write =3D 1;
> > +
> > +       r =3D kvm_io_bus_write(vcpu, KVM_MMIO_BUS,
> > +                       run->mmio.phys_addr, run->mmio.len, data);
> > +
> > +       if (!r) {
> > +               vcpu->mmio_needed =3D 0;
> > +               return EMULATE_DONE;
> > +       }
> > +
> >         return EMULATE_DO_MMIO;
> >
> >  out_fail:
> > @@ -1681,6 +1691,7 @@ enum emulation_result kvm_mips_emulate_load(union=
 mips_instruction inst,
> >                                             u32 cause, struct kvm_run *=
run,
> >                                             struct kvm_vcpu *vcpu)
> >  {
> > +       int r;
> >         enum emulation_result er;
> >         unsigned long curr_pc;
> >         u32 op, rt;
> > @@ -1745,6 +1756,16 @@ enum emulation_result kvm_mips_emulate_load(unio=
n mips_instruction inst,
> >
> >         run->mmio.is_write =3D 0;
> >         vcpu->mmio_is_write =3D 0;
> > +
> > +       r =3D kvm_io_bus_read(vcpu, KVM_MMIO_BUS,
> > +                       run->mmio.phys_addr, run->mmio.len, run->mmio.d=
ata);
> > +
> > +       if (!r) {
> > +               kvm_mips_complete_mmio_load(vcpu, run);
> > +               vcpu->mmio_needed =3D 0;
> > +               return EMULATE_DONE;
> > +       }
> > +
> >         return EMULATE_DO_MMIO;
> >  }
> >
> > diff --git a/arch/mips/kvm/loongson_ipi.c b/arch/mips/kvm/loongson_ipi.=
c
> > new file mode 100644
> > index 00000000..3681fc8
> > --- /dev/null
> > +++ b/arch/mips/kvm/loongson_ipi.c
> > @@ -0,0 +1,214 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Loongson-3 Virtual IPI interrupt support.
> > + *
> > + * Copyright (C) 2019  Loongson Technologies, Inc.  All rights reserve=
d.
> > + *
> > + * Authors: Chen Zhu <zhuchen@loongson.cn>
> > + * Authors: Huacai Chen <chenhc@lemote.com>
> > + */
> > +
> > +#include <linux/kvm_host.h>
> > +
> > +#define IPI_BASE            0x3ff01000ULL
> > +
> > +#define CORE0_STATUS_OFF       0x000
> > +#define CORE0_EN_OFF           0x004
> > +#define CORE0_SET_OFF          0x008
> > +#define CORE0_CLEAR_OFF        0x00c
> > +#define CORE0_BUF_20           0x020
> > +#define CORE0_BUF_28           0x028
> > +#define CORE0_BUF_30           0x030
> > +#define CORE0_BUF_38           0x038
> > +
> > +#define CORE1_STATUS_OFF       0x100
> > +#define CORE1_EN_OFF           0x104
> > +#define CORE1_SET_OFF          0x108
> > +#define CORE1_CLEAR_OFF        0x10c
> > +#define CORE1_BUF_20           0x120
> > +#define CORE1_BUF_28           0x128
> > +#define CORE1_BUF_30           0x130
> > +#define CORE1_BUF_38           0x138
> > +
> > +#define CORE2_STATUS_OFF       0x200
> > +#define CORE2_EN_OFF           0x204
> > +#define CORE2_SET_OFF          0x208
> > +#define CORE2_CLEAR_OFF        0x20c
> > +#define CORE2_BUF_20           0x220
> > +#define CORE2_BUF_28           0x228
> > +#define CORE2_BUF_30           0x230
> > +#define CORE2_BUF_38           0x238
> > +
> > +#define CORE3_STATUS_OFF       0x300
> > +#define CORE3_EN_OFF           0x304
> > +#define CORE3_SET_OFF          0x308
> > +#define CORE3_CLEAR_OFF        0x30c
> > +#define CORE3_BUF_20           0x320
> > +#define CORE3_BUF_28           0x328
> > +#define CORE3_BUF_30           0x330
> > +#define CORE3_BUF_38           0x338
> > +
> > +static int loongson_vipi_read(struct loongson_kvm_ipi *ipi,
> > +                               gpa_t addr, int len, void *val)
> > +{
> > +       uint32_t core =3D (addr >> 8) & 3;
> > +       uint32_t node =3D (addr >> 44) & 3;
> > +       uint32_t id =3D core + node * 4;
> > +       uint64_t offset =3D addr & 0xff;
> > +       void *pbuf;
> > +       struct ipi_state *s =3D &(ipi->ipistate[id]);
> > +
> > +       BUG_ON(offset & (len - 1));
> > +
> > +       switch (offset) {
> > +       case CORE0_STATUS_OFF:
> > +               *(uint64_t *)val =3D s->status;
> > +               break;
> > +
> > +       case CORE0_EN_OFF:
> > +               *(uint64_t *)val =3D s->en;
> > +               break;
> > +
> > +       case CORE0_SET_OFF:
> > +               *(uint64_t *)val =3D 0;
> > +               break;
> > +
> > +       case CORE0_CLEAR_OFF:
> > +               *(uint64_t *)val =3D 0;
> > +               break;
> > +
> > +       case CORE0_BUF_20 ... CORE0_BUF_38:
> > +               pbuf =3D (void *)s->buf + (offset - 0x20);
> > +               if (len =3D=3D 8)
> > +                       *(uint64_t *)val =3D *(uint64_t *)pbuf;
> > +               else /* Assume len =3D=3D 4 */
> > +                       *(uint32_t *)val =3D *(uint32_t *)pbuf;
> > +               break;
> > +
> > +       default:
> > +               pr_notice("%s with unknown addr %llx\n", __func__, addr=
);
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int loongson_vipi_write(struct loongson_kvm_ipi *ipi,
> > +                               gpa_t addr, int len, const void *val)
> > +{
> > +       uint32_t core =3D (addr >> 8) & 3;
> > +       uint32_t node =3D (addr >> 44) & 3;
> > +       uint32_t id =3D core + node * 4;
> > +       uint64_t data, offset =3D addr & 0xff;
> > +       void *pbuf;
> > +       struct kvm *kvm =3D ipi->kvm;
> > +       struct kvm_mips_interrupt irq;
> > +       struct ipi_state *s =3D &(ipi->ipistate[id]);
> > +
> > +       data =3D *(uint64_t *)val;
> > +       BUG_ON(offset & (len - 1));
> > +
> > +       switch (offset) {
> > +       case CORE0_STATUS_OFF:
> > +               break;
> > +
> > +       case CORE0_EN_OFF:
> > +               s->en =3D data;
> > +               break;
> > +
> > +       case CORE0_SET_OFF:
> > +               s->status |=3D data;
> > +               irq.cpu =3D id;
> > +               irq.irq =3D 6;
> > +               kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
> > +               break;
> > +
> > +       case CORE0_CLEAR_OFF:
> > +               s->status &=3D ~data;
> > +               if (!s->status) {
> > +                       irq.cpu =3D id;
> > +                       irq.irq =3D -6;
> > +                       kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
> > +               }
> > +               break;
> > +
> > +       case CORE0_BUF_20 ... CORE0_BUF_38:
> > +               pbuf =3D (void *)s->buf + (offset - 0x20);
> > +               if (len =3D=3D 8)
> > +                       *(uint64_t *)pbuf =3D (uint64_t)data;
> > +               else /* Assume len =3D=3D 4 */
> > +                       *(uint32_t *)pbuf =3D (uint32_t)data;
> > +               break;
> > +
> > +       default:
> > +               pr_notice("%s with unknown addr %llx\n", __func__, addr=
);
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int kvm_ipi_read(struct kvm_vcpu *vcpu, struct kvm_io_device *d=
ev,
> > +                       gpa_t addr, int len, void *val)
> > +{
> > +       unsigned long flags;
> > +       struct loongson_kvm_ipi *ipi;
> > +       struct ipi_io_device *ipi_device;
> > +
> > +       ipi_device =3D container_of(dev, struct ipi_io_device, device);
> > +       ipi =3D ipi_device->ipi;
> > +
> > +       spin_lock_irqsave(&ipi->lock, flags);
> > +       loongson_vipi_read(ipi, addr, len, val);
> > +       spin_unlock_irqrestore(&ipi->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +static int kvm_ipi_write(struct kvm_vcpu *vcpu, struct kvm_io_device *=
dev,
> > +                       gpa_t addr, int len, const void *val)
> > +{
> > +       unsigned long flags;
> > +       struct loongson_kvm_ipi *ipi;
> > +       struct ipi_io_device *ipi_device;
> > +
> > +       ipi_device =3D container_of(dev, struct ipi_io_device, device);
> > +       ipi =3D ipi_device->ipi;
> > +
> > +       spin_lock_irqsave(&ipi->lock, flags);
> > +       loongson_vipi_write(ipi, addr, len, val);
> > +       spin_unlock_irqrestore(&ipi->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct kvm_io_device_ops kvm_ipi_ops =3D {
> > +       .read     =3D kvm_ipi_read,
> > +       .write    =3D kvm_ipi_write,
> > +};
> > +
> > +void kvm_init_loongson_ipi(struct kvm *kvm)
> > +{
> > +       int i;
> > +       unsigned long addr;
> > +       struct loongson_kvm_ipi *s;
> > +       struct kvm_io_device *device;
> > +
> > +       s =3D &kvm->arch.ipi;
> > +       s->kvm =3D kvm;
> > +       spin_lock_init(&s->lock);
> > +
> > +       /*
> > +        * Initialize IPI device
> > +        */
> > +       for (i =3D 0; i < 4; i++) {
> > +               device =3D &s->dev_ipi[i].device;
> > +               kvm_iodevice_init(device, &kvm_ipi_ops);
> > +               addr =3D (((unsigned long)i) << 44) + IPI_BASE;
> > +               mutex_lock(&kvm->slots_lock);
> > +               kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, 0x400,=
 device);
> > +               mutex_unlock(&kvm->slots_lock);
> > +               s->dev_ipi[i].ipi =3D s;
> > +               s->dev_ipi[i].node_id =3D i;
> > +       }
> > +}
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index 5ca122c..ed989ef 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -128,6 +128,8 @@ int kvm_arch_check_processor_compat(void *opaque)
> >         return 0;
> >  }
> >
> > +extern void kvm_init_loongson_ipi(struct kvm *kvm);
> > +
> >  int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >  {
> >         switch (type) {
> > @@ -147,6 +149,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lon=
g type)
> >         if (!kvm->arch.gpa_mm.pgd)
> >                 return -ENOMEM;
> >
> > +#ifdef CONFIG_CPU_LOONGSON64
> > +       kvm_init_loongson_ipi(kvm);
> > +#endif
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.7.0
> >

