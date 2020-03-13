Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA36C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6FD20746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6FD20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCh0V-0000HE-Hp
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCgzn-0008Fm-SG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCgzm-0008H2-R7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:52:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46010
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCgzm-0008EN-Lc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:52:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D9p1TW049935
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 05:52:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqx4dk0p4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 05:52:45 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 13 Mar 2020 09:52:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 09:52:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02D9qel141549862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 09:52:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73B7B4C040;
 Fri, 13 Mar 2020 09:52:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 372F54C04A;
 Fri, 13 Mar 2020 09:52:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.48.117])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 09:52:38 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9] fixup! Fix subcode/pbt
Date: Fri, 13 Mar 2020 05:52:32 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
References: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031309-0008-0000-0000-0000035C8B9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031309-0009-0000-0000-00004A7DD829
Message-Id: <20200313095232.2392-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-11,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxlogscore=809 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=1 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130050
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/ipl.h      | 11 +++++++----
 target/s390x/diag.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 95e3183c9cccf8b6..f799f7cfcf4763b1 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -261,15 +261,18 @@ static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
         return true;
 }
 
-static inline bool iplb_valid(IplParameterBlock *iplb)
+static inline bool iplb_valid(IplParameterBlock *iplb, uint64_t subcode)
 {
     switch (iplb->pbt) {
     case S390_IPL_TYPE_FCP:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
+        return (subcode == DIAG308_SET &&
+                be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN);
     case S390_IPL_TYPE_CCW:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+        return (subcode == DIAG308_SET &&
+                be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN);
     case S390_IPL_TYPE_PV:
-        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
+        if (subcode != DIAG308_PV_SET ||
+            be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
             return false;
         }
         if (!ipl_valid_pv_header(iplb)) {
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b1ca81633b83bbdc..d4f33db5c23c818d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -118,7 +118,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
 
-        if (!iplb_valid(iplb)) {
+        if (!iplb_valid(iplb, subcode)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-- 
2.25.1


