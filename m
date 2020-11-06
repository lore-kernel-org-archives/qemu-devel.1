Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F32FC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733AC20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0+Fw83d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733AC20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasaw-00039o-Dl
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSP-0005vn-2u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:33 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSD-0007B3-5c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:32 -0500
Received: by mail-pl1-x643.google.com with SMTP id p4so33863plr.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wkypnopb5BzPYlv4jtMpd96OEpFhEMM9GKjZQ7ld/TU=;
 b=O0+Fw83dySV1vv5sKmEmGRTkh9KTnXeaOSaE9o7KHj9Vll2Ncx89JRC8e9Spga/P3T
 oSCj0hy5nxkgsmaavoDExjnUECniawcu5PPGaBie9i+/Wye+kW1UhCvhMBkn+T2HvsGt
 Ea4wCke+RUghjwPQGISCyC6GKMxleU8rtRwYchZ298LMw4zeeCv4uUD6bYXg0PCfZHgl
 61XM4eT9L4HPzFWEaaKeDcQrdCArai1gCzQmSHCqIriA4fLHiJsuO1sUkf8oBYBynrUx
 xZ8QnbVdmJ3kOuT6l+KL2fIQVZJKNls3EUu3VDR0SRMdQB2SIG7EevzFtd0KaHTNJjLK
 egfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wkypnopb5BzPYlv4jtMpd96OEpFhEMM9GKjZQ7ld/TU=;
 b=U/JlFWRy/g0Vwt9fiNxelm4OmCj8bJR7/ADzgLb6juigtSFhOmYCW9pRng6rUA4ib6
 RQ8MyQuRwX1RMZk7G345sD+6NddUlbxnCBnCTuZsvVbWPcUy+mQQnhtDoaaEmnoHhjTw
 5yKhxq9MwmFFHVtdW55QdqCDzcCjf9NvFAo0DVg9YoRn36PrHHMdH0EhmavxEF4cC6Li
 oM9Qdm1piCcqUJVUr4FwDRCydqeZuMXF5o/csGlXzKKB2eB+21aW4tpQ/Z5tSBohqMon
 3tApYnnKWLfqqZfJ14V+D2amwmZrFFH+BVyCVmlKaCfkBmaA/oTlGuPxdwcNkwVRnfMj
 Xv5A==
X-Gm-Message-State: AOAM533wXtyVmvutklP2e2GV4PCekUlLwOmmq4AHrvXFWcPINRgg3Tjf
 Qa2+FZ57k1pacPU4r7sbcCeJeNOf8cmuUg==
X-Google-Smtp-Source: ABdhPJxv7hM+aqOFg8iuiXoYaMaQeGjWGwqd68iHyYe0siQ6RIiECmVR2xg1ragAD2Qu0B1Z1edFhA==
X-Received: by 2002:a17:902:b604:b029:d5:d9d6:1938 with SMTP id
 b4-20020a170902b604b02900d5d9d61938mr123740pls.52.1604633405383; 
 Thu, 05 Nov 2020 19:30:05 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/41] tcg/s390: Use tcg_tbrel_diff
Date: Thu,  5 Nov 2020 19:29:10 -0800
Message-Id: <20201106032921.600200-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use tcg_tbrel_diff when we need a displacement to a label,
and with a NULL argument when we need the normalizing addend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 1444914428..e4c61fc014 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -630,7 +630,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
     } else if (USE_REG_TB && !in_prologue) {
-        ptrdiff_t off = sval - (uintptr_t)s->code_gen_ptr;
+        ptrdiff_t off = tcg_tbrel_diff(s, (void *)sval);
         if (off == sextract64(off, 0, 20)) {
             /* This is certain to be an address within TB, and therefore
                OFF will be negative; don't try RX_LA.  */
@@ -655,7 +655,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     } else if (USE_REG_TB && !in_prologue) {
         tcg_out_insn(s, RXY, LG, ret, TCG_REG_TB, TCG_REG_NONE, 0);
         new_pool_label(s, sval, R_390_20, s->code_ptr - 2,
-                       -(intptr_t)s->code_gen_ptr);
+                       tcg_tbrel_diff(s, NULL));
     } else {
         TCGReg base = ret ? ret : TCG_TMP0;
         tcg_out_insn(s, RIL, LARL, base, 0);
@@ -746,7 +746,7 @@ static void tcg_out_ld_abs(TCGContext *s, TCGType type, TCGReg dest, void *abs)
         }
     }
     if (USE_REG_TB) {
-        ptrdiff_t disp = abs - (void *)s->code_gen_ptr;
+        ptrdiff_t disp = tcg_tbrel_diff(s, abs);
         if (disp == sextract64(disp, 0, 20)) {
             tcg_out_ld(s, type, dest, TCG_REG_TB, disp);
             return;
@@ -956,7 +956,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
         if (!maybe_out_small_movi(s, type, TCG_TMP0, val)) {
             tcg_out_insn(s, RXY, NG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
             new_pool_label(s, val & valid, R_390_20, s->code_ptr - 2,
-                           -(intptr_t)s->code_gen_ptr);
+                           tcg_tbrel_diff(s, NULL));
             return;
         }
     } else {
@@ -1015,7 +1015,7 @@ static void tgen_ori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     } else if (USE_REG_TB) {
         tcg_out_insn(s, RXY, OG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
         new_pool_label(s, val, R_390_20, s->code_ptr - 2,
-                       -(intptr_t)s->code_gen_ptr);
+                       tcg_tbrel_diff(s, NULL));
     } else {
         /* Perform the OR via sequential modifications to the high and
            low parts.  Do this via recursion to handle 16-bit vs 32-bit
@@ -1050,7 +1050,7 @@ static void tgen_xori(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     } else if (USE_REG_TB) {
         tcg_out_insn(s, RXY, XG, dest, TCG_REG_TB, TCG_REG_NONE, 0);
         new_pool_label(s, val, R_390_20, s->code_ptr - 2,
-                       -(intptr_t)s->code_gen_ptr);
+                       tcg_tbrel_diff(s, NULL));
     } else {
         /* Perform the xor by parts.  */
         tcg_debug_assert(s390_facilities & FACILITY_EXT_IMM);
@@ -1108,12 +1108,12 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
                 op = (is_unsigned ? RXY_CLY : RXY_CY);
                 tcg_out_insn_RXY(s, op, r1, TCG_REG_TB, TCG_REG_NONE, 0);
                 new_pool_label(s, (uint32_t)c2, R_390_20, s->code_ptr - 2,
-                               4 - (intptr_t)s->code_gen_ptr);
+                               4 - tcg_tbrel_diff(s, NULL));
             } else {
                 op = (is_unsigned ? RXY_CLG : RXY_CG);
                 tcg_out_insn_RXY(s, op, r1, TCG_REG_TB, TCG_REG_NONE, 0);
                 new_pool_label(s, c2, R_390_20, s->code_ptr - 2,
-                               -(intptr_t)s->code_gen_ptr);
+                               tcg_tbrel_diff(s, NULL));
             }
             goto exit;
         } else {
-- 
2.25.1


