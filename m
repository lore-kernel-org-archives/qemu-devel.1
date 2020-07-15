Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2710BC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CDD2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CDD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdwO-0001f2-9N
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvdup-0008JL-DG
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45256
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvdun-0006Gc-L5
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06F9Y6B2007619
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329dhwx0kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:24 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06F9YJdB008709
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:24 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329dhwx0jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 05:41:24 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06F9Yieo028454;
 Wed, 15 Jul 2020 09:41:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 327527v93b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 09:41:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06F9fKJf30212562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 09:41:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22E764C04E;
 Wed, 15 Jul 2020 09:41:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8398B4C040;
 Wed, 15 Jul 2020 09:41:19 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2020 09:41:19 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] pc-bios: s390x: Use PSW constants in start.S
Date: Wed, 15 Jul 2020 05:40:44 -0400
Message-Id: <20200715094045.381984-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715094045.381984-1-frankja@linux.ibm.com>
References: <20200715094045.381984-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_07:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=1 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=803 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:27:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's decrease the number of magic numbers.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 pc-bios/s390-ccw/s390-arch.h | 25 +++++++++++++++----------
 pc-bios/s390-ccw/start.S     |  9 +++++----
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 6da44d4436..d450c096d0 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -11,6 +11,20 @@
 #ifndef S390_ARCH_H
 #define S390_ARCH_H
 
+/* s390 psw bit masks */
+#define PSW_MASK_EXT        0x0100000000000000UL
+#define PSW_MASK_IOINT      0x0200000000000000ULL
+#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
+#define PSW_MASK_WAIT       0x0002000000000000ULL
+#define PSW_MASK_EAMODE     0x0000000100000000ULL
+#define PSW_MASK_BAMODE     0x0000000080000000ULL
+#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
+#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
+#define PSW_MASK_DWAIT      (PSW_MASK_64 | PSW_MASK_WAIT)
+#define PSW_MASK_EWAIT      (PSW_MASK_DWAIT | PSW_MASK_IOINT | PSW_MASK_EXT)
+
+#ifndef __ASSEMBLER__
+
 typedef struct PSW {
     uint64_t mask;
     uint64_t addr;
@@ -24,15 +38,6 @@ typedef struct PSWLegacy {
 } __attribute__ ((aligned(8))) PSWLegacy;
 _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
 
-/* s390 psw bit masks */
-#define PSW_MASK_IOINT      0x0200000000000000ULL
-#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
-#define PSW_MASK_WAIT       0x0002000000000000ULL
-#define PSW_MASK_EAMODE     0x0000000100000000ULL
-#define PSW_MASK_BAMODE     0x0000000080000000ULL
-#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
-#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
-
 /* Low core mapping */
 typedef struct LowCore {
     /* prefix area: defined by architecture */
@@ -107,5 +112,5 @@ static inline uint32_t store_prefix(void)
     asm volatile("stpx %0" : "=m" (address));
     return address;
 }
-
+#endif /* !__ASSEMBLER__ */
 #endif
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index ce519300a1..01c4c21b26 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -9,6 +9,7 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+#include "s390-arch.h"
 
         .globl _start
 _start:
@@ -108,10 +109,10 @@ io_new_code:
 
         .align  8
 disabled_wait_psw:
-        .quad   0x0002000180000000,0x0000000000000000
+        .quad   PSW_MASK_DWAIT, 0x0000000000000000
 enabled_wait_psw:
-        .quad   0x0302000180000000,0x0000000000000000
+        .quad   PSW_MASK_EWAIT, 0x0000000000000000
 external_new_mask:
-        .quad   0x0000000180000000
+        .quad   PSW_MASK_64
 io_new_mask:
-        .quad   0x0000000180000000
+        .quad   PSW_MASK_64
-- 
2.25.1


