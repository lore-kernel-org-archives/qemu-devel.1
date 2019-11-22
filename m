Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD3C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AD220714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AD220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7wU-00045I-5w
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iY7vV-0003UI-Bv
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iY7vT-0005PQ-Qu
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:20:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iY7vT-0005P7-J0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:20:39 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMCCo12142398
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:20:35 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdqn0p3c7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:20:35 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 22 Nov 2019 12:20:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 12:20:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAMCKTKY38338656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 12:20:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA7A342049;
 Fri, 22 Nov 2019 12:20:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A943E42045;
 Fri, 22 Nov 2019 12:20:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.41.23])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Nov 2019 12:20:27 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove wrappers
Date: Fri, 22 Nov 2019 07:20:19 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4793f8ae-a709-2a41-ea71-4197a026b58a@redhat.com>
References: <4793f8ae-a709-2a41-ea71-4197a026b58a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112212-0016-0000-0000-000002CAC856
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112212-0017-0000-0000-0000332C92FD
Message-Id: <20191122122019.23069-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1015 suspectscore=1 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220111
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That's what it would look like.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu-qom.h | 12 ++++++++----
 target/s390x/cpu.c     | 28 +++++-----------------------
 target/s390x/cpu.h     |  8 +++++---
 target/s390x/sigp.c    |  4 ++--
 4 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index b809ec8418..e8ec999e77 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -34,13 +34,18 @@
 typedef struct S390CPUModel S390CPUModel;
 typedef struct S390CPUDef S390CPUDef;
 
+typedef enum cpu_reset_type {
+    S390_CPU_RESET_NORMAL,
+    S390_CPU_RESET_INITIAL,
+    S390_CPU_RESET_CLEAR,
+} cpu_reset_type;
+
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
  * @load_normal: Performs a load normal.
- * @cpu_reset: Performs a CPU reset.
- * @initial_cpu_reset: Performs an initial CPU reset.
+ * @reset: Performs a CPU reset of a given type.
  *
  * An S/390 CPU model.
  */
@@ -57,8 +62,7 @@ typedef struct S390CPUClass {
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
-    void (*cpu_reset)(CPUState *cpu);
-    void (*initial_cpu_reset)(CPUState *cpu);
+    void (*reset)(CPUState *cpu, cpu_reset_type type);
 } S390CPUClass;
 
 typedef struct S390CPU S390CPU;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 556afecbc1..970495d042 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -82,12 +82,6 @@ static void s390_cpu_load_normal(CPUState *s)
 }
 #endif
 
-typedef enum cpu_reset_type {
-    S390_CPU_RESET_NORMAL,
-    S390_CPU_RESET_INITIAL,
-    S390_CPU_RESET_CLEAR,
-} cpu_reset_type;
-
 static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
 {
     S390CPU *cpu = S390_CPU(s);
@@ -138,21 +132,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
 #endif
 }
 
-static void s390_cpu_reset_normal(CPUState *s)
-{
-    return s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
-}
-
-static void s390_cpu_reset_initial(CPUState *s)
-{
-    return s390_cpu_reset(s, S390_CPU_RESET_INITIAL);
-}
-
-static void s390_cpu_reset_clear(CPUState *s)
-{
-    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static void s390_cpu_machine_reset_cb(void *opaque)
 {
@@ -444,6 +423,11 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void s390_cpu_reset_clear(CPUState *s)
+{
+    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
+}
+
 static void s390_cpu_class_init(ObjectClass *oc, void *data)
 {
     S390CPUClass *scc = S390_CPU_CLASS(oc);
@@ -459,8 +443,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal = s390_cpu_load_normal;
 #endif
-    scc->cpu_reset = s390_cpu_reset_normal;
-    scc->initial_cpu_reset = s390_cpu_reset_initial;
     cc->reset = s390_cpu_reset_clear;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 17460ed7b3..687b31d87e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -734,21 +734,23 @@ static inline uint64_t s390_build_validity_mcic(void)
 
 static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
 {
-    cpu_reset(cs);
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->reset(cs, S390_CPU_RESET_CLEAR);
 }
 
 static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
 
-    scc->cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_CLEAR);
 }
 
 static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
 
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
 }
 
 static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 2ce22d4dc1..727875bb4a 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -254,7 +254,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->initial_cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_INITIAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -266,7 +266,7 @@ static void sigp_cpu_reset(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    scc->cpu_reset(cs);
+    scc->reset(cs, S390_CPU_RESET_NORMAL);
     cpu_synchronize_post_reset(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.20.1


