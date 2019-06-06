Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F0B20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0NbhlZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F0B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwVf-0005d3-Jj
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:49:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTi-00042W-7u
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTf-0003Ub-Dv
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTe-00030V-GX
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so806974wmj.5
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=T5pJCvoVL1jFgiOABWaIy/SlC0FgTPbtTeCLF0KVYlg=;
	b=l0NbhlZaHlMCn8ICqpj8wMJ3RUN8ZUsGUVC53S6vBBYR7KGZ076gF0G5ffEXx+JvvI
	9G+G5RY/DgqlUaQ2+WOQLEMYd3D1v0d06jHUqiI2XhLYbzYeUqRLGRThYpW5QgH5bvQC
	nTNOw7dFumZv7VyMLgHdXZ6wbRYPqOj4tC4u4IlLIBddW7vL5IJF+q8VQfDx67lHt03v
	Bk2+YfXd19JZ1/+4hxoLtbGZ9y7lVUdxNNgLVAJ2apfv6PsB+nvEVZ/59PyKag2Vow3a
	QFB59o5QwMtw2zQh69u2VKeJ1V/yd6Javt27ffQBa31OrooxFOQ0DxYKG/tY9lTwIsJB
	5YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=T5pJCvoVL1jFgiOABWaIy/SlC0FgTPbtTeCLF0KVYlg=;
	b=KDUHmoQc4wX2zklS/iyoOc/qx3Rh+Ss6iFAOgp+xVp0yBvWylWmoitXlQSma1ZE6JS
	C4nTa8e6EJEs+bhhYSvAgtA5KCcsRJ74h6xBb42Q6QBJL5sqVyH1C2XZyUbh4yfZC1d+
	dD1WQDNjpHi4W5ojCzB/Gf2N6k2KZGPwK361DAhaV22FjTNWcKqrQYvtkZN12Q2YcHiy
	Bw86YtSLFpZFiXYqxZm8c0cQHg2pWDY/bJM7LAu/e3rFrSXzHtEGJcvRA6WtE9UPeiKG
	8XrB2BztO8DIUtkSfE3lGRbiTVyU0uD6Ot1a4b/p2Hhb8BKCFy7K9J3ViODAVuotxyTd
	/Axg==
X-Gm-Message-State: APjAAAXnX/+pN/1KD5Les5kpaatcq6NcH4dfpfNd7hpLkYi08Mf+Z0Do
	5+HCa4fC7EJ7F7Z4lW0HbNdj+g==
X-Google-Smtp-Source: APXvYqz5ZWoG2qIpTbhb1G4o+WwtR7NsZH65Mrtx+0kbtWOET8UGf5LYvzJYf4A/NWOQqKU9TZhXkw==
X-Received: by 2002:a1c:e718:: with SMTP id e24mr864446wmh.104.1559843188201; 
	Thu, 06 Jun 2019 10:46:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:42 +0100
Message-Id: <20190606174609.20487-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 15/42] target/arm: Convert VFP VLDR and VSTR to
 decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP single load/store insns VLDR and VSTR to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index a57d972eaa7..de3bde4b55f 100644
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


