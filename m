Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600A222314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A222314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXIv-0006pC-86
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1itSWT-0003Ij-9b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1itSWP-0002uC-GY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:35:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2430 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1itSWO-0002rT-VE; Mon, 20 Jan 2020 03:34:57 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 791759FEB4CE1A869816;
 Mon, 20 Jan 2020 16:34:49 +0800 (CST)
Received: from DGGEMM525-MBS.china.huawei.com ([169.254.5.80]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Mon, 20 Jan 2020 16:34:39 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: RE: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
Thread-Topic: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
Thread-Index: AQHVrr/CZI5tv9SLhESxVfT7OMDMLafzeTfA
Date: Mon, 20 Jan 2020 08:34:39 +0000
Message-ID: <3915816D913D8241BB43E932213F57D4ADBFCED8@dggemm525-mbs.china.huawei.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <f3bdee4a9bee10980939c37968aa45b406824e48.1575914822.git.alistair.francis@wdc.com>
In-Reply-To: <f3bdee4a9bee10980939c37968aa45b406824e48.1575914822.git.alistair.francis@wdc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.201.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
X-Mailman-Approved-At: Mon, 20 Jan 2020 08:40:08 -0500
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
 "zhaosiqi \(A\)" <zhaosiqi3@huawei.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,=20

When I boot a riscv OS (the host) on the QEMU emulator and then boot a
guest riscv OS in the host. The guest riscv OS fails to boot.=20

The riscv OS is a linux kernel in the riscv_kvm_v10 branch, the qemu emulat=
or
is the riscv-hyp-ext-v0.5.next branch.

The QEMU command line:
    ./qemu-system-riscv64 -M virt -m 4096M -cpu rv64,x-h=3Dtrue -nographic =
\
        -smp 8 \
        -name guest=3Driscv-test,debug-threads=3Don \
        -kernel ./fw_jump.elf \
        -device loader,file=3D./Image,addr=3D0x80200000 \
        -drive file=3D./hyp.img,format=3Draw,id=3Dhd0 \
        -device virtio-blk-device,drive=3Dhd0 \
        -append "root=3D/dev/vda rw console=3DttyS0 earlycon=3Dsbi"

The kvmtool command line:
    ./lkvm-static run -m 2048 -c2 --console serial -p "console=3DttyS0 \
        earlycon=3Duart8250,mmio,0x3f8" -k ./Image -d guest.img

The error message is:
    [   46.136740] kvm [128]: VCPU exit error -14
    [   46.137967] kvm [128]: SEPC=3D0x3febbf234e SSTATUS=3D0x4020 HSTATUS=
=3D0x380
    [   46.140075] kvm [128]: SCAUSE=3D0x8 STVAL=3D0x0
    KVM_RUN failed: Bad address

According to the error message printed by kvm, the exception of Environment
call from VU-mode should to be delivered to VS-mode, instead of delivered
to kvm in HS-mode.

The problem is that the FORCE_HS_EXCEP flag is set when there is a pending
irq that should trap to V=3D=3D0, but this bit is not cleared in  riscv_cpu=
_do_interrupt
when trapping to M-mode. So clearing FORCE_HS_EXCEP flag when trap to
M-mode. The patch is as follows:

Signed-off-by: Jiang Yifei <jiangyifei@huawei.com>
---
target/riscv/cpu_helper.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7166e61..cb6a1d6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -954,6 +954,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)

            /* Trapping to M mode, virt is disabled */
            riscv_cpu_set_virt_enabled(env, 0);
+            riscv_cpu_set_force_hs_excep(env, 0);
        }

        s =3D *env->mstatus;
--

Regards,
Yifei

> -----Original Message-----
> From: Qemu-riscv [mailto:qemu-riscv-
> bounces+jiangyifei=3Dhuawei.com@nongnu.org] On Behalf Of Alistair Francis
> Sent: Tuesday, December 10, 2019 2:12 AM
> To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: alistair.francis@wdc.com; palmer@dabbelt.com; alistair23@gmail.com
> Subject: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu_helper.c | 65 +++++++++++++++++++++++++++++++++---
> ---
>  1 file changed, 55 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c index
> 1b747abf93..2c6d2bc3a3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -641,6 +641,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>=20
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
> +    target_ulong s;
>=20
>      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wi=
de
>       * so we mask off the MSB and separate into trap type and cause.
> @@ -650,13 +651,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong deleg =3D async ? env->mideleg : env->medeleg;
>      target_ulong tval =3D 0;
>=20
> -    static const int ecall_cause_map[] =3D {
> -        [PRV_U] =3D RISCV_EXCP_U_ECALL,
> -        [PRV_S] =3D RISCV_EXCP_S_ECALL,
> -        [PRV_H] =3D RISCV_EXCP_VS_ECALL,
> -        [PRV_M] =3D RISCV_EXCP_M_ECALL
> -    };
> -
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
> @@ -680,7 +674,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          /* ecall is dispatched as one cause so translate based on mode *=
/
>          if (cause =3D=3D RISCV_EXCP_U_ECALL) {
>              assert(env->priv <=3D 3);
> -            cause =3D ecall_cause_map[env->priv];
> +
> +            if (env->priv =3D=3D PRV_M) {
> +                cause =3D RISCV_EXCP_M_ECALL;
> +            } else if (env->priv =3D=3D PRV_S && riscv_cpu_virt_enabled(=
env)) {
> +                cause =3D RISCV_EXCP_VS_ECALL;
> +            } else if (env->priv =3D=3D PRV_S && !riscv_cpu_virt_enabled=
(env)) {
> +                cause =3D RISCV_EXCP_S_ECALL;
> +            } else if (env->priv =3D=3D PRV_U) {
> +                cause =3D RISCV_EXCP_U_ECALL;
> +            }
>          }
>      }
>=20
> @@ -690,7 +693,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (env->priv <=3D PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>          /* handle the trap in S-mode */
> -        target_ulong s =3D *env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            target_ulong hdeleg =3D async ? env->hideleg : env->hedeleg;
> +
> +            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &=
&
> +                !riscv_cpu_force_hs_excep_enabled(env)) {
> +                /* Trap to VS mode */
> +            } else if (riscv_cpu_virt_enabled(env)) {
> +                /* Trap into HS mode, from virt */
> +                riscv_cpu_swap_hypervisor_regs(env);
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS=
_SPV));
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(*env->mstatus, SSTATU=
S_SPP));
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +
> +                riscv_cpu_set_virt_enabled(env, 0);
> +                riscv_cpu_set_force_hs_excep(env, 0);
> +            } else {
> +                /* Trap into HS mode */
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS=
_SPV));
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(*env->mstatus, SSTATU=
S_SPP));
> +                env->hstatus =3D set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +            }
> +        }
> +
> +        s =3D *env->mstatus;
>          s =3D set_field(s, MSTATUS_SPIE, env->priv_ver >=3D
> PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env-=
>priv));
>          s =3D set_field(s, MSTATUS_SPP, env->priv); @@ -704,7 +736,20 @@=
 void
> riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_S);
>      } else {
>          /* handle the trap in M-mode */
> -        target_ulong s =3D *env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            if (riscv_cpu_virt_enabled(env)) {
> +                riscv_cpu_swap_hypervisor_regs(env);
> +            }
> +            *env->mstatus =3D set_field(*env->mstatus, MSTATUS_MPV,
> +                                      riscv_cpu_virt_enabled(env));
> +            *env->mstatus =3D set_field(*env->mstatus, MSTATUS_MTL,
> +
> + riscv_cpu_force_hs_excep_enabled(env));
> +
> +            /* Trapping to M mode, virt is disabled */
> +            riscv_cpu_set_virt_enabled(env, 0);
> +        }
> +
> +        s =3D *env->mstatus;
>          s =3D set_field(s, MSTATUS_MPIE, env->priv_ver >=3D
> PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env-
> >priv));
>          s =3D set_field(s, MSTATUS_MPP, env->priv);
> --
> 2.24.0
>=20


