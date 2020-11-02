Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31ABC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD692071A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPOpp8VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD692071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdMp-0002Dr-Su
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLT-0000Up-Vu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLQ-0006N5-Lr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:15 -0500
Received: by mail-wr1-x435.google.com with SMTP id b8so15524334wrn.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Yb81K1WgzUECohN6OsmqHKMszy1ABT92E/6OuxF9svY=;
 b=wPOpp8VHtXiTgV+myuUd/APwGrjWJXkCfl+7LQ/M/mGBPA+cWcIKovhCiSrQQoT4Io
 B9vyVJ9NAy5FaPyhfNQ/CBhjJx6mOIdzY7Vp2llaqAixIoQ92WD7mAAmp9Q8C/YvzZWH
 7lL1jqT0hPKy3iZ5PzxW+HApRRdafUuGUOs+8IpbxMziHNUdy7esL0R6f8e/D9loVH8N
 vKh+IIMhB1KXdc/Ldon7Jn+qOnLtlRvlv++dXl78kWzU9rPt9gc/HQrSY5asI09fgmoN
 ZZ57ANmOGK4uY/IbITHVy/oRODj8MXIC+xz6QpA2JIjPryau48Xvs/clHFZrVK4Eop0q
 4GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yb81K1WgzUECohN6OsmqHKMszy1ABT92E/6OuxF9svY=;
 b=GL47vEChyJeGdyQThO8isb8kdeMr9EOUSY/qOzSYeJCjWON/sNtaud5P4sHGlYCdIk
 /bqTP0scMoRusTU3ZooiZ1DU9EnPOCr/PhlJgLSCRcL7ibCNE0V1xAB0V9qK/+Mtlc8d
 mH7lwsZFVirWLp89nMu5RnLVmgLJn1URLCX53Wlb/WA9HB4TWHl5JcDmvqxhITfjOokO
 S48aZAermq5XrmvQ7yv57V1/FlhBwOkNVkj/VU0batfsnIBnKgX3a19omremv7GIShmG
 rDjodk4U2bf8vXF1RBrCFPizdo0oGPKcT5idS5Q1tSJ6Ga2eXrwyIc0+kOZSlEP8ZfTP
 WtnA==
X-Gm-Message-State: AOAM532zPXx5ojYAS4MMmJyOsKnGd1im3cwGPoe1WZ5zOBxgqS/6h9n+
 i/NfouOBNXD3fkCqZMjaVuAI6ni0UGnSug==
X-Google-Smtp-Source: ABdhPJzU0na+cw90ic0ZBPvxBB0HWh39emJwGfsunmm8YYbP3UAOLaoBNipUUzDdmp84F+Q1h6Tbig==
X-Received: by 2002:adf:81e5:: with SMTP id 92mr21277897wra.411.1604337010949; 
 Mon, 02 Nov 2020 09:10:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm: Move neon_element_offset to translate.c
Date: Mon,  2 Nov 2020 17:09:41 +0000
Message-Id: <20201102171005.30690-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Richard Henderson <richard.henderson@linaro.org>

This will shortly have users outside of translate-neon.c.inc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c          | 20 ++++++++++++++++++++
 target/arm/translate-neon.c.inc | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1b61e50f9c5..bf0b5cac616 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1102,6 +1102,26 @@ static long neon_full_reg_offset(unsigned reg)
     return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
 }
 
+/*
+ * Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
+ * where 0 is the least significant end of the register.
+ */
+static long neon_element_offset(int reg, int element, MemOp size)
+{
+    int element_size = 1 << size;
+    int ofs = element * element_size;
+#ifdef HOST_WORDS_BIGENDIAN
+    /*
+     * Calculate the offset assuming fully little-endian,
+     * then XOR to account for the order of the 8-byte units.
+     */
+    if (element_size < 8) {
+        ofs ^= 8 - element_size;
+    }
+#endif
+    return neon_full_reg_offset(reg) + ofs;
+}
+
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index e259e24c055..96ab2248fcf 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -60,25 +60,6 @@ static inline int neon_3same_fp_size(DisasContext *s, int x)
 #include "decode-neon-ls.c.inc"
 #include "decode-neon-shared.c.inc"
 
-/* Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
- * where 0 is the least significant end of the register.
- */
-static inline long
-neon_element_offset(int reg, int element, MemOp size)
-{
-    int element_size = 1 << size;
-    int ofs = element * element_size;
-#ifdef HOST_WORDS_BIGENDIAN
-    /* Calculate the offset assuming fully little-endian,
-     * then XOR to account for the order of the 8-byte units.
-     */
-    if (element_size < 8) {
-        ofs ^= 8 - element_size;
-    }
-#endif
-    return neon_full_reg_offset(reg) + ofs;
-}
-
 static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)
 {
     long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
-- 
2.20.1


