Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C2C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6572242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TA4HH1/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6572242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXc8P-0006w0-KG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7F-0005jM-F4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:13 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7D-0005mt-K7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id s22so1950090pga.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d+BfMFnltv94D9h3YrYpUyscB1U2BxczjPk7SPCCLHg=;
 b=TA4HH1/EaEUqJryZowq6/Pm6lsgaLlvfP4ghKfNOPI5toEVzyuo28n49H3mXTRZwC9
 odFBOwv7PcmcYiYUbDcskBl02NS8nBxjNjUE+W5XX2oocqVvVGTziLE3yW56PYilVd13
 PHwN7/D/jUgvZUfcD0gx4Jn8q459zunV09slwRjDgmRyubxpVd05DrtAsMLG6ZAG+wyH
 cibe6n0fida+j8cCgxjroNhRbgbmcatzfldQ3hQ1dqiBU+NF2PiTeLdDixHPU0tz4yPv
 jJSYylGsFLijpTK/j23aaTPYZbufarFTaEUMho4dbtSQZ5dqtfvf4ldLP5XJJ8RDnHBm
 reCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d+BfMFnltv94D9h3YrYpUyscB1U2BxczjPk7SPCCLHg=;
 b=D5guNRgQLg+iN1vIZ6b1Llqg1NrvN/3jgTNU1YZP9q9TShlvcJjDSuO3P885D03PhA
 KFEmuCR3d+1Zo2MYYirPwFrQd/tusN4HwqazVoZy7iooPepWHeleD7atX0K5HuuSmaeX
 Z01t131Job6BHylLlmlMPmj/+ip4OBvj8JRma6QQbej44FrmdC2VbsbzrbpzcuajTT5G
 y1M9Z1/CKkK21KBRTfUzaIzeXo3nIomB6I/DEptVDlgG+Pmf28yLhom85kYn7Z0KG6/g
 xH2R8X238JSapoKk0x52pphGIYLTUZgncYjrlmjkEBRSte59/2Ur4LaRKcMKB0IwOEXD
 TaQA==
X-Gm-Message-State: AOAM531Ac4I3e0pPraLFaRlbvIt32UbkOsBYtfBWBlACzdH6hVsbHSti
 ApCbmugLgzwocx0LkuCazZO4/faQr9sfYQ==
X-Google-Smtp-Source: ABdhPJyDnoyxfx0IIIiQFTDi/BccJ1hzMD/dQf4dTKXoDd5G4zoBJ5XSmn6PA0ll0U9dxLXRjFz33Q==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id
 q7-20020aa796070000b02901552b8593f5mr5269414pfg.36.1603855629736; 
 Tue, 27 Oct 2020 20:27:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] target/arm: Move neon_element_offset to translate.c
Date: Tue, 27 Oct 2020 20:26:54 -0700
Message-Id: <20201028032703.201526-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will shortly have users outside of translate-neon.c.inc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c          | 20 ++++++++++++++++++++
 target/arm/translate-neon.c.inc | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1b61e50f9c..bf0b5cac61 100644
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
index e259e24c05..96ab2248fc 100644
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
2.25.1


