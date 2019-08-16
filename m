Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE8C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 19:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC762133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 19:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC762133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyhuD-0005TB-OY
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 15:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hyhtN-0004wH-MD
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hyhtL-00063T-OE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:28:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hyhtG-0005zI-8l; Fri, 16 Aug 2019 15:27:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7GJRN1D142961; Fri, 16 Aug 2019 15:27:51 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2udyq3xakn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2019 15:27:51 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GJPddp002904;
 Fri, 16 Aug 2019 19:27:50 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 2u9nj66hp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2019 19:27:50 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7GJRnQ952363588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2019 19:27:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A9B0AE066;
 Fri, 16 Aug 2019 19:27:49 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72F67AE062;
 Fri, 16 Aug 2019 19:27:49 +0000 (GMT)
Received: from localhost (unknown [9.85.198.236])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 16 Aug 2019 19:27:49 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Fri, 16 Aug 2019 14:27:49 -0500
Message-Id: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-16_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160197
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

- target/ppc/fpu_helper.c:
  - helper_todouble() was not properly converting INFINITY from 32 bit
  float to 64 bit double.
  - helper_todouble() was not properly converting any denormalized
  32 bit float to 64 bit double.

- GCC, as of version 8 or so, takes advantage of the hardware's
  implementation of the xscvdpspn instruction to optimize the following
  sequence:
    xscvdpspn vs0,vs1
    mffprwz   r8,f0
  ISA 3.0B has xscvdpspn leaving its result in word 1 of the target register,
  and mffprwz expecting its input to come from word 0 of the source register.
  This sequence fails with QEMU, as a shift is required between those two
  instructions.  However, the hardware splats the result to both word 0 and
  word 1 of its output register, so the shift is not necessary.
  Expect a future revision of the ISA to specify this behavior.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 target/ppc/fpu_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5611cf0..82b5425 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -62,13 +62,14 @@ uint64_t helper_todouble(uint32_t arg)
         ret  = (uint64_t)extract32(arg, 30, 2) << 62;
         ret |= ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
         ret |= (uint64_t)extract32(arg, 0, 30) << 29;
+        ret |= (0x7ffULL * (extract32(arg, 23, 8) == 0xff)) << 52;
     } else {
         /* Zero or Denormalized operand.  */
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
         if (unlikely(abs_arg != 0)) {
             /* Denormalized operand.  */
             int shift = clz32(abs_arg) - 9;
-            int exp = -126 - shift + 1023;
+            int exp = -127 - shift + 1023;
             ret |= (uint64_t)exp << 52;
             ret |= abs_arg << (shift + 29);
         }
@@ -2871,10 +2872,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
 
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
+    uint64_t result;
+
     float_status tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
 
-    return (uint64_t)float64_to_float32(xb, &tstat) << 32;
+    result = (uint64_t)float64_to_float32(xb, &tstat);
+    /* hardware replicates result to both words of the doubleword result.  */
+    return (result << 32) | result;
 }
 
 uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
-- 
1.8.3.1


