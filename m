Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913A3C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6847420693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 04:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnEgV-0002dQ-HC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 00:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joserz@linux.ibm.com>) id 1hnEgK-00026W-1u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joserz@linux.ibm.com>) id 1hnEgI-0002QX-Ix
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:03:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13710
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joserz@linux.ibm.com>)
 id 1hnEgI-0002Ow-DU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 00:03:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6G41tcq079611
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:03:07 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ts25a9cdk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:03:07 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <joserz@linux.ibm.com>;
 Tue, 16 Jul 2019 05:03:06 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Jul 2019 05:03:05 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6G434bs56361416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 04:03:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15E7D7805F;
 Tue, 16 Jul 2019 04:03:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9CF7805C;
 Tue, 16 Jul 2019 04:03:02 +0000 (GMT)
Received: from pacoca.ibmuc.com (unknown [9.85.146.78])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 04:03:02 +0000 (GMT)
From: Jose Ricardo Ziviani <joserz@linux.ibm.com>
To: qemu-ppc@nongnu.org
Date: Tue, 16 Jul 2019 01:02:53 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071604-0016-0000-0000-000009CE0CE0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011436; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01232818; UDB=6.00649544; IPR=6.01014127; 
 MB=3.00027735; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-16 04:03:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071604-0017-0000-0000-00004407A026
Message-Id: <20190716040253.23490-1-joserz@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160050
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] ppc: Improve SMT experience with TCG accel
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's not possible to specify the number of threads of a guest when
running QEMU/TCG. Today, users can have setups like:

... -accel tcg,thread=multi -smp 8,threads=1,cores=8 ...
or
... -accel tcg,thread=multi -smp 8,sockets=2,cores=4,threads=1 ...

However, the following is not possible:

... -accel tcg,thread=multi -smp 16,threads=4,cores=2,sockets=2 ...
qemu-system-ppc64: TCG cannot support more than 1 thread/core on a pseries machine

The reason is due to how SMT is implemented since Power8. This patch
implements a very basic simulation of the msgsndp instruction, using ext
interrupt instead of doorbells. The result is a better user experience,
allowing them to play with SMT modes. However, it doesn't relate with
MTTCG threads in any way.

Results:
... -accel tcg,thread=multi -smp 16,threads=4,cores=2,sockets=2 ...

root@ubuntu:~# ppc64_cpu --smt
SMT=4
root@ubuntu:~# ppc64_cpu --info
Core   0:    0*    1*    2*    3*
Core   1:    4*    5*    6*    7*
Core   2:    8*    9*   10*   11*
Core   3:   12*   13*   14*   15*
root@ubuntu:~# ppc64_cpu --smt=2
root@ubuntu:~# ppc64_cpu --info
Core   0:    0*    1*    2     3
Core   1:    4*    5*    6     7
Core   2:    8*    9*   10    11
Core   3:   12*   13*   14    15
root@ubuntu:~# ppc64_cpu --smt=off
root@ubuntu:~# ppc64_cpu --info
Core   0:    0*    1     2     3
Core   1:    4*    5     6     7
Core   2:    8*    9    10    11
Core   3:   12*   13    14    15

root@ubuntu:~# ppc64_cpu --smt
SMT is off
root@ubuntu:~# lscpu
Architecture:         ppc64le
Byte Order:           Little Endian
CPU(s):               16
On-line CPU(s) list:  0,4,8,12
Off-line CPU(s) list: 1-3,5-7,9-11,13-15
Thread(s) per core:   1
Core(s) per socket:   2
Socket(s):            2
NUMA node(s):         1
Model:                2.0 (pvr 004e 1200)
Model name:           POWER9 (architected), altivec supported
Hypervisor vendor:    KVM
Virtualization type:  para
L1d cache:            32K
L1i cache:            32K
NUMA node0 CPU(s):    0,4,8,12

root@ubuntu:~# ppc64_cpu --smt=4
root@ubuntu:~# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              16
On-line CPU(s) list: 0-15
Thread(s) per core:  4
Core(s) per socket:  2
Socket(s):           2
NUMA node(s):        1
Model:               2.0 (pvr 004e 1200)
Model name:          POWER9 (architected), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           32K
L1i cache:           32K
NUMA node0 CPU(s):   0-15

Note: it's also possible to simulate SMT in TCG single threaded mode.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
---
 hw/ppc/spapr.c           |  5 -----
 target/ppc/excp_helper.c | 24 ++++++++++++++++++++++++
 target/ppc/helper.h      |  1 +
 target/ppc/translate.c   | 11 +++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8783b43396..3a864dfc7d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2572,11 +2572,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (!kvm_enabled() && (smp_threads > 1)) {
-        error_setg(&local_err, "TCG cannot support more than 1 thread/core "
-                     "on a pseries machine");
-        goto out;
-    }
     if (!is_power_of_2(smp_threads)) {
         error_setg(&local_err, "Cannot support %d threads/core on a pseries "
                      "machine because it must be a power of 2", smp_threads);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 50b004d00d..ac5d196641 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1231,6 +1231,30 @@ static int book3s_dbell2irq(target_ulong rb)
     return msg == DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL : -1;
 }
 
+void helper_msgsndp(target_ulong rb)
+{
+    CPUState *cs;
+    int irq = rb & DBELL_TYPE_MASK;
+    int thread_id = rb & 0x3f;
+
+    if (irq != DBELL_TYPE_DBELL_SERVER) {
+        return;
+    }
+
+    qemu_mutex_lock_iothread();
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+        if (cpu->vcpu_id == thread_id) {
+            continue;
+        }
+
+        cpu->env.pending_interrupts |= 1 << PPC_INTERRUPT_EXT;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+    qemu_mutex_unlock_iothread();
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     int irq = book3s_dbell2irq(rb);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 380c9b1e2a..eadd08324b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -630,6 +630,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(602_mfrom, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_1(msgsnd, void, tl)
+DEF_HELPER_1(msgsndp, void, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
 DEF_HELPER_1(book3s_msgsnd, void, tl)
 DEF_HELPER_2(book3s_msgclr, void, env, tl)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28036..083731292b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6657,6 +6657,15 @@ static void gen_msgsnd(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
+static void gen_msgsndp(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    gen_helper_msgsndp(cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
 static void gen_msgsync(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -7176,6 +7185,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
                PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER2_E(msgsnd, "msgsnd", 0x1F, 0x0E, 0x06, 0x03ff0001,
                PPC_NONE, PPC2_PRCNTL),
+GEN_HANDLER2_E(msgsndp, "msgsndp", 0x1F, 0x0E, 0x04, 0x03ff0001,
+               PPC_NONE, PPC_POWER),
 GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07, 0x03ff0001,
                PPC_NONE, PPC2_PRCNTL),
 GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,
-- 
2.21.0


