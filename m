Received: from eggs.gnu.org ([209.51.188.92]:38473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VJ-00057A-Ll
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VI-0002x5-Ac
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VI-0002uu-0I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hrE9017507
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:54 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9y5ugjw0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:54 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:49 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:12 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-7-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/19] target/ppc: Remove some #if 0'ed code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Some debug stuff we don't need to keep there

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/excp_helper.c | 12 ------------
 target/ppc/mmu_helper.c  | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0ec7ae1ad4ce..751d759fcc1d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -748,13 +748,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
 static void ppc_hw_interrupt(CPUPPCState *env)
 {
     PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
-#if 0
-    CPUState *cs =3D CPU(cpu);
=20
-    qemu_log_mask(CPU_LOG_INT, "%s: %p pending %08x req %08x me %d ee %d=
\n",
-                  __func__, env, env->pending_interrupts,
-                  cs->interrupt_request, (int)msr_me, (int)msr_ee);
-#endif
     /* External reset */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
         env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_RESET);
@@ -797,12 +791,6 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     if (msr_ce !=3D 0) {
         /* External critical interrupt */
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_CEXT)) {
-            /* Taking a critical external interrupt does not clear the e=
xternal
-             * critical interrupt status
-             */
-#if 0
-            env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_CEXT);
-#endif
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_CRITICAL);
             return;
         }
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index cefed34da4f2..bcf19da61d56 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1415,10 +1415,6 @@ static int get_physical_address_wtlb(
     bool real_mode =3D (access_type =3D=3D ACCESS_CODE && msr_ir =3D=3D =
0)
         || (access_type !=3D ACCESS_CODE && msr_dr =3D=3D 0);
=20
-#if 0
-    qemu_log("%s\n", __func__);
-#endif
-
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
@@ -1468,10 +1464,6 @@ static int get_physical_address_wtlb(
         cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
         return -1;
     }
-#if 0
-    qemu_log("%s address " TARGET_FMT_lx " =3D> %d " TARGET_FMT_plx "\n"=
,
-             __func__, eaddr, ret, ctx->raddr);
-#endif
=20
     return ret;
 }
@@ -1805,10 +1797,6 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *e=
nv, target_ulong address,
                 break;
             }
         }
-#if 0
-        printf("%s: set exception to %d %02x\n", __func__,
-               cs->exception, env->error_code);
-#endif
         ret =3D 1;
     }
=20
--=20
2.20.1
