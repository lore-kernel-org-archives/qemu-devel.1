Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DE6C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21C92089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d41y8Qw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21C92089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeyc-00051l-T8
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQR-0007eW-5X
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQL-0007sd-LS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQL-0007kU-6I
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id c66so2437100wmf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=78Ipc5UK7B7ARzS4SX5cy/iMal0ICqCZUARVRbwaHD8=;
 b=d41y8Qw7hXXr/ASEX4OaDToKboEiRHtpCeLUCaSP+oMX42nz+xtM1E0uzxzgBvp/jq
 FaBYGiF4i8G2D69O7Jydys+BdELmnYRW1LNvhg8rAtp+iK1ZRq7jg3FpygulKqnEgtjI
 EzFHRj9eQqG6EXY3vXrNnLD69nzMKur4LkCHGV3NJpdS+R2nuEd1REANKtwjPOMMNLv+
 CQfTaYBdCuNuCGnXmNLUMUl+FpUr+nDWxvt1w664ZsH9AHdCMEQ2bq6HhH9VFQfM92t7
 qoHxTFaZPNIlYk3CXvL/JqE1WBoL3v3Mo8czOMIbdJPQtAWDgLtA5Fw2KxrJtWO0Znk9
 9TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=78Ipc5UK7B7ARzS4SX5cy/iMal0ICqCZUARVRbwaHD8=;
 b=NwgDS+F+i4LtXJmUbp7qGxfKSbKQu5gjVKMVK1PwfdVZjYc+dkfT7kXqWxVjbgruQ6
 99qkp/pErpqYFCTmLK1QY9RTKOl/er7JTguMTVYQIX+M0VJUQRS9cR3B7WoBhnF+1jsE
 ikZdqPQkxZbdTao3sRRfd2k3iddN84yEtFwHStsUFd5qA89x7Jm9+Da6Nz79xs2doSpA
 uEpBeoeeb1G6dZ9UDA55RLe49twSMfDE5L4hIZe8Cbr2948KIArm+f4ALl6bR5a3i1pg
 8ncwkcwWjZHM9i1dXJ4Q6dQzeIUysUn7+/iyKonh+9MhH2upzxMg0qo7Hsl94I7tATen
 KWAQ==
X-Gm-Message-State: APjAAAVlZRCG4nGOnUQ6avX10gNKqeVvKfXmP2AZG0dvKB2xe3oIJtTf
 Hn8zhOpgZFHSb08Di/Yb8lsRMA==
X-Google-Smtp-Source: APXvYqycJu8/pENUSIXmby30iyNfBdJ3GZ46DvyrJJVz9SgiQIrrIll5fEgBZ/7LkmR6/dOmPVNioA==
X-Received: by 2002:a1c:b684:: with SMTP id
 g126mr17092577wmf.176.1560250473428; 
 Tue, 11 Jun 2019 03:54:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:46 +0100
Message-Id: <20190611105351.9871-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 37/42] target/arm: Convert double-single
 precision conversion insns to decodetree
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

Convert the VCVT double/single precision conversion insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 48 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 13 +--------
 target/arm/vfp.decode          |  6 +++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e94a8f2f0c5..c50093776b6 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2320,3 +2320,51 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     tcg_temp_free_i64(tmp);
     return true;
 }
+
+static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
+{
+    TCGv_i64 vd;
+    TCGv_i32 vm;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i64();
+    neon_load_reg32(vm, a->vm);
+    gen_helper_vfp_fcvtds(vd, vm, cpu_env);
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    return true;
+}
+
+static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
+{
+    TCGv_i64 vm;
+    TCGv_i32 vd;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vd = tcg_temp_new_i32();
+    vm = tcg_temp_new_i64();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vfp_fcvtsd(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i64(vm);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 412d8aaedb2..05ee76da77c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 14:
+                case 0 ... 15:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x0f: /* vcvt double<->single */
-                    rd_is_dp = !dp;
-                    break;
-
                 case 0x10: /* vcvt.fxx.u32 */
                 case 0x11: /* vcvt.fxx.s32 */
                     rm_is_dp = false;
@@ -3185,13 +3181,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 15: /* single<->double conversion */
-                        if (dp) {
-                            gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
-                        } else {
-                            gen_helper_vfp_fcvtds(cpu_F0d, cpu_F0s, cpu_env);
-                        }
-                        break;
                     case 16: /* fuito */
                         gen_vfp_uito(dp, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9942d2ae7ad..56b8b4e6046 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -208,3 +208,9 @@ VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+# VCVT between single and double: Vm precision depends on size; Vd is its reverse
+VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
+             vd=%vd_dp vm=%vm_sp
+VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


