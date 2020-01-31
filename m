Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A7E20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNyzQtm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A7E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixdue-0002XE-FT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 16:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ixdtd-0001uX-6H
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ixdtb-0003Gh-AP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:32:13 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ixdtZ-0003Ec-J3; Fri, 31 Jan 2020 16:32:11 -0500
Received: by mail-lj1-x244.google.com with SMTP id d10so8556041ljl.9;
 Fri, 31 Jan 2020 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l5HadxkZUO6OglL267Y8kCsf+6m7GkLY8RoGNVMkSBw=;
 b=BNyzQtm5mYyIY7dIfw4O+lWCAcwgBoX/OZir6kuWW/fQyi3SYHEAfLFnMs7qzmTUas
 9VKp4kkXeHJBWtv8ukP6JrPvuntoa7LHqF+3QxkT1t6TZ+QQojW8W3iwriSM7C0Jd4HP
 S7l+se++VzwZ3hGfc7wTmqnZHXMHzM0Ut/qUjF513SWGni0RXg/acredxgQ8r3gHyMaE
 kQfaVqmUOMTGnTl5IuF+luzlC4glSc1G1KksSVvCNNF+pAF7ehlFQLe7NexlAfIIx+4t
 FeB77r1ASAODTSl26Tu/COtOT5h23v+SJQAX7pk+TpOZcliHPQrOSEksGwZVXT7nPwsB
 CQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l5HadxkZUO6OglL267Y8kCsf+6m7GkLY8RoGNVMkSBw=;
 b=jXwZm5CHD7UWACLjheIViEqM6odev0rtSIH8jipZ3tQ1CWL/yVxUa6FGMID50pQHaw
 7D1877RzmiRXlcGqm3UlnQBV3fPPz3w6hnPbVm6vmuNTGZHI1w/CwumzeE5UwBokshi5
 iSR7LJw24Elc1Ahp4KWGD72GO/GKVFN2PLZubn6K1Cyn0SLVORfZPT7KND5BFg4KCAv6
 0kQ+h934/tdEeWYnAF2kVSNjaxevUmVix9YXkycUiNCR8Gtv4NImKe9DP0XPmvMg3RZs
 Q6yvRr9pysyVfC5k8/BBK85cYXU8WXrzX8P9ekSS4Ku/GCErpkVP6wSMpfQSq3kRJjPP
 rA1Q==
X-Gm-Message-State: APjAAAXLgkzAiQoR2xsBeo9jVoq1tdXJeSWPpKwsJh5AwFNB53ZAownK
 9N8++TfIrTaWNvxi9lPzn4SMd15ZuJdOGUzse0t6eZod
X-Google-Smtp-Source: APXvYqxdTEU7oD8ysQrFsXr358F1OdLQDi4/fhAU+NRbRNY1AMG+YAXdKbQ5tHTw6aQboqqyyu5q/MEbga9tgYFKE+o=
X-Received: by 2002:a2e:7609:: with SMTP id r9mr7093821ljc.238.1580506327990; 
 Fri, 31 Jan 2020 13:32:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <f3bdee4a9bee10980939c37968aa45b406824e48.1575914822.git.alistair.francis@wdc.com>
 <3915816D913D8241BB43E932213F57D4ADBFCED8@dggemm525-mbs.china.huawei.com>
In-Reply-To: <3915816D913D8241BB43E932213F57D4ADBFCED8@dggemm525-mbs.china.huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2020 13:25:04 -0800
Message-ID: <CAKmqyKMxMapawWxqJBv7N0x=JF5ez+Vi+AdNjPxu4tjqp8iYLw@mail.gmail.com>
Subject: Re: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
To: Jiangyifei <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "zhaosiqi \(A\)" <zhaosiqi3@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 12:34 AM Jiangyifei <jiangyifei@huawei.com> wrote:
>
> Hi Alistair,
>
> When I boot a riscv OS (the host) on the QEMU emulator and then boot a
> guest riscv OS in the host. The guest riscv OS fails to boot.
>
> The riscv OS is a linux kernel in the riscv_kvm_v10 branch, the qemu emulator
> is the riscv-hyp-ext-v0.5.next branch.
>
> The QEMU command line:
>     ./qemu-system-riscv64 -M virt -m 4096M -cpu rv64,x-h=true -nographic \
>         -smp 8 \
>         -name guest=riscv-test,debug-threads=on \
>         -kernel ./fw_jump.elf \
>         -device loader,file=./Image,addr=0x80200000 \
>         -drive file=./hyp.img,format=raw,id=hd0 \
>         -device virtio-blk-device,drive=hd0 \
>         -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"
>
> The kvmtool command line:
>     ./lkvm-static run -m 2048 -c2 --console serial -p "console=ttyS0 \
>         earlycon=uart8250,mmio,0x3f8" -k ./Image -d guest.img
>
> The error message is:
>     [   46.136740] kvm [128]: VCPU exit error -14
>     [   46.137967] kvm [128]: SEPC=0x3febbf234e SSTATUS=0x4020 HSTATUS=0x380
>     [   46.140075] kvm [128]: SCAUSE=0x8 STVAL=0x0
>     KVM_RUN failed: Bad address
>
> According to the error message printed by kvm, the exception of Environment
> call from VU-mode should to be delivered to VS-mode, instead of delivered
> to kvm in HS-mode.
>
> The problem is that the FORCE_HS_EXCEP flag is set when there is a pending
> irq that should trap to V==0, but this bit is not cleared in  riscv_cpu_do_interrupt
> when trapping to M-mode. So clearing FORCE_HS_EXCEP flag when trap to
> M-mode. The patch is as follows:
>
> Signed-off-by: Jiang Yifei <jiangyifei@huawei.com>
> ---
> target/riscv/cpu_helper.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7166e61..cb6a1d6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -954,6 +954,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>             /* Trapping to M mode, virt is disabled */
>             riscv_cpu_set_virt_enabled(env, 0);
> +            riscv_cpu_set_force_hs_excep(env, 0);
>         }
>
>         s = *env->mstatus;

Thanks, I think you are correct and I have included this change in my patch.

Alistair

> --
>
> Regards,
> Yifei
>
> > -----Original Message-----
> > From: Qemu-riscv [mailto:qemu-riscv-
> > bounces+jiangyifei=huawei.com@nongnu.org] On Behalf Of Alistair Francis
> > Sent: Tuesday, December 10, 2019 2:12 AM
> > To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> > Cc: alistair.francis@wdc.com; palmer@dabbelt.com; alistair23@gmail.com
> > Subject: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  target/riscv/cpu_helper.c | 65 +++++++++++++++++++++++++++++++++---
> > ---
> >  1 file changed, 55 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c index
> > 1b747abf93..2c6d2bc3a3 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -641,6 +641,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >
> >      RISCVCPU *cpu = RISCV_CPU(cs);
> >      CPURISCVState *env = &cpu->env;
> > +    target_ulong s;
> >
> >      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
> >       * so we mask off the MSB and separate into trap type and cause.
> > @@ -650,13 +651,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      target_ulong deleg = async ? env->mideleg : env->medeleg;
> >      target_ulong tval = 0;
> >
> > -    static const int ecall_cause_map[] = {
> > -        [PRV_U] = RISCV_EXCP_U_ECALL,
> > -        [PRV_S] = RISCV_EXCP_S_ECALL,
> > -        [PRV_H] = RISCV_EXCP_VS_ECALL,
> > -        [PRV_M] = RISCV_EXCP_M_ECALL
> > -    };
> > -
> >      if (!async) {
> >          /* set tval to badaddr for traps with address information */
> >          switch (cause) {
> > @@ -680,7 +674,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >          /* ecall is dispatched as one cause so translate based on mode */
> >          if (cause == RISCV_EXCP_U_ECALL) {
> >              assert(env->priv <= 3);
> > -            cause = ecall_cause_map[env->priv];
> > +
> > +            if (env->priv == PRV_M) {
> > +                cause = RISCV_EXCP_M_ECALL;
> > +            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
> > +                cause = RISCV_EXCP_VS_ECALL;
> > +            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
> > +                cause = RISCV_EXCP_S_ECALL;
> > +            } else if (env->priv == PRV_U) {
> > +                cause = RISCV_EXCP_U_ECALL;
> > +            }
> >          }
> >      }
> >
> > @@ -690,7 +693,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >      if (env->priv <= PRV_S &&
> >              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> >          /* handle the trap in S-mode */
> > -        target_ulong s = *env->mstatus;
> > +        if (riscv_has_ext(env, RVH)) {
> > +            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
> > +
> > +            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
> > +                !riscv_cpu_force_hs_excep_enabled(env)) {
> > +                /* Trap to VS mode */
> > +            } else if (riscv_cpu_virt_enabled(env)) {
> > +                /* Trap into HS mode, from virt */
> > +                riscv_cpu_swap_hypervisor_regs(env);
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> > +                                         get_field(env->hstatus, HSTATUS_SPV));
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> > +                                         get_field(*env->mstatus, SSTATUS_SPP));
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> > +                                         riscv_cpu_virt_enabled(env));
> > +
> > +                riscv_cpu_set_virt_enabled(env, 0);
> > +                riscv_cpu_set_force_hs_excep(env, 0);
> > +            } else {
> > +                /* Trap into HS mode */
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> > +                                         get_field(env->hstatus, HSTATUS_SPV));
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> > +                                         get_field(*env->mstatus, SSTATUS_SPP));
> > +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> > +                                         riscv_cpu_virt_enabled(env));
> > +            }
> > +        }
> > +
> > +        s = *env->mstatus;
> >          s = set_field(s, MSTATUS_SPIE, env->priv_ver >=
> > PRIV_VERSION_1_10_0 ?
> >              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
> >          s = set_field(s, MSTATUS_SPP, env->priv); @@ -704,7 +736,20 @@ void
> > riscv_cpu_do_interrupt(CPUState *cs)
> >          riscv_cpu_set_mode(env, PRV_S);
> >      } else {
> >          /* handle the trap in M-mode */
> > -        target_ulong s = *env->mstatus;
> > +        if (riscv_has_ext(env, RVH)) {
> > +            if (riscv_cpu_virt_enabled(env)) {
> > +                riscv_cpu_swap_hypervisor_regs(env);
> > +            }
> > +            *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
> > +                                      riscv_cpu_virt_enabled(env));
> > +            *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
> > +
> > + riscv_cpu_force_hs_excep_enabled(env));
> > +
> > +            /* Trapping to M mode, virt is disabled */
> > +            riscv_cpu_set_virt_enabled(env, 0);
> > +        }
> > +
> > +        s = *env->mstatus;
> >          s = set_field(s, MSTATUS_MPIE, env->priv_ver >=
> > PRIV_VERSION_1_10_0 ?
> >              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env-
> > >priv));
> >          s = set_field(s, MSTATUS_MPP, env->priv);
> > --
> > 2.24.0
> >
>

