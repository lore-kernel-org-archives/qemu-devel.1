Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51431C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281B1217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281B1217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8EE-0006ZD-T4
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45995)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1ho8E1-00061W-0E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ho8Dz-00085w-M4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ho8Dz-000841-As
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:21:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6IFF372045513
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 11:21:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tttfntk77-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 11:21:36 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 18 Jul 2019 16:21:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Jul 2019 16:21:31 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6IFLUnG43319538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2019 15:21:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0767F52051;
 Thu, 18 Jul 2019 15:21:30 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B4AE52050;
 Thu, 18 Jul 2019 15:21:29 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Date: Thu, 18 Jul 2019 10:21:28 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071815-0020-0000-0000-00000355157F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071815-0021-0000-0000-000021A8EE74
Message-Id: <156346318478.57409.13978029359288402904.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-18_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180159
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v3] ppc: make idle_timer a per-cpu variable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current code is broken for more than vcpu as
each thread would overwrite and there were memory leaks.

Make it part of PowerPCCPU so that every thread has a
separate one. Avoid using the timer_new_ns which is
not the preferred way to create timers.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04023.html
 Changes from v2:
   v2 just looked at avoiding the memory leak.
   This patch incorporates all of Greg's suggestions.

 target/ppc/cpu.h |    1 +
 target/ppc/kvm.c |   31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2a5c..521086d91a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1190,6 +1190,7 @@ struct PowerPCCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    QEMUTimer idle_timer;
 
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..6e1b96bb0a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -87,18 +87,6 @@ static int cap_large_decr;
 
 static uint32_t debug_inst_opcode;
 
-/*
- * XXX We have a race condition where we actually have a level triggered
- *     interrupt, but the infrastructure can't expose that yet, so the guest
- *     takes but ignores it, goes to sleep and never gets notified that there's
- *     still an interrupt pending.
- *
- *     As a quick workaround, let's just wake up again 20 ms after we injected
- *     an interrupt. That way we can assure that we're always reinjecting
- *     interrupts in case the guest swallowed them.
- */
-static QEMUTimer *idle_timer;
-
 static void kvm_kick_cpu(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -491,7 +479,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
-    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
+    timer_init_ns(&cpu->idle_timer, QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
 
     switch (cenv->mmu_model) {
     case POWERPC_MMU_BOOKE206:
@@ -523,6 +511,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+    timer_deinit(&cpu->idle_timer);
+
     return 0;
 }
 
@@ -1379,8 +1371,17 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
             printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
         }
 
-        /* Always wake up soon in case the interrupt was level based */
-        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+        /*
+         * XXX We have a race condition where we actually have a level
+         *     triggered interrupt, but the infrastructure can't expose that
+         *     yet, so the guest takes but ignores it, goes to sleep and
+         *     never gets notified that there's still an interrupt pending.
+         *
+         *     As a quick workaround, let's just wake up again 20 ms after
+         *     we injected an interrupt. That way we can assure that we're
+         *     always reinjecting interrupts in case the guest swallowed them.
+         */
+        timer_mod(&cpu->idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                        (NANOSECONDS_PER_SECOND / 50));
     }
 


