Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DCC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1D722DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D722DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07uM-0007Jx-AX
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i07tg-0006nw-9n
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i07td-0005rZ-P1
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:26:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29154
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>) id 1i07td-0005qg-KB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:26:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7KHMV6T147026
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:26:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ugkbh5pvr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 13:26:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pc@us.ibm.com>;
 Tue, 20 Aug 2019 18:26:10 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 20 Aug 2019 18:26:06 +0100
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7KHQ5Uw45941238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2019 17:26:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D93B76A057;
 Tue, 20 Aug 2019 17:26:05 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A135A6A047;
 Tue, 20 Aug 2019 17:26:05 +0000 (GMT)
Received: from localhost (unknown [9.85.217.41])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 20 Aug 2019 17:26:05 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Tue, 20 Aug 2019 12:26:04 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19082017-0012-0000-0000-0000175D5296
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011624; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249608; UDB=6.00659683; IPR=6.01031157; 
 MB=3.00028248; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-20 17:26:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082017-0013-0000-0000-0000588B3F92
Message-Id: <1566321964-1447-1-git-send-email-pc@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200159
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] ppc: Fix xscvdpspn for SNAN
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

helper_xscvdpspn() uses float64_to_float32() to convert double-precision
floating-point to single-precision.  Unfortunately, float64_to_float32()
converts SNAN to QNAN, which should not happen with xscvdpspn.

float64_to_float32() is also used by other instruction implementations
for conversions which _should_ convert SNAN to QNAN.

Rather than trying to wedge code to preserve SNAN in float64_to_float32()
just for this this one case, I instead embed an embodiment of the
conversion code outlined in the POWER ISA for xscvdpspn.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 target/ppc/fpu_helper.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 07bc905..c8e7192 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2887,12 +2887,40 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
 
 uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 {
-    uint64_t result;
+    uint64_t result, sign, exp, frac;
 
     float_status tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
 
-    result = (uint64_t)float64_to_float32(xb, &tstat);
+    sign = extract64(xb, 63,  1);
+    exp  = extract64(xb, 52, 11);
+    frac = extract64(xb,  0, 52) | 0x10000000000000ULL;
+
+    if (unlikely(exp == 0 && extract64(frac, 0, 52) != 0)) {
+        /* DP denormal operand.  */
+        /* Exponent override to DP min exp.  */
+        exp = 1;
+        /* Implicit bit override to 0.  */
+        frac = deposit64(frac, 53, 1, 0);
+    }
+
+    if (unlikely(exp < 897 && frac != 0)) {
+        /* SP tiny operand.  */
+        if (897 - exp > 63) {
+            frac = 0;
+        } else {
+            /* Denormalize until exp = SP min exp.  */
+            frac >>= (897 - exp);
+        }
+        /* Exponent override to SP min exp - 1.  */
+        exp = 896;
+    }
+
+    result = sign << 31;
+    result |= extract64(exp, 10, 1) << 30;
+    result |= extract64(exp, 0, 7) << 23;
+    result |= extract64(frac, 29, 23);
+
     /* hardware replicates result to both words of the doubleword result.  */
     return (result << 32) | result;
 }
-- 
1.8.3.1


