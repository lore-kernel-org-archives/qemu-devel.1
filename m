Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B52C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4924020C56
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4924020C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqrZ-0001hJ-FX
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdqom-0004qs-Pd; Wed, 27 May 2020 03:49:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdqol-0003dh-PU; Wed, 27 May 2020 03:49:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04R7WL0B093752; Wed, 27 May 2020 03:49:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316ywnjt6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 03:49:38 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R7WgN7095539;
 Wed, 27 May 2020 03:49:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316ywnjt5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 03:49:37 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R7fUSk005337;
 Wed, 27 May 2020 07:49:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 316uf8yf2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 07:49:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04R7nX2E12058968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 07:49:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28641A405B;
 Wed, 27 May 2020 07:49:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7309CA4054;
 Wed, 27 May 2020 07:49:32 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2020 07:49:32 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] pc-bios: s390x: Use PSW masks where possible and
 introduce PSW_MASK_SHORT_ADDR
Date: Wed, 27 May 2020 03:49:17 -0400
Message-Id: <20200527074920.43669-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527074920.43669-1-frankja@linux.ibm.com>
References: <20200527074920.43669-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_02:2020-05-26,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 03:49:33
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 thuth@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's move some of the PSW mask defines into s390-arch.h and use them
in jump2ipl.c. Also let's introduce a new constant for the address
mask of 8 byte (short) PSWs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 pc-bios/s390-ccw/jump2ipl.c  | 10 ++++------
 pc-bios/s390-ccw/s390-arch.h |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 4eba2510b0..767012bf0c 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -8,12 +8,10 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
 
 #define KERN_IMAGE_START 0x010000UL
-#define PSW_MASK_64 0x0000000100000000ULL
-#define PSW_MASK_32 0x0000000080000000ULL
-#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
-#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
+#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
 
 typedef struct ResetInfo {
     uint64_t ipl_psw;
@@ -54,7 +52,7 @@ void jump_to_IPL_code(uint64_t address)
 
     current->ipl_psw = (uint64_t) &jump_to_IPL_2;
     current->ipl_psw |= RESET_PSW_MASK;
-    current->ipl_continue = address & 0x7fffffff;
+    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
 
     debug_print_int("set IPL addr to", current->ipl_continue);
 
@@ -86,7 +84,7 @@ void jump_to_low_kernel(void)
 
     /* Trying to get PSW at zero address */
     if (*((uint64_t *)0) & RESET_PSW_MASK) {
-        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
+        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
     }
 
     /* No other option left, so use the Linux kernel start address */
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 73852029d4..6da44d4436 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -26,9 +26,11 @@ _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
 
 /* s390 psw bit masks */
 #define PSW_MASK_IOINT      0x0200000000000000ULL
+#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
 #define PSW_MASK_WAIT       0x0002000000000000ULL
 #define PSW_MASK_EAMODE     0x0000000100000000ULL
 #define PSW_MASK_BAMODE     0x0000000080000000ULL
+#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
 #define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
 
 /* Low core mapping */
-- 
2.25.1


