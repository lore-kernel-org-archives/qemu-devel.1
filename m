Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DABC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6FE22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6FE22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzqDa-0002aO-04
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hzpQ1-0007KW-M9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hzpPy-00085o-SS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:42:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29392
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>) id 1hzpPy-00085h-NU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:42:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7JLbAon066698
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 17:42:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ug0xx6ryj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 17:42:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pc@us.ibm.com>;
 Mon, 19 Aug 2019 22:42:20 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Aug 2019 22:42:18 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7JLgHWi51118516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 21:42:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE61078063;
 Mon, 19 Aug 2019 21:42:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 826D07805E;
 Mon, 19 Aug 2019 21:42:17 +0000 (GMT)
Received: from localhost (unknown [9.80.202.43])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 21:42:17 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Mon, 19 Aug 2019 16:42:16 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19081921-0004-0000-0000-000015370615
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249231; UDB=6.00659450; IPR=6.01030767; 
 MB=3.00028239; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 21:42:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081921-0005-0000-0000-00008CF13ACC
Message-Id: <1566250936-14538-1-git-send-email-pc@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190217
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2] ppc: Fix emulated single to double
 denormalized conversions
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

helper_todouble() was not properly converting any denormalized 32 bit
float to 64 bit double.

Fix-suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

v2:
- Splitting patch "ppc: Three floating point fixes"; this is just one part.
- Original suggested "fix" was likely flawed.  v2 is rewritten by
  Richard Henderson (Thanks, Richard!); I reformatted the comments in a
  couple of places, compiled, and tested.
---
 target/ppc/fpu_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 52bcda2..07bc905 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -73,11 +73,20 @@ uint64_t helper_todouble(uint32_t arg)
         /* Zero or Denormalized operand.  */
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
         if (unlikely(abs_arg != 0)) {
-            /* Denormalized operand.  */
-            int shift = clz32(abs_arg) - 9;
-            int exp = -126 - shift + 1023;
+            /*
+             * Denormalized operand.
+             * Shift fraction so that the msb is in the implicit bit position.
+             * Thus, shift is in the range [1:23].
+             */
+            int shift = clz32(abs_arg) - 8;
+            /*
+             * The first 3 terms compute the float64 exponent.  We then bias
+             * this result by -1 so that we can swallow the implicit bit below.
+             */
+            int exp = -126 - shift + 1023 - 1;
+
             ret |= (uint64_t)exp << 52;
-            ret |= abs_arg << (shift + 29);
+            ret += (uint64_t)abs_arg << (52 - 23 + shift);
         }
     }
     return ret;
-- 
1.8.3.1


