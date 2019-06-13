Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD89C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003B02147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZUM8ALG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003B02147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbP9i-0003oM-6q
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdL-00080W-Bu
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdH-0004Kp-GC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdF-0004BZ-Cf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id p13so10426556wru.10
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yJiv1hSo+fvJ6FJSmb7ni56s0cGOEaImkCLppkFYZ5s=;
 b=EZUM8ALGzK54Lij/0VYowMLWDOZdXqSa67ANbDXhuAqsbOkDXbGLpCoU4LBsgmD5Mo
 2iIiK7yLkZV1Ttjy+5Qtf9Sje8JiTxyfzgctb0aPgYZXH4ofucEHddhjlYBceG453YME
 aDIphsMJZcl3Cbiv/OOAHM0hGRCUBTmt3o1ddH6mTMZlunxnehmW8FqfjbEQFxbveSoh
 viacgCkRmGaP5rj6Kuxe/dN3jbq/6GXZW03e0do4yftUC7XDD7GeZL0ipydINdXAEXBe
 UQWnYgTiP7mnZ4/tVQX8qnUWc+X6jKRwthikzTYhUvVo1f1xBAAY2NbO4h9Kf84HJhE6
 NlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yJiv1hSo+fvJ6FJSmb7ni56s0cGOEaImkCLppkFYZ5s=;
 b=MvHJizA80hgkYmMgx/GsuIupWNXLIFhau0zfnjmeZoJ58mAtZfrdfuDzV22hxLUQjN
 UmFcR9bHtYVc6WKgYn/AnfqjcXTmzOqgUjtLMpF6trx2clevXLV9+aVYMrCRnVfpWF4I
 0C46r9MeuSsOInW1bLP3Lj1kYka2qZg5rPOo2b1ivZZJyiDQboAQr6fyGtztAywEgB+v
 OxMsXsnzGjJFrrAi6eqiFr6LB9vYbNOMB5zGT/U9xc2lK4/cCtgeymQTghaye+4OcKG0
 D+QKLYQC24J7r9V0c2jDqImGX6yiy8Ao4pVpCIx34R410eo9B5yi1/7vxAEPtwuy7Ojd
 Ax4g==
X-Gm-Message-State: APjAAAW5e5i+tcjdVfeebIZPVus+ROi69+KhsHaCDCQDWc5MIXje/E4S
 vvRHElRK4O6fY5IsO/H2f1Z2QxMKzc87vw==
X-Google-Smtp-Source: APXvYqwytpJp9KqWLKOq/VN/1dTkMa/3jPq2SLhLzrF4KZ6GFIk4pWU+NIqyq7SsB6ACHBu98G/0eQ==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr751651wrs.289.1560428098932;
 Thu, 13 Jun 2019 05:14:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:06 +0100
Message-Id: <20190613121433.5246-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 21/48] target/arm: Convert VFP VLDR and VSTR to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP single load/store insns VLDR and VSTR to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 73 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 22 +---------
 target/arm/vfp.decode          |  7 ++++
 3 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5f081221b83..40f2cac3e2e 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -853,3 +853,76 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
 
     return true;
 }
+
+static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    offset = a->imm << 2;
+    if (!a->u) {
+        offset = -offset;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    tcg_gen_addi_i32(addr, addr, offset);
+    if (a->l) {
+        gen_vfp_ld(s, false, addr);
+        gen_mov_vreg_F0(false, a->vd);
+    } else {
+        gen_mov_F0_vreg(false, a->vd);
+        gen_vfp_st(s, false, addr);
+    }
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    offset = a->imm << 2;
+    if (!a->u) {
+        offset = -offset;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    tcg_gen_addi_i32(addr, addr, offset);
+    if (a->l) {
+        gen_vfp_ld(s, true, addr);
+        gen_mov_vreg_F0(true, a->vd);
+    } else {
+        gen_mov_F0_vreg(true, a->vd);
+        gen_vfp_st(s, true, addr);
+    }
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index eb217af579a..0c92f3ed4ec 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3713,26 +3713,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             else
                 rd = VFP_SREG_D(insn);
             if ((insn & 0x01200000) == 0x01000000) {
-                /* Single load/store */
-                offset = (insn & 0xff) << 2;
-                if ((insn & (1 << 23)) == 0)
-                    offset = -offset;
-                if (s->thumb && rn == 15) {
-                    /* This is actually UNPREDICTABLE */
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~2);
-                } else {
-                    addr = load_reg(s, rn);
-                }
-                tcg_gen_addi_i32(addr, addr, offset);
-                if (insn & (1 << 20)) {
-                    gen_vfp_ld(s, dp, addr);
-                    gen_mov_vreg_F0(dp, rd);
-                } else {
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_st(s, dp, addr);
-                }
-                tcg_temp_free_i32(addr);
+                /* Already handled by decodetree */
+                return 1;
             } else {
                 /* load/store multiple */
                 int w = insn & (1 << 21);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 134f1c9ef58..8fa7fa0bead 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -71,3 +71,10 @@ VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 .... \
              vm=%vm_sp
 VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 .... \
              vm=%vm_dp
+
+# Note that the half-precision variants of VLDR and VSTR are
+# not part of this decodetree at all because they have bits [9:8] == 0b01
+VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8 \
+             vd=%vd_sp
+VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8 \
+             vd=%vd_dp
-- 
2.20.1


