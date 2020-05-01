Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C37C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBD0216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBD0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb3N-00008T-LC
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jUb2a-0007i9-37
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jUb2Z-0007GY-GF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:09:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18396
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jUb2X-0007DH-Sk; Fri, 01 May 2020 15:09:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 041J26JF136832; Fri, 1 May 2020 15:09:32 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cn6k05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2020 15:09:32 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041J0buY018795;
 Fri, 1 May 2020 19:09:31 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 30mcu8d7x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2020 19:09:31 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 041J9UHZ52887848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2020 19:09:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D9C6A051;
 Fri,  1 May 2020 19:09:30 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0721A6A04F;
 Fri,  1 May 2020 19:09:29 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.6.38])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2020 19:09:29 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9
Date: Fri,  1 May 2020 15:09:13 -0400
Message-Id: <20200501190913.25008-2-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501190913.25008-1-dbuono@linux.vnet.ibm.com>
References: <20200501190913.25008-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-01_11:2020-05-01,
 2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=3 bulkscore=0
 priorityscore=1501 mlxlogscore=818 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010140
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 15:09:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: qemu-ppc@nongnu.org, dbuono@us.ibm.com,
 Daniele Buono <dbuono@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Starting with Clang v9, -Wtype-limits is implemented and triggers a
few "result of comparison is always true" errors when compiling PPC32
targets.

The comparisons seem to be necessary only on PPC64, since the
else branch in PPC32 only has a "g_assert_not_reached();" in all cases.

This patch restructures the code so that PPC32 does not execute the
check, while PPC64 works like before

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 807d14faaa..9400fa2c7c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1882,6 +1882,7 @@ static void gen_rlwimi(DisasContext *ctx)
         tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
     } else {
         target_ulong mask;
+        TCGv_i32 t0;
         TCGv t1;
 
 #if defined(TARGET_PPC64)
@@ -1891,20 +1892,20 @@ static void gen_rlwimi(DisasContext *ctx)
         mask = MASK(mb, me);
 
         t1 = tcg_temp_new();
+#if defined(TARGET_PPC64)
         if (mask <= 0xffffffffu) {
-            TCGv_i32 t0 = tcg_temp_new_i32();
+#endif
+            t0 = tcg_temp_new_i32();
             tcg_gen_trunc_tl_i32(t0, t_rs);
             tcg_gen_rotli_i32(t0, t0, sh);
             tcg_gen_extu_i32_tl(t1, t0);
             tcg_temp_free_i32(t0);
-        } else {
 #if defined(TARGET_PPC64)
+        } else {
             tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
             tcg_gen_rotli_i64(t1, t1, sh);
-#else
-            g_assert_not_reached();
-#endif
         }
+#endif
 
         tcg_gen_andi_tl(t1, t1, mask);
         tcg_gen_andi_tl(t_ra, t_ra, ~mask);
@@ -1938,7 +1939,9 @@ static void gen_rlwinm(DisasContext *ctx)
         me += 32;
 #endif
         mask = MASK(mb, me);
+#if defined(TARGET_PPC64)
         if (mask <= 0xffffffffu) {
+#endif
             if (sh == 0) {
                 tcg_gen_andi_tl(t_ra, t_rs, mask);
             } else {
@@ -1949,15 +1952,13 @@ static void gen_rlwinm(DisasContext *ctx)
                 tcg_gen_extu_i32_tl(t_ra, t0);
                 tcg_temp_free_i32(t0);
             }
-        } else {
 #if defined(TARGET_PPC64)
+        } else {
             tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
             tcg_gen_rotli_i64(t_ra, t_ra, sh);
             tcg_gen_andi_i64(t_ra, t_ra, mask);
-#else
-            g_assert_not_reached();
-#endif
         }
+#endif
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, t_ra);
@@ -1972,6 +1973,9 @@ static void gen_rlwnm(DisasContext *ctx)
     TCGv t_rb = cpu_gpr[rB(ctx->opcode)];
     uint32_t mb = MB(ctx->opcode);
     uint32_t me = ME(ctx->opcode);
+    TCGv_i32 t0;
+    TCGv_i32 t1;
+
     target_ulong mask;
 
 #if defined(TARGET_PPC64)
@@ -1980,9 +1984,11 @@ static void gen_rlwnm(DisasContext *ctx)
 #endif
     mask = MASK(mb, me);
 
+#if defined(TARGET_PPC64)
     if (mask <= 0xffffffffu) {
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        TCGv_i32 t1 = tcg_temp_new_i32();
+#endif
+        t0 = tcg_temp_new_i32();
+        t1 = tcg_temp_new_i32();
         tcg_gen_trunc_tl_i32(t0, t_rb);
         tcg_gen_trunc_tl_i32(t1, t_rs);
         tcg_gen_andi_i32(t0, t0, 0x1f);
@@ -1990,17 +1996,15 @@ static void gen_rlwnm(DisasContext *ctx)
         tcg_gen_extu_i32_tl(t_ra, t1);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-    } else {
 #if defined(TARGET_PPC64)
+    } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
         tcg_gen_andi_i64(t0, t_rb, 0x1f);
         tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
         tcg_gen_rotl_i64(t_ra, t_ra, t0);
         tcg_temp_free_i64(t0);
-#else
-        g_assert_not_reached();
-#endif
     }
+#endif
 
     tcg_gen_andi_tl(t_ra, t_ra, mask);
 
-- 
2.26.2


