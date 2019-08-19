Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2379C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9B02087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9B02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hznD4-0001AK-OD
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hznCG-0008ON-0a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hznCF-0006XZ-2z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34994
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hznCA-0006US-TF; Mon, 19 Aug 2019 15:19:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7JJ2c6j011293; Mon, 19 Aug 2019 15:19:50 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ufyyvm99d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 15:19:50 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JJJdt7031734;
 Mon, 19 Aug 2019 19:19:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02wdc.us.ibm.com with ESMTP id 2ue9762cmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 19:19:49 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7JJJnd651642778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 19:19:49 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22686124055;
 Mon, 19 Aug 2019 19:19:49 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03329124053;
 Mon, 19 Aug 2019 19:19:48 +0000 (GMT)
Received: from localhost (unknown [9.80.202.43])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 19:19:48 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Mon, 19 Aug 2019 14:19:48 -0500
Message-Id: <1566242388-9244-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=671 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190194
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] ppc: Fix emulated INFINITY and NAN conversions
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

helper_todouble() was not properly converting INFINITY from 32 bit
float to 64 bit double.

(Normalized operand conversion is unchanged, other than indentation.)

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 target/ppc/fpu_helper.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 23b9c97..52bcda2 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -58,10 +58,17 @@ uint64_t helper_todouble(uint32_t arg)
     uint64_t ret;
 
     if (likely(abs_arg >= 0x00800000)) {
-        /* Normalized operand, or Inf, or NaN.  */
-        ret  = (uint64_t)extract32(arg, 30, 2) << 62;
-        ret |= ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
-        ret |= (uint64_t)extract32(arg, 0, 30) << 29;
+        if (unlikely(extract32(arg, 23, 8) == 0xff)) {
+            /* Inf or NAN.  */
+            ret  = (uint64_t)extract32(arg, 31, 1) << 63;
+            ret |= (uint64_t)0x7ff << 52;
+            ret |= (uint64_t)extract32(arg, 0, 23) << 29;
+        } else {
+            /* Normalized operand.  */
+            ret  = (uint64_t)extract32(arg, 30, 2) << 62;
+            ret |= ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
+            ret |= (uint64_t)extract32(arg, 0, 30) << 29;
+        }
     } else {
         /* Zero or Denormalized operand.  */
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
-- 
1.8.3.1


