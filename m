Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C966FC28CC6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8385D20866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8385D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcgD-0006FF-M1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:38:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYccE-0002lZ-LU
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYccB-0006D4-1A
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYccA-000613-41; Wed, 05 Jun 2019 16:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECD1A30832C9;
	Wed,  5 Jun 2019 20:34:23 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC1D619A9;
	Wed,  5 Jun 2019 20:34:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:37 +0200
Message-Id: <20190605203403.29461-8-david@redhat.com>
In-Reply-To: <20190605203403.29461-1-david@redhat.com>
References: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 20:34:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 07/33] s390x: Use uint64_t for
 vector registers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU_DoubleU is primarily used to reinterpret between integer and floats.
We don't really need this functionality. So let's just keep it simple
and use an uint64_t.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 linux-user/s390x/signal.c  |   4 +-
 target/s390x/arch_dump.c   |   8 +--
 target/s390x/cpu.h         |   4 +-
 target/s390x/excp_helper.c |   6 +-
 target/s390x/gdbstub.c     |  16 ++---
 target/s390x/helper.c      |  10 +--
 target/s390x/kvm.c         |  16 ++---
 target/s390x/machine.c     | 128 ++++++++++++++++++-------------------
 target/s390x/translate.c   |   2 +-
 9 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index 3d3cb67bbe..ecfa2a14a9 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -123,7 +123,7 @@ static void save_sigregs(CPUS390XState *env, target_s=
igregs *sregs)
      */
     //save_fp_regs(&current->thread.fp_regs); FIXME
     for (i =3D 0; i < 16; i++) {
-        __put_user(get_freg(env, i)->ll, &sregs->fpregs.fprs[i]);
+        __put_user(*get_freg(env, i), &sregs->fpregs.fprs[i]);
     }
 }
=20
@@ -254,7 +254,7 @@ restore_sigregs(CPUS390XState *env, target_sigregs *s=
c)
         __get_user(env->aregs[i], &sc->regs.acrs[i]);
     }
     for (i =3D 0; i < 16; i++) {
-        __get_user(get_freg(env, i)->ll, &sc->fpregs.fprs[i]);
+        __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
     }
=20
     return err;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index c9ef0a6e60..50fa0ae4b6 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -104,7 +104,7 @@ static void s390x_write_elf64_fpregset(Note *note, S3=
90CPU *cpu, int id)
     note->hdr.n_type =3D cpu_to_be32(NT_FPREGSET);
     note->contents.fpregset.fpc =3D cpu_to_be32(cpu->env.fpc);
     for (i =3D 0; i <=3D 15; i++) {
-        note->contents.fpregset.fprs[i] =3D cpu_to_be64(get_freg(cs, i)-=
>ll);
+        note->contents.fpregset.fprs[i] =3D cpu_to_be64(*get_freg(cs, i)=
);
     }
 }
=20
@@ -114,7 +114,7 @@ static void s390x_write_elf64_vregslo(Note *note, S39=
0CPU *cpu,  int id)
=20
     note->hdr.n_type =3D cpu_to_be32(NT_S390_VXRS_LOW);
     for (i =3D 0; i <=3D 15; i++) {
-        note->contents.vregslo.vregs[i] =3D cpu_to_be64(cpu->env.vregs[i=
][1].ll);
+        note->contents.vregslo.vregs[i] =3D cpu_to_be64(cpu->env.vregs[i=
][1]);
     }
 }
=20
@@ -127,8 +127,8 @@ static void s390x_write_elf64_vregshi(Note *note, S39=
0CPU *cpu, int id)
=20
     note->hdr.n_type =3D cpu_to_be32(NT_S390_VXRS_HIGH);
     for (i =3D 0; i <=3D 15; i++) {
-        temp_vregshi->vregs[i][0] =3D cpu_to_be64(cpu->env.vregs[i + 16]=
[0].ll);
-        temp_vregshi->vregs[i][1] =3D cpu_to_be64(cpu->env.vregs[i + 16]=
[1].ll);
+        temp_vregshi->vregs[i][0] =3D cpu_to_be64(cpu->env.vregs[i + 16]=
[0]);
+        temp_vregshi->vregs[i][1] =3D cpu_to_be64(cpu->env.vregs[i + 16]=
[1]);
     }
 }
=20
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1bed12b6c3..317a1377e6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -66,7 +66,7 @@ struct CPUS390XState {
      * The floating point registers are part of the vector registers.
      * vregs[0][0] -> vregs[15][0] are 16 floating point registers
      */
-    CPU_DoubleU vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
+    uint64_t vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
     uint32_t aregs[16];    /* access registers */
     uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
@@ -153,7 +153,7 @@ struct CPUS390XState {
=20
 };
=20
-static inline CPU_DoubleU *get_freg(CPUS390XState *cs, int nr)
+static inline uint64_t *get_freg(CPUS390XState *cs, int nr)
 {
     return &cs->vregs[nr][0];
 }
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3a467b72c5..85223d00c0 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -390,8 +390,8 @@ static int mchk_store_vregs(CPUS390XState *env, uint6=
4_t mcesao)
     }
=20
     for (i =3D 0; i < 32; i++) {
-        sa->vregs[i][0] =3D cpu_to_be64(env->vregs[i][0].ll);
-        sa->vregs[i][1] =3D cpu_to_be64(env->vregs[i][1].ll);
+        sa->vregs[i][0] =3D cpu_to_be64(env->vregs[i][0]);
+        sa->vregs[i][1] =3D cpu_to_be64(env->vregs[i][1]);
     }
=20
     cpu_physical_memory_unmap(sa, len, 1, len);
@@ -429,7 +429,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
     lowcore->ar_access_id =3D 1;
=20
     for (i =3D 0; i < 16; i++) {
-        lowcore->floating_pt_save_area[i] =3D cpu_to_be64(get_freg(env, =
i)->ll);
+        lowcore->floating_pt_save_area[i] =3D cpu_to_be64(*get_freg(env,=
 i));
         lowcore->gpregs_save_area[i] =3D cpu_to_be64(env->regs[i]);
         lowcore->access_regs_save_area[i] =3D cpu_to_be32(env->aregs[i])=
;
         lowcore->cregs_save_area[i] =3D cpu_to_be64(env->cregs[i]);
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index df147596ce..9cfd8fe3e0 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -116,7 +116,7 @@ static int cpu_read_fp_reg(CPUS390XState *env, uint8_=
t *mem_buf, int n)
     case S390_FPC_REGNUM:
         return gdb_get_reg32(mem_buf, env->fpc);
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        return gdb_get_reg64(mem_buf, get_freg(env, n - S390_F0_REGNUM)-=
>ll);
+        return gdb_get_reg64(mem_buf, *get_freg(env, n - S390_F0_REGNUM)=
);
     default:
         return 0;
     }
@@ -129,7 +129,7 @@ static int cpu_write_fp_reg(CPUS390XState *env, uint8=
_t *mem_buf, int n)
         env->fpc =3D ldl_p(mem_buf);
         return 4;
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        get_freg(env, n - S390_F0_REGNUM)->ll =3D ldtul_p(mem_buf);
+        *get_freg(env, n - S390_F0_REGNUM) =3D ldtul_p(mem_buf);
         return 8;
     default:
         return 0;
@@ -150,11 +150,11 @@ static int cpu_read_vreg(CPUS390XState *env, uint8_=
t *mem_buf, int n)
=20
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        ret =3D gdb_get_reg64(mem_buf, env->vregs[n][1].ll);
+        ret =3D gdb_get_reg64(mem_buf, env->vregs[n][1]);
         break;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        ret =3D gdb_get_reg64(mem_buf, env->vregs[n][0].ll);
-        ret +=3D gdb_get_reg64(mem_buf + 8, env->vregs[n][1].ll);
+        ret =3D gdb_get_reg64(mem_buf, env->vregs[n][0]);
+        ret +=3D gdb_get_reg64(mem_buf + 8, env->vregs[n][1]);
         break;
     default:
         ret =3D 0;
@@ -167,11 +167,11 @@ static int cpu_write_vreg(CPUS390XState *env, uint8=
_t *mem_buf, int n)
 {
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        env->vregs[n][1].ll =3D ldtul_p(mem_buf + 8);
+        env->vregs[n][1] =3D ldtul_p(mem_buf + 8);
         return 8;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        env->vregs[n][0].ll =3D ldtul_p(mem_buf);
-        env->vregs[n][1].ll =3D ldtul_p(mem_buf + 8);
+        env->vregs[n][0] =3D ldtul_p(mem_buf);
+        env->vregs[n][1] =3D ldtul_p(mem_buf + 8);
         return 16;
     default:
         return 0;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 3c8f0a7615..a69e5abf5f 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -249,7 +249,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool=
 store_arch)
         cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_i=
d, 1);
     }
     for (i =3D 0; i < 16; ++i) {
-        sa->fprs[i] =3D cpu_to_be64(get_freg(&cpu->env, i)->ll);
+        sa->fprs[i] =3D cpu_to_be64(*get_freg(&cpu->env, i));
     }
     for (i =3D 0; i < 16; ++i) {
         sa->grs[i] =3D cpu_to_be64(cpu->env.regs[i]);
@@ -299,8 +299,8 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr,=
 hwaddr len)
=20
     if (s390_has_feat(S390_FEAT_VECTOR)) {
         for (i =3D 0; i < 32; i++) {
-            sa->vregs[i][0] =3D cpu_to_be64(cpu->env.vregs[i][0].ll);
-            sa->vregs[i][1] =3D cpu_to_be64(cpu->env.vregs[i][1].ll);
+            sa->vregs[i][0] =3D cpu_to_be64(cpu->env.vregs[i][0]);
+            sa->vregs[i][1] =3D cpu_to_be64(cpu->env.vregs[i][1]);
         }
     }
     if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >=3D ADTL_GS_MIN=
_SIZE) {
@@ -341,13 +341,13 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int=
 flags)
         if (s390_has_feat(S390_FEAT_VECTOR)) {
             for (i =3D 0; i < 32; i++) {
                 qemu_fprintf(f, "V%02d=3D%016" PRIx64 "%016" PRIx64 "%c"=
,
-                             i, env->vregs[i][0].ll, env->vregs[i][1].ll=
,
+                             i, env->vregs[i][0], env->vregs[i][1],
                              i % 2 ? '\n' : ' ');
             }
         } else {
             for (i =3D 0; i < 16; i++) {
                 qemu_fprintf(f, "F%02d=3D%016" PRIx64 "%c",
-                             i, get_freg(env, i)->ll,
+                             i, *get_freg(env, i),
                              (i % 4) =3D=3D 3 ? '\n' : ' ');
             }
         }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e5e2b691f2..bcec9795ec 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -418,21 +418,21 @@ int kvm_arch_put_registers(CPUState *cs, int level)
=20
     if (can_sync_regs(cs, KVM_SYNC_VRS)) {
         for (i =3D 0; i < 32; i++) {
-            cs->kvm_run->s.regs.vrs[i][0] =3D env->vregs[i][0].ll;
-            cs->kvm_run->s.regs.vrs[i][1] =3D env->vregs[i][1].ll;
+            cs->kvm_run->s.regs.vrs[i][0] =3D env->vregs[i][0];
+            cs->kvm_run->s.regs.vrs[i][1] =3D env->vregs[i][1];
         }
         cs->kvm_run->s.regs.fpc =3D env->fpc;
         cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_VRS;
     } else if (can_sync_regs(cs, KVM_SYNC_FPRS)) {
         for (i =3D 0; i < 16; i++) {
-            cs->kvm_run->s.regs.fprs[i] =3D get_freg(env, i)->ll;
+            cs->kvm_run->s.regs.fprs[i] =3D *get_freg(env, i);
         }
         cs->kvm_run->s.regs.fpc =3D env->fpc;
         cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_FPRS;
     } else {
         /* Floating point */
         for (i =3D 0; i < 16; i++) {
-            fpu.fprs[i] =3D get_freg(env, i)->ll;
+            fpu.fprs[i] =3D *get_freg(env, i);
         }
         fpu.fpc =3D env->fpc;
=20
@@ -586,13 +586,13 @@ int kvm_arch_get_registers(CPUState *cs)
     /* Floating point and vector registers */
     if (can_sync_regs(cs, KVM_SYNC_VRS)) {
         for (i =3D 0; i < 32; i++) {
-            env->vregs[i][0].ll =3D cs->kvm_run->s.regs.vrs[i][0];
-            env->vregs[i][1].ll =3D cs->kvm_run->s.regs.vrs[i][1];
+            env->vregs[i][0] =3D cs->kvm_run->s.regs.vrs[i][0];
+            env->vregs[i][1] =3D cs->kvm_run->s.regs.vrs[i][1];
         }
         env->fpc =3D cs->kvm_run->s.regs.fpc;
     } else if (can_sync_regs(cs, KVM_SYNC_FPRS)) {
         for (i =3D 0; i < 16; i++) {
-            get_freg(env, i)->ll =3D cs->kvm_run->s.regs.fprs[i];
+            *get_freg(env, i) =3D cs->kvm_run->s.regs.fprs[i];
         }
         env->fpc =3D cs->kvm_run->s.regs.fpc;
     } else {
@@ -601,7 +601,7 @@ int kvm_arch_get_registers(CPUState *cs)
             return r;
         }
         for (i =3D 0; i < 16; i++) {
-            get_freg(env, i)->ll =3D fpu.fprs[i];
+            *get_freg(env, i) =3D fpu.fprs[i];
         }
         env->fpc =3D fpu.fpc;
     }
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index cb792aa103..e6851a57bc 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -66,22 +66,22 @@ static const VMStateDescription vmstate_fpu =3D {
     .minimum_version_id =3D 1,
     .needed =3D fpu_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(env.vregs[0][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[1][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[2][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[3][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[4][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[5][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[6][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[7][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[8][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[9][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[10][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[11][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[12][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[13][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[14][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[15][0].ll, S390CPU),
+        VMSTATE_UINT64(env.vregs[0][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[1][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[2][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[3][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[4][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[5][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[6][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[7][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[8][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[9][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[10][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[11][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[12][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[13][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[14][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[15][0], S390CPU),
         VMSTATE_UINT32(env.fpc, S390CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -99,54 +99,54 @@ static const VMStateDescription vmstate_vregs =3D {
     .needed =3D vregs_needed,
     .fields =3D (VMStateField[]) {
         /* vregs[0][0] -> vregs[15][0] and fregs are overlays */
-        VMSTATE_UINT64(env.vregs[16][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[17][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[18][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[19][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[20][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[21][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[22][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[23][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[24][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[25][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[26][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[27][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[28][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[29][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[30][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[31][0].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[0][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[1][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[2][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[3][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[4][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[5][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[6][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[7][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[8][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[9][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[10][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[11][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[12][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[13][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[14][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[15][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[16][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[17][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[18][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[19][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[20][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[21][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[22][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[23][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[24][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[25][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[26][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[27][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[28][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[29][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[30][1].ll, S390CPU),
-        VMSTATE_UINT64(env.vregs[31][1].ll, S390CPU),
+        VMSTATE_UINT64(env.vregs[16][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[17][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[18][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[19][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[20][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[21][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[22][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[23][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[24][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[25][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[26][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[27][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[28][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[29][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[30][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[31][0], S390CPU),
+        VMSTATE_UINT64(env.vregs[0][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[1][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[2][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[3][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[4][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[5][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[6][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[7][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[8][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[9][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[10][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[11][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[12][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[13][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[14][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[15][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[16][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[17][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[18][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[19][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[20][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[21][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[22][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[23][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[24][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[25][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[26][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[27][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[28][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[29][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[30][1], S390CPU),
+        VMSTATE_UINT64(env.vregs[31][1], S390CPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index fa57b7550e..ac0d8b6410 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -149,7 +149,7 @@ void s390x_translate_init(void)
 static inline int vec_full_reg_offset(uint8_t reg)
 {
     g_assert(reg < 32);
-    return offsetof(CPUS390XState, vregs[reg][0].d);
+    return offsetof(CPUS390XState, vregs[reg][0]);
 }
=20
 static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
--=20
2.21.0


