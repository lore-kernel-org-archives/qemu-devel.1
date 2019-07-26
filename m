Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE595C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAD821842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1/bN0yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAD821842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Yh-0001QC-4W
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nu-0007Ne-UA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0001Hp-Ep
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:01 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:40792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4No-000128-FJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id w10so25119067pgj.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZAbTmn5IF7GueTfMYNm2AkgzbEYkr29V4U+PzJz5VKI=;
 b=u1/bN0yvmLzzHZfwmGdJtqVQKUSWEOylJMAksCfq9jC94VNMAvZ3KCxdO1kjRUVRI6
 /bTeVsyiywp38B2aiqP//FyAkzUuRl95nOkshxh4D6x5g2A8+TwsmjmD2UM/dhvdWItc
 cC5txPzMn2csHMyVAQicSWkWb0VBDzdBsMkITEFB83azfPSRORtz/j9G/p48f30RBXGM
 zCr6V/F8+yN8j5yFjLQdbKntZoClfHfwad7andkRFLGfRiRZEh00ICVTiR39oUpdjfl/
 rjaffxT0QJgfGP9sEvNpbUVR4xDtiKs3tyRXi/ZfExQSKUIQPEVy58ZKY73hJsYukebj
 5iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZAbTmn5IF7GueTfMYNm2AkgzbEYkr29V4U+PzJz5VKI=;
 b=DafL8n7M81pkrRc+4z5gQ1Gofkcm3DmBFFrEbIiff6MYeETBJn4cvKc4UngdlYOzqa
 qsMC+BeLFcqNW4lyXG/4j3TO9HygtgqSFB/DFkprcBCQkAY6vHUOKsQQe+JT0u/Ay0rj
 rfvWwrCYqztyMLj5mFuduZmPPBoMnmsfPFAIp25S1N6VRhnHPGbK5xUPLYj8vgq/xeYJ
 H2DZeUQoHYkFlyRbjAZGnNPfeCe2Cv2F8f3kyPK++Y/2PVE54yFD3PE8Ow3RQBjUz5ET
 tnfMaKbnjsBIqj6FowB5kAKH7GhGOZ1vpyjJwWynX5exErGuOaU7WZI++zGSBlA7o8EA
 +V3w==
X-Gm-Message-State: APjAAAUmUDSBFoKsfkhKBRkp5Qd1s7fGXBCXVBf+D4B4LN4gu7R3vSOU
 hnFH+bjBA7I2i6w0ycAJZX8DaLlpQjA=
X-Google-Smtp-Source: APXvYqzrmQc1cWucSqv8uNqZ14ZglvHu5suHln/I2VRApib+EQhZYORbzAHoL+pLziNA3BSEVS9jMA==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id
 x15mr53334493pjt.82.1564163501445; 
 Fri, 26 Jul 2019 10:51:41 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:21 -0700
Message-Id: <20190726175032.6769-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PATCH 56/67] target/arm: Convert T16, Reverse bytes
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 18 +++---------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8f2adbbc7d..c9386ceefb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10616,7 +10616,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rn, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
     int i;
     TCGv_i32 tmp;
@@ -10815,20 +10815,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 break;
             }
 
-            /* Otherwise this is rev */
-            ARCH(6);
-            rn = (insn >> 3) & 0x7;
-            rd = insn & 0x7;
-            tmp = load_reg(s, rn);
-            switch (op1) {
-            case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-            case 1: gen_rev16(tmp, tmp); break;
-            case 3: gen_revsh(tmp, tmp); break;
-            default:
-                g_assert_not_reached();
-            }
-            store_reg(s, rd, tmp);
-            break;
+            /* Otherwise this is rev, in decodetree */
+            goto illegal_op;
         }
 
         case 6: /* setend, cps; in decodetree */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index f43ea6ce20..8864f89a81 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrr_rot         !extern rd rn rm rot
+&rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
@@ -195,3 +196,11 @@ SETEND          1011 0110 010 1 E:1 000         &setend
   CPS_v6m       1011 0110 011 im:1 00 I:1 F:1
   CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
 }
+
+# Reverse bytes
+
+@rdm            .... .... .. rm:3 rd:3          &rr
+
+REV             1011 1010 00 ... ...            @rdm
+REV16           1011 1010 01 ... ...            @rdm
+REVSH           1011 1010 11 ... ...            @rdm
-- 
2.17.1


