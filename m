Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F635C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17507208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17507208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTV4c-0005zS-59
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jTV1s-0003Ni-Ep
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jTV0o-0005Pj-5g
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:32:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1jTV0n-0005PZ-JH; Tue, 28 Apr 2020 14:31:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03SI26Rx110613; Tue, 28 Apr 2020 14:31:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mggurhb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 14:31:13 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03SI3XEY115189;
 Tue, 28 Apr 2020 14:31:13 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mggurham-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 14:31:13 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03SIULUe019848;
 Tue, 28 Apr 2020 18:31:12 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04wdc.us.ibm.com with ESMTP id 30mcu6x8uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 18:31:12 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03SIVBYM53281238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 18:31:11 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFA43AE05C;
 Tue, 28 Apr 2020 18:31:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0CCCAE066;
 Tue, 28 Apr 2020 18:31:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2020 18:31:11 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390x/kvm: help valgrind in several places
Date: Tue, 28 Apr 2020 14:31:09 -0400
Message-Id: <20200428183109.89439-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-28_12:2020-04-28,
 2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280139
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 14:31:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need some little help in the code to reduce the valgrind noise.
- some designated initializers for the cpu model features and subfunctions
- mark memory as defined for sida memory reads

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/kvm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 69881a0da0..bcd0ee0d14 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -52,6 +52,10 @@
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/pv.h"
 
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/memcheck.h>
+#endif
+
 #ifndef DEBUG_KVM
 #define DEBUG_KVM  0
 #endif
@@ -875,6 +879,13 @@ int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
         error_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
         abort();
     }
+
+#ifdef CONFIG_VALGRIND_H
+    if (!is_write) {
+        VALGRIND_MAKE_MEM_DEFINED(hostbuf, len);
+    }
+#endif
+
     return ret;
 }
 
@@ -2165,7 +2176,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 
 static int query_cpu_subfunc(S390FeatBitmap features)
 {
-    struct kvm_s390_vm_cpu_subfunc prop;
+    struct kvm_s390_vm_cpu_subfunc prop = {};
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_CPU_MODEL,
         .attr = KVM_S390_VM_CPU_MACHINE_SUBFUNC,
@@ -2292,7 +2303,7 @@ static int kvm_to_feat[][2] = {
 
 static int query_cpu_feat(S390FeatBitmap features)
 {
-    struct kvm_s390_vm_cpu_feat prop;
+    struct kvm_s390_vm_cpu_feat prop = {};
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_CPU_MODEL,
         .attr = KVM_S390_VM_CPU_MACHINE_FEAT,
-- 
2.25.1


