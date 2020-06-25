Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0E720781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9ynXya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0E720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRwt-00062q-DC
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joRtX-0008Nc-Lk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:26:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joRtV-00043h-SP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:26:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id a6so5844758wrm.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3PVUrT7AAMHSp1vHR0x+g2NXZ59AfA192lAQwIjVj7Q=;
 b=rI9ynXyaudQAVBSju2Zf1FbR9ta4BSwK+i8Z2I/5vr98jfn5s2vHvRWaJQBwSQODb4
 SEpb88TJXsSk2ySD34bqc3tcDXuSSSSYS6ivgHipUmyFgPrvlkwFY0PpseOOQ7dwYOuM
 YhSQSosd4ltdJ6O170bsbsZekingeqbBb60jS58nHhm40ibs668IH1MGMs5OLbI20/3D
 DGdpzITOYue3i35NnKrf8pjvcp1nVrEq0dr6RVdnNWjd2XvFIxROs95A36/uhQWTXop3
 MtBs9eatocv/gwp/tjS01IkhC+tOep0PYLbNNuGQ47YyIILa+DhbDVFSP2agR15m8HgV
 GIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3PVUrT7AAMHSp1vHR0x+g2NXZ59AfA192lAQwIjVj7Q=;
 b=X0/I/BRJ4efIU51LzHvuHX0K70ugsAOMjvI6M2I1xD4GML9pYquXYw7/Q0klcNsPpI
 JTgPxj2yrbPis2jMT0vH0y8atiAYVeNC4IE8Z2SSLIVS/TF4T/2qTblT+SAng2sbTjlY
 Fr7TvTnNtDIEsF0CNfB5P1Y+/gd6dZgA5dFrJ26kLSfR2vS4VHR4xXM0ggsUnQyBg3ai
 7TXvwJDRbXbpEXfC9mGIz0xF9HoQWgIDs9TiAL4wo8+s9HoTzDproD47Coid+R6AcRJu
 7gxWjKy7orF4oemBk48q7+pqBavSXXmWjkmk+EWWng/YKtlgRuFAKmwh5lhz65iNNG2v
 mnrA==
X-Gm-Message-State: AOAM533IAxds8DSAXp9+O6EHNwbiWANt5XFRmZOy1xzBPmYXMhY12+eX
 aMAA5rlhxT5rElz8ztfRcgRmQupoxU8eybfpQbI=
X-Google-Smtp-Source: ABdhPJwG8srjPM/jIm0I2tqKsJMwAvWvLKZeHIaAmsDaylMUDyXvkKmFmrU3YwazwEV37MXfUGvZhq7qL0+VSq+3yro=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr36003392wrv.162.1593091580201; 
 Thu, 25 Jun 2020 06:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
 <1592995531-32600-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5ZbZSyMxevp-Ta1fWsY67yt6S_bhoHr5CGYPWN=KTLbQ@mail.gmail.com>
In-Reply-To: <CAHiYmc5ZbZSyMxevp-Ta1fWsY67yt6S_bhoHr5CGYPWN=KTLbQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 15:25:53 +0200
Message-ID: <CAHiYmc5My0AZZBV2EDqYOYmoonW-gmwkXaxXh0N6di8GHTvzxQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 25. =D1=98=D1=83=D0=BD 2020. =D1=83 14:31 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=81=D1=80=D0=B5, 24. =D1=98=D1=83=D0=BD 2020. =D1=83 12:44 Huacai Chen=
 <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
> >
> > MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> > can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
> > MachineClass. This patch add the the kvm_type() hook to support both of
> > the two types.
> >
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  target/mips/kvm.c      | 20 ++++++++++++++++++++
> >  target/mips/kvm_mips.h | 11 +++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> > index 96cfa10..373f582 100644
> > --- a/target/mips/kvm.c
> > +++ b/target/mips/kvm.c
> > @@ -21,10 +21,12 @@
> >  #include "qemu/main-loop.h"
> >  #include "qemu/timer.h"
> >  #include "sysemu/kvm.h"
> > +#include "sysemu/kvm_int.h"
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/cpus.h"
> >  #include "kvm_mips.h"
> >  #include "exec/memattrs.h"
> > +#include "hw/boards.h"
> >
> >  #define DEBUG_KVM 0
> >
> > @@ -1270,3 +1272,21 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >  {
> >      abort();
> >  }
> > +
> > +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > +{
> > +    int r;
> > +    KVMState *s =3D KVM_STATE(machine->accelerator);
> > +
> > +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);
>
> This will not work for build systems with kernel < 4.12. You need to
> provide fallback solution for that case.
>

I am perhaps wrong here. If we pull the preprocessor constants from
imported Linux headers, than we don;t need host kernel headers
supporting KVM_CAP_MIPS_VZ. I will doublecheck.

Thanks, Aleksandar

> > +    if (r > 0) {
> > +        return KVM_VM_MIPS_VZ;
> > +    }
> > +
> > +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
> > +    if (r > 0) {
> > +        return KVM_VM_MIPS_TE;
> > +    }
> > +
> > +    return -1;
> > +}
> > diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
> > index 1e40147..171d53d 100644
> > --- a/target/mips/kvm_mips.h
> > +++ b/target/mips/kvm_mips.h
> > @@ -12,6 +12,8 @@
> >  #ifndef KVM_MIPS_H
> >  #define KVM_MIPS_H
> >
> > +#include "cpu.h"
> > +
> >  /**
> >   * kvm_mips_reset_vcpu:
> >   * @cpu: MIPSCPU
> > @@ -23,4 +25,13 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu);
> >  int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
> >  int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
> >
> > +#ifdef CONFIG_KVM
> > +int mips_kvm_type(MachineState *machine, const char *vm_type);
> > +#else
> > +static inline int mips_kvm_type(MachineState *machine, const char *vm_=
type)
> > +{
> > +    return 0;
> > +}
> > +#endif
> > +
> >  #endif /* KVM_MIPS_H */
> > --
> > 2.7.0
> >

