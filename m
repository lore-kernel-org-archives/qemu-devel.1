Received: from eggs.gnu.org ([2001:4830:134:3::10]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ip-0005N2-8l
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8im-00082p-3l
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45810
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8il-000826-VO
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJTh078803
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:59 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyj9209pt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:58 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:57 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:56 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-36-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 35/54] linux-user/signal.c: Rename MC_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The SPARC code in linux-user/signal.c defines a set of
MC_* constants. On some SPARC hosts these are also defined
by sys/ucontext.h, resulting in build failures:

linux-user/signal.c:2786:0: error: "MC_NGREG" redefined [-Werror]
 #define MC_NGREG 19

In file included from /usr/include/signal.h:302:0,
                 from include/qemu/osdep.h:86,
                 from linux-user/signal.c:19:
/usr/include/sparc64-linux-gnu/sys/ucontext.h:59:0: note: this is the location of the previous definition
 # define MC_NGREG __MC_NGREG

Rename all these constants to SPARC_MC_* to avoid the clash.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1517318239-15764-1-git-send-email-peter.maydell@linaro.org
(cherry picked from commit 8ebb314b957403c1c9a3f1cf995f73c6ae9d5d10)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/signal.c | 118 ++++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index cf35473671..b858f1b0f1 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2758,29 +2758,29 @@ long do_rt_sigreturn(CPUSPARCState *env)
 }
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-#define MC_TSTATE 0
-#define MC_PC 1
-#define MC_NPC 2
-#define MC_Y 3
-#define MC_G1 4
-#define MC_G2 5
-#define MC_G3 6
-#define MC_G4 7
-#define MC_G5 8
-#define MC_G6 9
-#define MC_G7 10
-#define MC_O0 11
-#define MC_O1 12
-#define MC_O2 13
-#define MC_O3 14
-#define MC_O4 15
-#define MC_O5 16
-#define MC_O6 17
-#define MC_O7 18
-#define MC_NGREG 19
+#define SPARC_MC_TSTATE 0
+#define SPARC_MC_PC 1
+#define SPARC_MC_NPC 2
+#define SPARC_MC_Y 3
+#define SPARC_MC_G1 4
+#define SPARC_MC_G2 5
+#define SPARC_MC_G3 6
+#define SPARC_MC_G4 7
+#define SPARC_MC_G5 8
+#define SPARC_MC_G6 9
+#define SPARC_MC_G7 10
+#define SPARC_MC_O0 11
+#define SPARC_MC_O1 12
+#define SPARC_MC_O2 13
+#define SPARC_MC_O3 14
+#define SPARC_MC_O4 15
+#define SPARC_MC_O5 16
+#define SPARC_MC_O6 17
+#define SPARC_MC_O7 18
+#define SPARC_MC_NGREG 19
 
 typedef abi_ulong target_mc_greg_t;
-typedef target_mc_greg_t target_mc_gregset_t[MC_NGREG];
+typedef target_mc_greg_t target_mc_gregset_t[SPARC_MC_NGREG];
 
 struct target_mc_fq {
     abi_ulong *mcfq_addr;
@@ -2840,8 +2840,8 @@ void sparc64_set_context(CPUSPARCState *env)
         goto do_sigsegv;
     }
     grp  = &ucp->tuc_mcontext.mc_gregs;
-    __get_user(pc, &((*grp)[MC_PC]));
-    __get_user(npc, &((*grp)[MC_NPC]));
+    __get_user(pc, &((*grp)[SPARC_MC_PC]));
+    __get_user(npc, &((*grp)[SPARC_MC_NPC]));
     if ((pc | npc) & 3) {
         goto do_sigsegv;
     }
@@ -2864,26 +2864,26 @@ void sparc64_set_context(CPUSPARCState *env)
     }
     env->pc = pc;
     env->npc = npc;
-    __get_user(env->y, &((*grp)[MC_Y]));
-    __get_user(tstate, &((*grp)[MC_TSTATE]));
+    __get_user(env->y, &((*grp)[SPARC_MC_Y]));
+    __get_user(tstate, &((*grp)[SPARC_MC_TSTATE]));
     env->asi = (tstate >> 24) & 0xff;
     cpu_put_ccr(env, tstate >> 32);
     cpu_put_cwp64(env, tstate & 0x1f);
-    __get_user(env->gregs[1], (&(*grp)[MC_G1]));
-    __get_user(env->gregs[2], (&(*grp)[MC_G2]));
-    __get_user(env->gregs[3], (&(*grp)[MC_G3]));
-    __get_user(env->gregs[4], (&(*grp)[MC_G4]));
-    __get_user(env->gregs[5], (&(*grp)[MC_G5]));
-    __get_user(env->gregs[6], (&(*grp)[MC_G6]));
-    __get_user(env->gregs[7], (&(*grp)[MC_G7]));
-    __get_user(env->regwptr[UREG_I0], (&(*grp)[MC_O0]));
-    __get_user(env->regwptr[UREG_I1], (&(*grp)[MC_O1]));
-    __get_user(env->regwptr[UREG_I2], (&(*grp)[MC_O2]));
-    __get_user(env->regwptr[UREG_I3], (&(*grp)[MC_O3]));
-    __get_user(env->regwptr[UREG_I4], (&(*grp)[MC_O4]));
-    __get_user(env->regwptr[UREG_I5], (&(*grp)[MC_O5]));
-    __get_user(env->regwptr[UREG_I6], (&(*grp)[MC_O6]));
-    __get_user(env->regwptr[UREG_I7], (&(*grp)[MC_O7]));
+    __get_user(env->gregs[1], (&(*grp)[SPARC_MC_G1]));
+    __get_user(env->gregs[2], (&(*grp)[SPARC_MC_G2]));
+    __get_user(env->gregs[3], (&(*grp)[SPARC_MC_G3]));
+    __get_user(env->gregs[4], (&(*grp)[SPARC_MC_G4]));
+    __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
+    __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
+    __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
+    __get_user(env->regwptr[UREG_I0], (&(*grp)[SPARC_MC_O0]));
+    __get_user(env->regwptr[UREG_I1], (&(*grp)[SPARC_MC_O1]));
+    __get_user(env->regwptr[UREG_I2], (&(*grp)[SPARC_MC_O2]));
+    __get_user(env->regwptr[UREG_I3], (&(*grp)[SPARC_MC_O3]));
+    __get_user(env->regwptr[UREG_I4], (&(*grp)[SPARC_MC_O4]));
+    __get_user(env->regwptr[UREG_I5], (&(*grp)[SPARC_MC_O5]));
+    __get_user(env->regwptr[UREG_I6], (&(*grp)[SPARC_MC_O6]));
+    __get_user(env->regwptr[UREG_I7], (&(*grp)[SPARC_MC_O7]));
 
     __get_user(fp, &(ucp->tuc_mcontext.mc_fp));
     __get_user(i7, &(ucp->tuc_mcontext.mc_i7));
@@ -2971,25 +2971,25 @@ void sparc64_get_context(CPUSPARCState *env)
     }
 
     /* XXX: tstate must be saved properly */
-    //    __put_user(env->tstate, &((*grp)[MC_TSTATE]));
-    __put_user(env->pc, &((*grp)[MC_PC]));
-    __put_user(env->npc, &((*grp)[MC_NPC]));
-    __put_user(env->y, &((*grp)[MC_Y]));
-    __put_user(env->gregs[1], &((*grp)[MC_G1]));
-    __put_user(env->gregs[2], &((*grp)[MC_G2]));
-    __put_user(env->gregs[3], &((*grp)[MC_G3]));
-    __put_user(env->gregs[4], &((*grp)[MC_G4]));
-    __put_user(env->gregs[5], &((*grp)[MC_G5]));
-    __put_user(env->gregs[6], &((*grp)[MC_G6]));
-    __put_user(env->gregs[7], &((*grp)[MC_G7]));
-    __put_user(env->regwptr[UREG_I0], &((*grp)[MC_O0]));
-    __put_user(env->regwptr[UREG_I1], &((*grp)[MC_O1]));
-    __put_user(env->regwptr[UREG_I2], &((*grp)[MC_O2]));
-    __put_user(env->regwptr[UREG_I3], &((*grp)[MC_O3]));
-    __put_user(env->regwptr[UREG_I4], &((*grp)[MC_O4]));
-    __put_user(env->regwptr[UREG_I5], &((*grp)[MC_O5]));
-    __put_user(env->regwptr[UREG_I6], &((*grp)[MC_O6]));
-    __put_user(env->regwptr[UREG_I7], &((*grp)[MC_O7]));
+    //    __put_user(env->tstate, &((*grp)[SPARC_MC_TSTATE]));
+    __put_user(env->pc, &((*grp)[SPARC_MC_PC]));
+    __put_user(env->npc, &((*grp)[SPARC_MC_NPC]));
+    __put_user(env->y, &((*grp)[SPARC_MC_Y]));
+    __put_user(env->gregs[1], &((*grp)[SPARC_MC_G1]));
+    __put_user(env->gregs[2], &((*grp)[SPARC_MC_G2]));
+    __put_user(env->gregs[3], &((*grp)[SPARC_MC_G3]));
+    __put_user(env->gregs[4], &((*grp)[SPARC_MC_G4]));
+    __put_user(env->gregs[5], &((*grp)[SPARC_MC_G5]));
+    __put_user(env->gregs[6], &((*grp)[SPARC_MC_G6]));
+    __put_user(env->gregs[7], &((*grp)[SPARC_MC_G7]));
+    __put_user(env->regwptr[UREG_I0], &((*grp)[SPARC_MC_O0]));
+    __put_user(env->regwptr[UREG_I1], &((*grp)[SPARC_MC_O1]));
+    __put_user(env->regwptr[UREG_I2], &((*grp)[SPARC_MC_O2]));
+    __put_user(env->regwptr[UREG_I3], &((*grp)[SPARC_MC_O3]));
+    __put_user(env->regwptr[UREG_I4], &((*grp)[SPARC_MC_O4]));
+    __put_user(env->regwptr[UREG_I5], &((*grp)[SPARC_MC_O5]));
+    __put_user(env->regwptr[UREG_I6], &((*grp)[SPARC_MC_O6]));
+    __put_user(env->regwptr[UREG_I7], &((*grp)[SPARC_MC_O7]));
 
     w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
     fp = i7 = 0;
-- 
2.11.0
