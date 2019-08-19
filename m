Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEBC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D08822CE9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D08822CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzlhe-0001qv-M6
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hzlgs-0001Kh-7E
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hzlgp-0001zR-Do
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:43:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55388
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hzlgp-0001z7-9N; Mon, 19 Aug 2019 13:43:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7JHgNfC167319; Mon, 19 Aug 2019 13:43:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ufyb02hqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 13:43:25 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7JHh7OJ169755;
 Mon, 19 Aug 2019 13:43:25 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ufyb02hqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 13:43:25 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JHfqF0005516;
 Mon, 19 Aug 2019 17:43:24 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 2ug0ck000r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2019 17:43:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7JHhN4K57803238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 17:43:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 905AFBE056;
 Mon, 19 Aug 2019 17:43:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57479BE051;
 Mon, 19 Aug 2019 17:43:23 +0000 (GMT)
Received: from localhost (unknown [9.80.202.43])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 17:43:23 +0000 (GMT)
From: "Paul A. Clarke" <pc@us.ibm.com>
To: david@gibson.dropbear.id.au
Date: Mon, 19 Aug 2019 12:43:21 -0500
Message-Id: <1566236601-22954-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190188
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2] ppc: conform to processor User's Manual for
 xscvdpspn
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Paul A. Clarke" <pc@us.ibm.com>

The POWER8 and POWER9 User's Manuals specify the implementation
behavior for what the ISA leaves "undefined" behavior for the
xscvdpspn and xscvdpsp instructions.  This patch corrects the QEMU
implementation to match the hardware implementation for that case.

ISA 3.0B has xscvdpspn leaving its result in word 0 of the target register,
with the other words of the target register left "undefined".

The User's Manuals specify:
  VSX scalar convert from double-precision to single-precision (xscvdpsp,
  xscvdpspn).
  VSR[32:63] is set to VSR[0:31].
So, words 0 and 1 both contain the result.

Note: this is important because GCC as of version 8 or so, assumes and takes
advantage of this behavior to optimize the following sequence:
  xscvdpspn vs0,vs1
  mffprwz   r8,f0
ISA 3.0B has xscvdpspn leaving its result in word 0 of the target register,
and mffprwz expecting its input to come from word 1 of the source register.
This sequence fails with QEMU, as a shift is required between those two
instructions.  However, since the hardware splats the result to both words 0
and 1 of its output register, the shift is not necessary.

Expect a future revision of the ISA to specify this behavior.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

v2
- Splitting patch "ppc: Three floating point fixes"; this is just one part.
- Updated commit message to clarify behavior is documented in User's Manuals.
- Updated commit message to correct which words are in output and source of
  xscvdpspn and mffprz.
- No source changes to this part of the original patch.

---
 target/ppc/fpu_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 5611cf0..23b9c97 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2871,10 +2871,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
 
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


