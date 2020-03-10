Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271EE2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271EE2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgj2-0001PQ-32
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgWA-00061d-P9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgW5-0003rU-IK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jBgW5-0003pS-AL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:09:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AExQqO110660
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n8qybs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:56 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 10 Mar 2020 15:09:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:09:51 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02AF9og047382672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:09:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32E6A4040;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E15A5A4051;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id A4FBCE01C3; Tue, 10 Mar 2020 16:09:49 +0100 (CET)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/4] s390x: ipl: Consolidate iplb validity check into one
 function
Date: Tue, 10 Mar 2020 16:09:47 +0100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310150947.3510824-1-borntraeger@de.ibm.com>
References: <20200310150947.3510824-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031015-4275-0000-0000-000003AA4269
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-4276-0000-0000-000038BF5C11
Message-Id: <20200310150947.3510824-5-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_08:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100099
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

It's nicer to just call one function than calling a function for each
possible iplb type.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200310090950.61172-1-frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.h      | 18 +++++++++---------
 target/s390x/diag.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d4813105db33..3e44abe1c651 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -173,16 +173,16 @@ static inline bool iplb_valid_len(IplParameterBlock *iplb)
     return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
 }
 
-static inline bool iplb_valid_ccw(IplParameterBlock *iplb)
+static inline bool iplb_valid(IplParameterBlock *iplb)
 {
-    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN &&
-           iplb->pbt == S390_IPL_TYPE_CCW;
-}
-
-static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
-{
-    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN &&
-           iplb->pbt == S390_IPL_TYPE_FCP;
+    switch (iplb->pbt) {
+    case S390_IPL_TYPE_FCP:
+        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
+    case S390_IPL_TYPE_CCW:
+        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+    default:
+        return false;
+    }
 }
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b5aec06d6bef..54e5670b3fd6 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -117,7 +117,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
 
-        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
+        if (!iplb_valid(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-- 
2.24.1


