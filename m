Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD264C04AA8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BFF21743
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAJH9WPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BFF21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhbX-0006ts-Cv
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:16:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRT-0006Vb-Qv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRQ-0002ty-4Y
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRP-0002tF-Un
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id z8so7764305pln.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=g21xzi0Yfw56hjH6+dWM672fvCsm0wfniT6hVRPX/0U=;
	b=cAJH9WPL3m8+3hrrT9Sl+dxS03jKc5J4MmL9Ocq2D4tY7SyIJ3eVHsUe0aWz+7zxTu
	zXg3gx2z51OgUp4SL/JTe82h8mMNfcVqrLhUlkJYI/tv1QUTZXplhtV2vp0oW8DD+6LR
	wzr6czBXSsgUibKNpVMDWIpgv5yM9xWaSt+I6818bhiWjRffflY5T76eFLRBZyNIOb1Y
	TdX2h2tbqzJ7Tsd3vP5+njK7+4+n6homLGtolh2lF3HDlssfu8EQUnY5FMckN842Q91u
	6kF5rLnWjHP/qqSdk4jgtmhPQPPDPlGRaID5gjsZ386wWtFWBOv8Kcztkqx1Rh7rJ6UV
	uxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=g21xzi0Yfw56hjH6+dWM672fvCsm0wfniT6hVRPX/0U=;
	b=bw1Il89jMAqgLSnJ6jZJljBntPmhlvaSvgFkM+0a8Z7cuAuRk8hASO3jzYeBZjjH3f
	Yzsw9k6RCtNmwx9Gee5B4HWbPbrEdHJDpJNWUK7Vql4lV8oI38insNYd3K3+VdNeaWZB
	7rbFEeXTapmVUh6tFhp8JtydL03/9cCjr+r0spvKmsDOuxRdSd9rdaNyu+sNnLRJPOUN
	XKhzO2UamUBb2iFPg/5kFcrkhucmbtRgW2Dqg3bj47GCRfijCyk3dDr8kLdKbg5b0Nx0
	b6XgwtiTXTtiIz5Gmw3/MZBrDylmQZbkSUQy7sgg2zYThPYWtpQjO4Ck7w4gSt7l4eHm
	0AsA==
X-Gm-Message-State: APjAAAXHcJq2SoFuyCSF2y7ylKZib6I1ymRM1DDu52hKTcnpCAXQBo4w
	WGNImA0QdH+7nH4kSsDEPkuW2agW5RQ=
X-Google-Smtp-Source: APXvYqwjPor8mVx+SPT3J5SBuadzD9YgCa1pKADNW7I5sSq/xo1KjOUtQoxlVvClqS1JnlQRjR6yaw==
X-Received: by 2002:a17:902:7b97:: with SMTP id
	w23mr67921813pll.335.1556687158590; 
	Tue, 30 Apr 2019 22:05:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:19 -0700
Message-Id: <20190501050536.15580-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 12/29] tcg/aarch64: Implement
 tcg_out_dupm_vec
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050519.O9QnZM6nTA0cIoSFeADRK0AzuywjlU_EeMZIJvydCwM@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 4a3cfa778a..411fb463ac 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -381,6 +381,9 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* AdvSIMD load/store single structure.  */
+    I3303_LD1R      = 0x0d40c000,
+
     /* Load literal for loading the address at pc-relative offset */
     I3305_LDR       = 0x58000000,
     I3305_LDR_v64   = 0x5c000000,
@@ -414,6 +417,8 @@ typedef enum {
     I3312_LDRVQ     = 0x3c000000 | 3 << 22 | 0 << 30,
     I3312_STRVQ     = 0x3c000000 | 2 << 22 | 0 << 30,
 
+
+
     I3312_TO_I3310  = 0x00200800,
     I3312_TO_I3313  = 0x01000000,
 
@@ -566,7 +571,14 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
-static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+static void tcg_out_insn_3303(TCGContext *s, AArch64Insn insn, bool q,
+                              TCGReg rt, TCGReg rn, unsigned size)
+{
+    tcg_out32(s, insn | (rt & 0x1f) | (rn << 5) | (size << 10) | (q << 30));
+}
+
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
+                              int imm19, TCGReg rt)
 {
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
@@ -825,7 +837,29 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    return false;
+    if (offset != 0) {
+        AArch64Insn add_insn = I3401_ADDI;
+        TCGReg temp = TCG_REG_TMP;
+
+        if (offset < 0) {
+            add_insn = I3401_SUBI;
+            offset = -offset;
+        }
+        if (offset <= 0xfff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset);
+        } else if (offset <= 0xffffff) {
+            tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff000);
+            if (offset & 0xfff) {
+                tcg_out_insn_3401(s, add_insn, 1, temp, base, offset & 0xfff);
+            }
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
+            tcg_out_insn(s, 3502, ADD, 1, temp, temp, base);
+        }
+        base = temp;
+    }
+    tcg_out_insn(s, 3303, LD1R, type == TCG_TYPE_V128, r, base, vece);
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
-- 
2.17.1


