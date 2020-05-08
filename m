Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE6C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C62420661
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6qD2vZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C62420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX16S-00051g-GL
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX15r-0004ce-Q1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:23:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX15q-0007nf-8K
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:23:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id k12so9792657wmj.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gxTu+BptZNmY+f6nAeoR5hFSnpmhp03FQjB1IrvxGE8=;
 b=o6qD2vZHbIIUEyBdfLY6/WENHdnEusBbe1BoDBsj4mANpRtc4izvSrP/A55E5sXX9g
 +u3IWJw2LGgIsqSo4aIY99QnUciTKNg5GpSipbku8jYfB2KZN2fI0uP9Rm5kQ7bpDrsQ
 sut5t6Wb/ebOG0/kCH1zmCrhngAKloKEc0H0xhznSfXa8eJhdr76LE+jrP937F+Qojt4
 Um9kbNovySvEsY+76GW9jfv24v0K7wHAUHRGcfR0T1A3o40E83m+MYxLmXJ2Q8UB98OF
 wu0rHjqMn8YozbPB3XVnIIBT9sNAYe27J60WOvSCl/CTd49DmBFhu9tWKG2QE8MFD8Wj
 lwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gxTu+BptZNmY+f6nAeoR5hFSnpmhp03FQjB1IrvxGE8=;
 b=H5eOTH/qEs+IQATiPhx9fzbtEOExB7j74dlZNIEBEMz4ZmZbno13cf0hEfaEDDSfZe
 nt+FFSQGGzO8jbEX9Om9YF1QsdInEPLmGI2t6kgLNTfKuBK4raH9iPxvSrxzEayoajaL
 dQpMB3xJl3XpSP6vxgQ6LKGmj4yBKlqKyZV1NmHZNJt43i/fGs4xi0r71Fb95A5o9MJb
 Fagl5RHNomskp/rcOXe1ALZOEBsE3mLKouXMfV000E+soWyJrl4ohMdhMxYDXhg+pML8
 g6YIdpp6SW/oej3Al09OkzKDvcAgL9rL7eTUR4dv8UxrzLznROVuzGMW/zqrGa2+N/av
 I6Qw==
X-Gm-Message-State: AGi0PuZMbAiJ2w995Ps5XzehVsuzs5z4ohONJtle8qR6K81Qm5zMXUIR
 YLLvwZ9cutffaiE6P8zMXHVaJAUjkaLdGNEgukY=
X-Google-Smtp-Source: APiQypJsMmA8yqQyiJQ09LneNrCjpVIT6yT+vc+b2YtHT48Ll207QOPxkDLPKb2X+HB/y7a0diZuxLdAaZXD64GLnQM=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr17208980wmc.168.1588936979875; 
 Fri, 08 May 2020 04:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-11-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-11-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 13:22:39 +0200
Message-ID: <CAHiYmc4S=jH35B4OzfLZ7tVEUn--W3WrLPVnt2tZKbqv9f22WQ@mail.gmail.com>
Subject: Re: [PATCH V3 10/14] KVM: MIPS: Add Loongson-3 Virtual IPI interrupt
 support
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:14 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> This patch add Loongson-3 Virtual IPI interrupt support in the kernel,
> because emulate it in QEMU is too expensive for performance.
>

Huacei, hi!

While, in principle, I support this patch, could you please, just for
the sake of everybody being on the same page, describe the
hyphothetical alternative implementation in QEMU, and explain why it
would be more expensive than the solution proposed in this patch.

No need to go into details, I would like to see just the general idea
you had in your mind.

Yours,
Aleksandar


> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/kvm_host.h |  32 ++++++
>  arch/mips/kvm/Makefile           |   3 +
>  arch/mips/kvm/emulate.c          |  23 ++++-
>  arch/mips/kvm/loongson_ipi.c     | 214 +++++++++++++++++++++++++++++++++=
++++++
>  arch/mips/kvm/mips.c             |   6 ++
>  5 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/kvm/loongson_ipi.c
>
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm=
_host.h
> index a7758c0..f165902 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -23,6 +23,8 @@
>  #include <asm/inst.h>
>  #include <asm/mipsregs.h>
>
> +#include <kvm/iodev.h>
> +
>  /* MIPS KVM register ids */
>  #define MIPS_CP0_32(_R, _S)                                    \
>         (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
> @@ -181,11 +183,39 @@ struct kvm_vcpu_stat {
>  struct kvm_arch_memory_slot {
>  };
>
> +#ifdef CONFIG_CPU_LOONGSON64
> +struct ipi_state {
> +       uint32_t status;
> +       uint32_t en;
> +       uint32_t set;
> +       uint32_t clear;
> +       uint64_t buf[4];
> +};
> +
> +struct loongson_kvm_ipi;
> +
> +struct ipi_io_device {
> +       int node_id;
> +       struct loongson_kvm_ipi *ipi;
> +       struct kvm_io_device device;
> +};
> +
> +struct loongson_kvm_ipi {
> +       spinlock_t lock;
> +       struct kvm *kvm;
> +       struct ipi_state ipistate[16];
> +       struct ipi_io_device dev_ipi[4];
> +};
> +#endif
> +
>  struct kvm_arch {
>         /* Guest physical mm */
>         struct mm_struct gpa_mm;
>         /* Mask of CPUs needing GPA ASID flush */
>         cpumask_t asid_flush_mask;
> +#ifdef CONFIG_CPU_LOONGSON64
> +       struct loongson_kvm_ipi ipi;
> +#endif
>  };
>
>  #define N_MIPS_COPROC_REGS     32
> @@ -1133,6 +1163,8 @@ extern int kvm_mips_trans_mtc0(union mips_instructi=
on inst, u32 *opc,
>  /* Misc */
>  extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
>  extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
> +extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
> +                            struct kvm_mips_interrupt *irq);
>
>  static inline void kvm_arch_hardware_unsetup(void) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> index 0a3cef6..506c4ac 100644
> --- a/arch/mips/kvm/Makefile
> +++ b/arch/mips/kvm/Makefile
> @@ -13,6 +13,9 @@ kvm-objs :=3D $(common-objs-y) mips.o emulate.o entry.o=
 \
>             fpu.o
>  kvm-objs +=3D hypcall.o
>  kvm-objs +=3D mmu.o
> +ifdef CONFIG_CPU_LOONGSON64
> +kvm-objs +=3D loongson_ipi.o
> +endif
>
>  ifdef CONFIG_KVM_MIPS_VZ
>  kvm-objs               +=3D vz.o
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 754094b..3946499 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1600,6 +1600,7 @@ enum emulation_result kvm_mips_emulate_store(union =
mips_instruction inst,
>                                              struct kvm_run *run,
>                                              struct kvm_vcpu *vcpu)
>  {
> +       int r;
>         enum emulation_result er;
>         u32 rt;
>         void *data =3D run->mmio.data;
> @@ -1666,9 +1667,18 @@ enum emulation_result kvm_mips_emulate_store(union=
 mips_instruction inst,
>                 goto out_fail;
>         }
>
> -       run->mmio.is_write =3D 1;
>         vcpu->mmio_needed =3D 1;
> +       run->mmio.is_write =3D 1;
>         vcpu->mmio_is_write =3D 1;
> +
> +       r =3D kvm_io_bus_write(vcpu, KVM_MMIO_BUS,
> +                       run->mmio.phys_addr, run->mmio.len, data);
> +
> +       if (!r) {
> +               vcpu->mmio_needed =3D 0;
> +               return EMULATE_DONE;
> +       }
> +
>         return EMULATE_DO_MMIO;
>
>  out_fail:
> @@ -1681,6 +1691,7 @@ enum emulation_result kvm_mips_emulate_load(union m=
ips_instruction inst,
>                                             u32 cause, struct kvm_run *ru=
n,
>                                             struct kvm_vcpu *vcpu)
>  {
> +       int r;
>         enum emulation_result er;
>         unsigned long curr_pc;
>         u32 op, rt;
> @@ -1745,6 +1756,16 @@ enum emulation_result kvm_mips_emulate_load(union =
mips_instruction inst,
>
>         run->mmio.is_write =3D 0;
>         vcpu->mmio_is_write =3D 0;
> +
> +       r =3D kvm_io_bus_read(vcpu, KVM_MMIO_BUS,
> +                       run->mmio.phys_addr, run->mmio.len, run->mmio.dat=
a);
> +
> +       if (!r) {
> +               kvm_mips_complete_mmio_load(vcpu, run);
> +               vcpu->mmio_needed =3D 0;
> +               return EMULATE_DONE;
> +       }
> +
>         return EMULATE_DO_MMIO;
>  }
>
> diff --git a/arch/mips/kvm/loongson_ipi.c b/arch/mips/kvm/loongson_ipi.c
> new file mode 100644
> index 00000000..3681fc8
> --- /dev/null
> +++ b/arch/mips/kvm/loongson_ipi.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Loongson-3 Virtual IPI interrupt support.
> + *
> + * Copyright (C) 2019  Loongson Technologies, Inc.  All rights reserved.
> + *
> + * Authors: Chen Zhu <zhuchen@loongson.cn>
> + * Authors: Huacai Chen <chenhc@lemote.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#define IPI_BASE            0x3ff01000ULL
> +
> +#define CORE0_STATUS_OFF       0x000
> +#define CORE0_EN_OFF           0x004
> +#define CORE0_SET_OFF          0x008
> +#define CORE0_CLEAR_OFF        0x00c
> +#define CORE0_BUF_20           0x020
> +#define CORE0_BUF_28           0x028
> +#define CORE0_BUF_30           0x030
> +#define CORE0_BUF_38           0x038
> +
> +#define CORE1_STATUS_OFF       0x100
> +#define CORE1_EN_OFF           0x104
> +#define CORE1_SET_OFF          0x108
> +#define CORE1_CLEAR_OFF        0x10c
> +#define CORE1_BUF_20           0x120
> +#define CORE1_BUF_28           0x128
> +#define CORE1_BUF_30           0x130
> +#define CORE1_BUF_38           0x138
> +
> +#define CORE2_STATUS_OFF       0x200
> +#define CORE2_EN_OFF           0x204
> +#define CORE2_SET_OFF          0x208
> +#define CORE2_CLEAR_OFF        0x20c
> +#define CORE2_BUF_20           0x220
> +#define CORE2_BUF_28           0x228
> +#define CORE2_BUF_30           0x230
> +#define CORE2_BUF_38           0x238
> +
> +#define CORE3_STATUS_OFF       0x300
> +#define CORE3_EN_OFF           0x304
> +#define CORE3_SET_OFF          0x308
> +#define CORE3_CLEAR_OFF        0x30c
> +#define CORE3_BUF_20           0x320
> +#define CORE3_BUF_28           0x328
> +#define CORE3_BUF_30           0x330
> +#define CORE3_BUF_38           0x338
> +
> +static int loongson_vipi_read(struct loongson_kvm_ipi *ipi,
> +                               gpa_t addr, int len, void *val)
> +{
> +       uint32_t core =3D (addr >> 8) & 3;
> +       uint32_t node =3D (addr >> 44) & 3;
> +       uint32_t id =3D core + node * 4;
> +       uint64_t offset =3D addr & 0xff;
> +       void *pbuf;
> +       struct ipi_state *s =3D &(ipi->ipistate[id]);
> +
> +       BUG_ON(offset & (len - 1));
> +
> +       switch (offset) {
> +       case CORE0_STATUS_OFF:
> +               *(uint64_t *)val =3D s->status;
> +               break;
> +
> +       case CORE0_EN_OFF:
> +               *(uint64_t *)val =3D s->en;
> +               break;
> +
> +       case CORE0_SET_OFF:
> +               *(uint64_t *)val =3D 0;
> +               break;
> +
> +       case CORE0_CLEAR_OFF:
> +               *(uint64_t *)val =3D 0;
> +               break;
> +
> +       case CORE0_BUF_20 ... CORE0_BUF_38:
> +               pbuf =3D (void *)s->buf + (offset - 0x20);
> +               if (len =3D=3D 8)
> +                       *(uint64_t *)val =3D *(uint64_t *)pbuf;
> +               else /* Assume len =3D=3D 4 */
> +                       *(uint32_t *)val =3D *(uint32_t *)pbuf;
> +               break;
> +
> +       default:
> +               pr_notice("%s with unknown addr %llx\n", __func__, addr);
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int loongson_vipi_write(struct loongson_kvm_ipi *ipi,
> +                               gpa_t addr, int len, const void *val)
> +{
> +       uint32_t core =3D (addr >> 8) & 3;
> +       uint32_t node =3D (addr >> 44) & 3;
> +       uint32_t id =3D core + node * 4;
> +       uint64_t data, offset =3D addr & 0xff;
> +       void *pbuf;
> +       struct kvm *kvm =3D ipi->kvm;
> +       struct kvm_mips_interrupt irq;
> +       struct ipi_state *s =3D &(ipi->ipistate[id]);
> +
> +       data =3D *(uint64_t *)val;
> +       BUG_ON(offset & (len - 1));
> +
> +       switch (offset) {
> +       case CORE0_STATUS_OFF:
> +               break;
> +
> +       case CORE0_EN_OFF:
> +               s->en =3D data;
> +               break;
> +
> +       case CORE0_SET_OFF:
> +               s->status |=3D data;
> +               irq.cpu =3D id;
> +               irq.irq =3D 6;
> +               kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
> +               break;
> +
> +       case CORE0_CLEAR_OFF:
> +               s->status &=3D ~data;
> +               if (!s->status) {
> +                       irq.cpu =3D id;
> +                       irq.irq =3D -6;
> +                       kvm_vcpu_ioctl_interrupt(kvm->vcpus[id], &irq);
> +               }
> +               break;
> +
> +       case CORE0_BUF_20 ... CORE0_BUF_38:
> +               pbuf =3D (void *)s->buf + (offset - 0x20);
> +               if (len =3D=3D 8)
> +                       *(uint64_t *)pbuf =3D (uint64_t)data;
> +               else /* Assume len =3D=3D 4 */
> +                       *(uint32_t *)pbuf =3D (uint32_t)data;
> +               break;
> +
> +       default:
> +               pr_notice("%s with unknown addr %llx\n", __func__, addr);
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int kvm_ipi_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev=
,
> +                       gpa_t addr, int len, void *val)
> +{
> +       unsigned long flags;
> +       struct loongson_kvm_ipi *ipi;
> +       struct ipi_io_device *ipi_device;
> +
> +       ipi_device =3D container_of(dev, struct ipi_io_device, device);
> +       ipi =3D ipi_device->ipi;
> +
> +       spin_lock_irqsave(&ipi->lock, flags);
> +       loongson_vipi_read(ipi, addr, len, val);
> +       spin_unlock_irqrestore(&ipi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int kvm_ipi_write(struct kvm_vcpu *vcpu, struct kvm_io_device *de=
v,
> +                       gpa_t addr, int len, const void *val)
> +{
> +       unsigned long flags;
> +       struct loongson_kvm_ipi *ipi;
> +       struct ipi_io_device *ipi_device;
> +
> +       ipi_device =3D container_of(dev, struct ipi_io_device, device);
> +       ipi =3D ipi_device->ipi;
> +
> +       spin_lock_irqsave(&ipi->lock, flags);
> +       loongson_vipi_write(ipi, addr, len, val);
> +       spin_unlock_irqrestore(&ipi->lock, flags);
> +
> +       return 0;
> +}
> +
> +static const struct kvm_io_device_ops kvm_ipi_ops =3D {
> +       .read     =3D kvm_ipi_read,
> +       .write    =3D kvm_ipi_write,
> +};
> +
> +void kvm_init_loongson_ipi(struct kvm *kvm)
> +{
> +       int i;
> +       unsigned long addr;
> +       struct loongson_kvm_ipi *s;
> +       struct kvm_io_device *device;
> +
> +       s =3D &kvm->arch.ipi;
> +       s->kvm =3D kvm;
> +       spin_lock_init(&s->lock);
> +
> +       /*
> +        * Initialize IPI device
> +        */
> +       for (i =3D 0; i < 4; i++) {
> +               device =3D &s->dev_ipi[i].device;
> +               kvm_iodevice_init(device, &kvm_ipi_ops);
> +               addr =3D (((unsigned long)i) << 44) + IPI_BASE;
> +               mutex_lock(&kvm->slots_lock);
> +               kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, 0x400, d=
evice);
> +               mutex_unlock(&kvm->slots_lock);
> +               s->dev_ipi[i].ipi =3D s;
> +               s->dev_ipi[i].node_id =3D i;
> +       }
> +}
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 5ca122c..ed989ef 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -128,6 +128,8 @@ int kvm_arch_check_processor_compat(void *opaque)
>         return 0;
>  }
>
> +extern void kvm_init_loongson_ipi(struct kvm *kvm);
> +
>  int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
>         switch (type) {
> @@ -147,6 +149,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long =
type)
>         if (!kvm->arch.gpa_mm.pgd)
>                 return -ENOMEM;
>
> +#ifdef CONFIG_CPU_LOONGSON64
> +       kvm_init_loongson_ipi(kvm);
> +#endif
> +
>         return 0;
>  }
>
> --
> 2.7.0
>

