Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2952C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80A32063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80A32063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOcQ-0007fJ-RF
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jLObG-0006O7-Jr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jLObF-00032H-B6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:03:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jLObF-00031t-3c; Mon, 06 Apr 2020 06:03:25 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 036A1hCS101484; Mon, 6 Apr 2020 06:03:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 306nvumqax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 06:03:23 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 036A1kke101636;
 Mon, 6 Apr 2020 06:02:30 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 306nvumq1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 06:02:30 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 036A0ofi021018;
 Mon, 6 Apr 2020 10:02:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03dal.us.ibm.com with ESMTP id 306hv6axyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 10:02:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 036A20Wb49021376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2020 10:02:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 176F4B2071;
 Mon,  6 Apr 2020 10:02:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10C55B206E;
 Mon,  6 Apr 2020 10:02:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2020 10:02:00 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 1/1] s390x/s390-virtio-ccw: Fix build on systems without KVM
Date: Mon,  6 Apr 2020 06:01:58 -0400
Message-Id: <20200406100158.5940-2-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406100158.5940-1-borntraeger@de.ibm.com>
References: <20200406100158.5940-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_05:2020-04-03,
 2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

linux/kvm.h is not available on all platforms. Let us move
s390_machine_inject_pv_error into pv.c as it uses KVM structures.
Also rename the function to s390_pv_inject_reset_error.

While at it, ipl.h needs an include for "exec/address-spaces.h"
as it uses address_space_memory.

Fixes: 49fc3220175e ("s390x: protvirt: Support unpack facility")
Reported-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.h             |  1 +
 hw/s390x/pv.c              | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c | 12 +-----------
 include/hw/s390x/pv.h      |  3 +++
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 89b3044d7a..53cc9eb5ac 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -14,6 +14,7 @@
 #define HW_S390_IPL_H
 
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
 
 struct IPLBlockPVComp {
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index d3333d6e13..68dbc022d0 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -13,8 +13,10 @@
 
 #include <linux/kvm.h>
 
+#include "cpu.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "hw/s390x/ipl.h"
 #include "hw/s390x/pv.h"
 
 static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
@@ -100,3 +102,12 @@ void s390_pv_unshare(void)
 {
     s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
 }
+
+void s390_pv_inject_reset_error(CPUState *cs)
+{
+    int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
+    CPUS390XState *env = &S390_CPU(cs)->env;
+
+    /* Report that we are unable to enter protected mode */
+    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
+}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b268907395..45292fb5a8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,7 +45,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "hw/s390x/pv.h"
-#include <linux/kvm.h>
 #include "migration/blocker.h"
 
 static Error *pv_mig_blocker;
@@ -390,15 +389,6 @@ out_err:
     return rc;
 }
 
-static void s390_machine_inject_pv_error(CPUState *cs)
-{
-    int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
-    CPUS390XState *env = &S390_CPU(cs)->env;
-
-    /* Report that we are unable to enter protected mode */
-    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
-}
-
 static void s390_pv_prepare_reset(S390CcwMachineState *ms)
 {
     CPUState *cs;
@@ -484,7 +474,7 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
 
         if (s390_machine_protect(ms)) {
-            s390_machine_inject_pv_error(cs);
+            s390_pv_inject_reset_error(cs);
             /*
              * Continue after the diag308 so the guest knows something
              * went wrong.
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
index c6cb360f2f..522ca6a04e 100644
--- a/include/hw/s390x/pv.h
+++ b/include/hw/s390x/pv.h
@@ -13,6 +13,7 @@
 #define HW_S390_PV_H
 
 #ifdef CONFIG_KVM
+#include "cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
 static inline bool s390_is_pv(void)
@@ -41,6 +42,7 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
 void s390_pv_perf_clear_reset(void);
 int s390_pv_verify(void);
 void s390_pv_unshare(void);
+void s390_pv_inject_reset_error(CPUState *cs);
 #else /* CONFIG_KVM */
 static inline bool s390_is_pv(void) { return false; }
 static inline int s390_pv_vm_enable(void) { return 0; }
@@ -50,6 +52,7 @@ static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) {
 static inline void s390_pv_perf_clear_reset(void) {}
 static inline int s390_pv_verify(void) { return 0; }
 static inline void s390_pv_unshare(void) {}
+static inline void s390_pv_inject_reset_error(CPUState *cs) {};
 #endif /* CONFIG_KVM */
 
 #endif /* HW_S390_PV_H */
-- 
2.25.1


