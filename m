Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66618C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326312089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uT3zhEdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326312089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeyQ-0004aP-8i
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQM-0007Wb-LC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQK-0007pr-7H
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQJ-0007bh-Pg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id b17so12468905wrq.11
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+1Eu0a2rG77UT6/ymd+XIjDhnuEka8Y1v776h2ywKc0=;
 b=uT3zhEdn0lKzwiheehj4venzx0QVhp5nQU8BhWubTNcf5Ml6Swr7amh7oUrn0/UMFR
 pb0BfVr62HPq1RZpOyRLcu/ztjSEOtSa3p+/NM26MQPnziyRoGCutZkcshxxrI5BjToe
 wmy8cuq4UHiLjCOs8awyvOMwY4AtYkfGQPCRAkhIv2gPdSH5a95DctwqfLrheXsz7CfE
 9tVERF+SkSr6/pFyRnlZmjrK9o/ko0ToUzplTvUXjmIfkzK6dC0dOl6A1wbO8oOl/dY1
 uwqCY7+tzHSvnMQ1/9nORn8xMg6UR8x1NtwYWSY4FcJCwjgtG4AU9SI2tl9Xv4kn/tWb
 EOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+1Eu0a2rG77UT6/ymd+XIjDhnuEka8Y1v776h2ywKc0=;
 b=Iyr86uLgA2bSuj3HL4yzxlynKPmeOUAf5vBVvjEQ11oulYJ8SQSyiQsfOvq+kguMsQ
 8BEOUN+HBUAbvlrbEul63B+ZPckqqnHksnFdEmwsdfDglIiXGrDYx0MHD12cjPWUkfLz
 OAehJWR0BemmNgzbikU1DMfXLJd9x6g73bXWECewxDOj1004S+jBfIqW5nT7p2rAzoNo
 f65BK+ydxxkk3tLcpAdgQBZ+vcK+9g0PcggeOVN6ougJ+50pnecdrz74t+pYxvh0E78L
 A6+XcK6OYZ4wTgviAPL7VSkSX/0Jv0OM7CywIqtW11M0g86jKW5FCSL89lgkaaEqkIQ6
 0pFQ==
X-Gm-Message-State: APjAAAUsx0f5PW8Cf8ImUvsQlrmsmr1pEe5TsSVafTVrnb86HNtJhsUK
 tlGx3a6ImZvyxJo2qfB1NnOVOfqlIJxeZA==
X-Google-Smtp-Source: APXvYqxzd6fzCLALNRlSFt2+/X3poCf0DCKrI1x1zLJhSuUMLMp6xIjw8aP8gWGe2B7Z4Uj1Dsm45A==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr4501460wrn.176.1560250461965; 
 Tue, 11 Jun 2019 03:54:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:35 +0100
Message-Id: <20190611105351.9871-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 26/42] target/arm: Convert VDIV to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VDIV instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         | 21 +--------------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 12da3b8acb8..6af99605d5c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1471,3 +1471,13 @@ static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 18d4f9933ad..a9ec6eaef80 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,22 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-#define VFP_OP2(name)                                                 \
-static inline void gen_vfp_##name(int dp)                             \
-{                                                                     \
-    TCGv_ptr fpst = get_fpstatus_ptr(0);                              \
-    if (dp) {                                                         \
-        gen_helper_vfp_##name##d(cpu_F0d, cpu_F0d, cpu_F1d, fpst);    \
-    } else {                                                          \
-        gen_helper_vfp_##name##s(cpu_F0s, cpu_F0s, cpu_F1s, fpst);    \
-    }                                                                 \
-    tcg_temp_free_ptr(fpst);                                          \
-}
-
-VFP_OP2(div)
-
-#undef VFP_OP2
-
 static inline void gen_vfp_abs(int dp)
 {
     if (dp)
@@ -3109,7 +3093,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 7:
+            case 0 ... 8:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3295,9 +3279,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 8: /* div: fn / fm */
-                    gen_vfp_div(dp);
-                    break;
                 case 10: /* VFNMA : fd = muladd(-fd,  fn, fm) */
                 case 11: /* VFNMS : fd = muladd(-fd, -fn, fm) */
                 case 12: /* VFMA  : fd = muladd( fd,  fn, fm) */
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index de56f44efc9..de305f60e18 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -137,3 +137,8 @@ VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


