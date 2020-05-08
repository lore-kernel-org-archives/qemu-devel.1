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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFEC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8819C20A8B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnojhARy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8819C20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Wh-0000zg-NB
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1UH-0007sI-DS
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:48:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1UG-0002ve-0s
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:48:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id z72so654713wmc.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bEbkhar1PKZKTQvydL7IrgAmCSnKp8TXDjfEw0RAOKU=;
 b=hnojhARyfP2VjCuc7u7dtwHzwIinK/tDUhSZsObiIsaWQkxEMfUC5xs/eFRRtHyTAa
 yPcaXOf5VknaxyndKN49rS9s++MBhapLdRTr/mWuQ1kK5NoOFBiXlgEsnTNwWv81eVZN
 4NF64wpctxenbma3znQFuQq834UU7kwadR+hS3EPH/c+pPsk9hS1d19RFRVDHz+QcbC7
 7FdezPCFHYRWWJjepYBShOY8Ls55UgsoePhOVYlUwf/eqnh8T49ucDev1QYBa8Zh12Jz
 2rbyHnDLhLSJckQ09zoQHY6Qv1x34h/Zxa2e32HCPRdMf5qA98LDNzDrFyWjHKdP9XJW
 MJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bEbkhar1PKZKTQvydL7IrgAmCSnKp8TXDjfEw0RAOKU=;
 b=bG2Nn1JzKLfGey3baSBDsIrczfman4g2SOqdZunK5sfRUXC5S8rWppaViSChuBAKOI
 BGp6x+q/zRUpVLWnZW4Ke3vIDiquzLqIRUv6j0t0fE7s46pu7WDJJcen76wEAyG7kTMm
 Hr/aIW+dC1GsWYnyz3NtZ2G5fH/J1mdTWpsjIdORHlNkeXbpnrUg+NVkiRTlReyhqjka
 uhwu9IYObDRH+uv+x7GMS0WHLeeFjq/J+u6U6TXQxm8VCRKBERh0/tpOrp7fgAJBOJ98
 EoLjTuWJ82qMHOhJasaIxCh3WfsZXctzEWDHmAiacUNvKivKYd6D+dP5z4i7qvsP4AM8
 MALw==
X-Gm-Message-State: AGi0PuZPBLheUFLO2PvalX5X9wkjt02CryUUbd1cmnZFEzPuf/X3jptX
 N9BvQuiE0TGC4HSaW3NjVyZ53e+/SKU5ohSZe4U=
X-Google-Smtp-Source: APiQypKvpHQOGLMUYf9qoStCJRH2CNNopCBsbQqp/p88v1Z9oJi+hlCyUHqzqLuDshaWLmZLl72j5KRfziFdyAeSbBo=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr16801046wmi.50.1588938493898; 
 Fri, 08 May 2020 04:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-10-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-10-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 13:47:59 +0200
Message-ID: <CAHiYmc6QwSbPspACNJGmzeJ-rJB09NLOyx7W1W5xuaW+HUVhGQ@mail.gmail.com>
Subject: Re: [PATCH V3 09/14] KVM: MIPS: Add more types of virtual interrupts
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

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:13 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> In current implementation, MIPS KVM uses IP2, IP3, IP4 and IP7 for
> external interrupt, two kinds of IPIs and timer interrupt respectively,
> but Loongson-3 based machines prefer to use IP2, IP3, IP6 and IP7 for
> two kinds of external interrupts, IPI and timer interrupt. So we define
> two priority-irq mapping tables: kvm_loongson3_priority_to_irq[] for
> Loongson-3, and kvm_default_priority_to_irq[] for others. The virtual
> interrupt infrastructure is updated to deliver all types of interrupts
> from IP2, IP3, IP4, IP6 and IP7.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kvm/interrupt.c | 93 +++++++----------------------------------=
------
>  arch/mips/kvm/interrupt.h | 14 ++++---
>  arch/mips/kvm/mips.c      | 40 ++++++++++++++++++--
>  arch/mips/kvm/vz.c        | 53 ++++-----------------------
>  4 files changed, 67 insertions(+), 133 deletions(-)
>
> diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
> index 7257e8b6..d28c2c9c 100644
> --- a/arch/mips/kvm/interrupt.c
> +++ b/arch/mips/kvm/interrupt.c
> @@ -61,27 +61,8 @@ void kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu,
>          * the EXC code will be set when we are actually
>          * delivering the interrupt:
>          */
> -       switch (intr) {
> -       case 2:
> -               kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
> -               /* Queue up an INT exception for the core */
> -               kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IO);
> -               break;
> -
> -       case 3:
> -               kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
> -               kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_1);
> -               break;
> -
> -       case 4:
> -               kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
> -               kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_2);
> -               break;
> -
> -       default:
> -               break;
> -       }
> -
> +       kvm_set_c0_guest_cause(vcpu->arch.cop0, 1 << (intr + 8));
> +       kvm_mips_queue_irq(vcpu, kvm_irq_to_priority(intr));
>  }
>
>  void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
> @@ -89,26 +70,8 @@ void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
>  {
>         int intr =3D (int)irq->irq;
>
> -       switch (intr) {
> -       case -2:
> -               kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
> -               kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IO);
> -               break;
> -
> -       case -3:
> -               kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
> -               kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_1);
> -               break;
> -
> -       case -4:
> -               kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
> -               kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_2);
> -               break;
> -
> -       default:
> -               break;
> -       }
> -
> +       kvm_clear_c0_guest_cause(vcpu->arch.cop0, 1 << (-intr + 8));
> +       kvm_mips_dequeue_irq(vcpu, kvm_irq_to_priority(-intr));
>  }
>
>  /* Deliver the interrupt of the corresponding priority, if possible. */
> @@ -116,50 +79,20 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, u=
nsigned int priority,
>                             u32 cause)
>  {
>         int allowed =3D 0;
> -       u32 exccode;
> +       u32 exccode, ie;
>
>         struct kvm_vcpu_arch *arch =3D &vcpu->arch;
>         struct mips_coproc *cop0 =3D vcpu->arch.cop0;
>
> -       switch (priority) {
> -       case MIPS_EXC_INT_TIMER:
> -               if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
> -                   && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0=
_ERL)))
> -                   && (kvm_read_c0_guest_status(cop0) & IE_IRQ5)) {
> -                       allowed =3D 1;
> -                       exccode =3D EXCCODE_INT;
> -               }
> -               break;
> -
> -       case MIPS_EXC_INT_IO:
> -               if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
> -                   && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0=
_ERL)))
> -                   && (kvm_read_c0_guest_status(cop0) & IE_IRQ0)) {
> -                       allowed =3D 1;
> -                       exccode =3D EXCCODE_INT;
> -               }
> -               break;
> -
> -       case MIPS_EXC_INT_IPI_1:
> -               if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
> -                   && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0=
_ERL)))
> -                   && (kvm_read_c0_guest_status(cop0) & IE_IRQ1)) {
> -                       allowed =3D 1;
> -                       exccode =3D EXCCODE_INT;
> -               }
> -               break;
> -
> -       case MIPS_EXC_INT_IPI_2:
> -               if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
> -                   && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0=
_ERL)))
> -                   && (kvm_read_c0_guest_status(cop0) & IE_IRQ2)) {
> -                       allowed =3D 1;
> -                       exccode =3D EXCCODE_INT;
> -               }
> -               break;
> +       if (priority =3D=3D MIPS_EXC_MAX)
> +               return 0;
>
> -       default:
> -               break;
> +       ie =3D 1 << (kvm_priority_to_irq[priority] + 8);
> +       if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
> +           && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
> +           && (kvm_read_c0_guest_status(cop0) & ie)) {
> +               allowed =3D 1;
> +               exccode =3D EXCCODE_INT;
>         }
>
>         /* Are we allowed to deliver the interrupt ??? */
> diff --git a/arch/mips/kvm/interrupt.h b/arch/mips/kvm/interrupt.h
> index 3bf0a49..c3e878c 100644
> --- a/arch/mips/kvm/interrupt.h
> +++ b/arch/mips/kvm/interrupt.h
> @@ -21,11 +21,12 @@
>  #define MIPS_EXC_NMI                5
>  #define MIPS_EXC_MCHK               6
>  #define MIPS_EXC_INT_TIMER          7
> -#define MIPS_EXC_INT_IO             8
> -#define MIPS_EXC_EXECUTE            9
> -#define MIPS_EXC_INT_IPI_1          10
> -#define MIPS_EXC_INT_IPI_2          11
> -#define MIPS_EXC_MAX                12
> +#define MIPS_EXC_INT_IO_1           8
> +#define MIPS_EXC_INT_IO_2           9
> +#define MIPS_EXC_EXECUTE            10
> +#define MIPS_EXC_INT_IPI_1          11
> +#define MIPS_EXC_INT_IPI_2          12
> +#define MIPS_EXC_MAX                13
>  /* XXXSL More to follow */
>
>  #define C_TI        (_ULCAST_(1) << 30)
> @@ -38,6 +39,9 @@
>  #define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (0)
>  #endif
>
> +extern u32 *kvm_priority_to_irq;
> +u32 kvm_irq_to_priority(u32 irq);
> +
>  void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, unsigned int priority);
>  void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, unsigned int priority);
>  int kvm_mips_pending_timer(struct kvm_vcpu *vcpu);
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 8f05dd0..5ca122c 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -489,7 +489,10 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
>         int intr =3D (int)irq->irq;
>         struct kvm_vcpu *dvcpu =3D NULL;
>
> -       if (intr =3D=3D 3 || intr =3D=3D -3 || intr =3D=3D 4 || intr =3D=
=3D -4)
> +       if (intr =3D=3D kvm_priority_to_irq[MIPS_EXC_INT_IPI_1] ||
> +           intr =3D=3D kvm_priority_to_irq[MIPS_EXC_INT_IPI_2] ||
> +           intr =3D=3D (-kvm_priority_to_irq[MIPS_EXC_INT_IPI_1]) ||
> +           intr =3D=3D (-kvm_priority_to_irq[MIPS_EXC_INT_IPI_2]))
>                 kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
>                           (int)intr);
>
> @@ -498,10 +501,10 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
>         else
>                 dvcpu =3D vcpu->kvm->vcpus[irq->cpu];
>
> -       if (intr =3D=3D 2 || intr =3D=3D 3 || intr =3D=3D 4) {
> +       if (intr =3D=3D 2 || intr =3D=3D 3 || intr =3D=3D 4 || intr =3D=
=3D 6) {
>                 kvm_mips_callbacks->queue_io_int(dvcpu, irq);
>
> -       } else if (intr =3D=3D -2 || intr =3D=3D -3 || intr =3D=3D -4) {
> +       } else if (intr =3D=3D -2 || intr =3D=3D -3 || intr =3D=3D -4 || =
intr =3D=3D -6) {
>                 kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
>         } else {
>                 kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__=
,
> @@ -1620,6 +1623,34 @@ static struct notifier_block kvm_mips_csr_die_noti=
fier =3D {
>         .notifier_call =3D kvm_mips_csr_die_notify,
>  };
>
> +static u32 kvm_default_priority_to_irq[MIPS_EXC_MAX] =3D {
> +       [MIPS_EXC_INT_TIMER] =3D C_IRQ5,
> +       [MIPS_EXC_INT_IO_1]  =3D C_IRQ0,
> +       [MIPS_EXC_INT_IPI_1] =3D C_IRQ1,
> +       [MIPS_EXC_INT_IPI_2] =3D C_IRQ2,
> +};
> +
> +static u32 kvm_loongson3_priority_to_irq[MIPS_EXC_MAX] =3D {
> +       [MIPS_EXC_INT_TIMER] =3D C_IRQ5,
> +       [MIPS_EXC_INT_IO_1]  =3D C_IRQ0,
> +       [MIPS_EXC_INT_IO_2]  =3D C_IRQ1,
> +       [MIPS_EXC_INT_IPI_1] =3D C_IRQ4,
> +};
> +
> +u32 *kvm_priority_to_irq =3D kvm_default_priority_to_irq;
> +
> +u32 kvm_irq_to_priority(u32 irq)
> +{
> +       int i;
> +
> +       for (i =3D MIPS_EXC_INT_TIMER; i < MIPS_EXC_MAX; i++) {
> +               if (kvm_priority_to_irq[i] =3D=3D (1 << (irq + 8)))
> +                       return i;
> +       }
> +
> +       return MIPS_EXC_MAX;
> +}
> +
>  static int __init kvm_mips_init(void)
>  {
>         int ret;
> @@ -1638,6 +1669,9 @@ static int __init kvm_mips_init(void)
>         if (ret)
>                 return ret;
>
> +       if (boot_cpu_type() =3D=3D CPU_LOONGSON64)
> +               kvm_priority_to_irq =3D kvm_loongson3_priority_to_irq;
> +
>         register_die_notifier(&kvm_mips_csr_die_notifier);
>
>         return 0;
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index ab320f0..63d5b35 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -225,23 +225,7 @@ static void kvm_vz_queue_io_int_cb(struct kvm_vcpu *=
vcpu,
>          * interrupts are asynchronous to vcpu execution therefore defer =
guest
>          * cp0 accesses
>          */
> -       switch (intr) {
> -       case 2:
> -               kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IO);
> -               break;
> -
> -       case 3:
> -               kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IPI_1);
> -               break;
> -
> -       case 4:
> -               kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IPI_2);
> -               break;
> -
> -       default:
> -               break;
> -       }
> -
> +       kvm_vz_queue_irq(vcpu, kvm_irq_to_priority(intr));
>  }
>
>  static void kvm_vz_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
> @@ -253,44 +237,22 @@ static void kvm_vz_dequeue_io_int_cb(struct kvm_vcp=
u *vcpu,
>          * interrupts are asynchronous to vcpu execution therefore defer =
guest
>          * cp0 accesses
>          */
> -       switch (intr) {
> -       case -2:
> -               kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IO);
> -               break;
> -
> -       case -3:
> -               kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_1);
> -               break;
> -
> -       case -4:
> -               kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_2);
> -               break;
> -
> -       default:
> -               break;
> -       }
> -
> +       kvm_vz_dequeue_irq(vcpu, kvm_irq_to_priority(-intr));
>  }
>
> -static u32 kvm_vz_priority_to_irq[MIPS_EXC_MAX] =3D {
> -       [MIPS_EXC_INT_TIMER] =3D C_IRQ5,
> -       [MIPS_EXC_INT_IO]    =3D C_IRQ0,
> -       [MIPS_EXC_INT_IPI_1] =3D C_IRQ1,
> -       [MIPS_EXC_INT_IPI_2] =3D C_IRQ2,
> -};
> -
>  static int kvm_vz_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int pri=
ority,
>                                  u32 cause)
>  {
>         u32 irq =3D (priority < MIPS_EXC_MAX) ?
> -               kvm_vz_priority_to_irq[priority] : 0;
> +               kvm_priority_to_irq[priority] : 0;
>
>         switch (priority) {
>         case MIPS_EXC_INT_TIMER:
>                 set_gc0_cause(C_TI);
>                 break;
>
> -       case MIPS_EXC_INT_IO:
> +       case MIPS_EXC_INT_IO_1:
> +       case MIPS_EXC_INT_IO_2:
>         case MIPS_EXC_INT_IPI_1:
>         case MIPS_EXC_INT_IPI_2:
>                 if (cpu_has_guestctl2)
> @@ -311,7 +273,7 @@ static int kvm_vz_irq_clear_cb(struct kvm_vcpu *vcpu,=
 unsigned int priority,
>                                u32 cause)
>  {
>         u32 irq =3D (priority < MIPS_EXC_MAX) ?
> -               kvm_vz_priority_to_irq[priority] : 0;
> +               kvm_priority_to_irq[priority] : 0;
>
>         switch (priority) {
>         case MIPS_EXC_INT_TIMER:
> @@ -329,7 +291,8 @@ static int kvm_vz_irq_clear_cb(struct kvm_vcpu *vcpu,=
 unsigned int priority,
>                 }
>                 break;
>
> -       case MIPS_EXC_INT_IO:
> +       case MIPS_EXC_INT_IO_1:
> +       case MIPS_EXC_INT_IO_2:
>         case MIPS_EXC_INT_IPI_1:
>         case MIPS_EXC_INT_IPI_2:
>                 /* Clear GuestCtl2.VIP irq if not using Hardware Clear */
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

