Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41180C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0868021883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCJWSj6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868021883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bOu-0007Iu-I7
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b04-0004WB-1y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b02-0002Mz-Ff
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b02-0002MC-3b
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:26 -0400
Received: by mail-pf1-x442.google.com with SMTP id h195so7359848pfe.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VBWptZwV41wrybglM+V4M0H5NWdfiBjh3fvGH/I8Il8=;
 b=lCJWSj6FvV6YXOL/SGlJ2Z+qLbaColkyYDbblmOn7Fb/57++oNnVzepyyFsNqSxdSf
 oMA5o4sY+VEyAR+sSxVIL2aXv2Bjma6i4nYuNxpUv+OsGDHBqEbALnEXsJ8N72QhxrE9
 jSYlDxmiy/puELGP98tNqGQ3/nPvRkW0sBktEtc+/Vf026xAa2Uaz7PJ/MGF+iHdg93C
 9IAxrdgtjV43/o7A/3S9M5kkHNGgj9g4oxdis0v5gEqkIL/puURJIikRXqV3YCvLo/AK
 pnP6SqpC2p22ztLjR+sjxxt5GPLw3KBVnEdOeu9ulPxStKq/eMlK8qt9o1kc8leHznRW
 C2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VBWptZwV41wrybglM+V4M0H5NWdfiBjh3fvGH/I8Il8=;
 b=WYr70ecBRXOCu87QGcAA0l/ihppGfcylA6Aa2zhSKhkhT7i8MUIU9rHZlaLEhYSzFC
 fxEh+ci4Fkp9ORE8sz/ZX2eZG8eNXnlekNuk9uwdUMK86vA1ssj3WUSDfEwD7DX1ObYm
 Qh022flXeA0S/9yUVoMGwkBNfKQsjyjTutTGoqJKU/IjDukOKfDI97r9MJdjau5c8KmV
 FZbx0KRBf5UxL93S5cAZiBJfTIEhrPOrKz/3hi45yjmq9wkqPZaxDiPNm1Nq24fsSwNK
 02Sc/tn9EBU2emy9yQvHvCWEs/aiXeZUcCD/sSynw3FCWIO7gcaAGgMDeeTM9U7jibmE
 qCgw==
X-Gm-Message-State: APjAAAWIa/0NipcDpy8B0Rfom5fKlo0xHU3dq1yvLcE1ehbOWEvktfRQ
 UERA6fbB/zhrIlTvF4kC3nK2WbhGUfo=
X-Google-Smtp-Source: APXvYqyttA+PAxzJyj67o13yz4DnKwhCU8O/yz5f99KDwMBEJwrqj8e8XHbVlZ1NS0t8O+jiSHho5Q==
X-Received: by 2002:a63:d04e:: with SMTP id s14mr34727644pgi.189.1567625484790; 
 Wed, 04 Sep 2019 12:31:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:09 -0700
Message-Id: <20190904193059.26202-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 19/69] target/arm: Convert T32 ADDW/SUBW
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 24 +++++++++++++-----------
 target/arm/a32.decode  |  1 +
 target/arm/t32.decode  | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 750331071b..7d12be4025 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7648,6 +7648,11 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
  * Constant expanders for the decoders.
  */
 
+static int negate(DisasContext *s, int x)
+{
+    return -x;
+}
+
 static int times_2(DisasContext *s, int x)
 {
     return x * 2;
@@ -8004,6 +8009,12 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
 #undef DO_ANY2
 #undef DO_CMP2
 
+static bool trans_ADR(DisasContext *s, arg_ri *a)
+{
+    store_reg_bx(s, a->rd, add_reg_for_lit(s, 15, a->imm));
+    return true;
+}
+
 /*
  * Multiply and multiply accumulate
  */
@@ -10724,17 +10735,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         store_reg(s, rd, tmp);
                     } else {
-                        /* Add/sub 12-bit immediate.  */
-                        if (insn & (1 << 23)) {
-                            imm = -imm;
-                        }
-                        tmp = add_reg_for_lit(s, rn, imm);
-                        if (rn == 13 && rd == 13) {
-                            /* ADD SP, SP, imm or SUB SP, SP, imm */
-                            store_sp_checked(s, tmp);
-                        } else {
-                            store_reg(s, rd, tmp);
-                        }
+                        /* Add/sub 12-bit immediate, in decodetree */
+                        goto illegal_op;
                     }
                 }
             } else {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index c7f156be6d..aac991664d 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -30,6 +30,7 @@
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
 &rr              rd rm
+&ri              rd imm
 &r               rm
 &i               imm
 &msr_reg         rn r mask
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 5116c6165a..be4e5f087c 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -27,6 +27,7 @@
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
+&ri              !extern rd imm
 &r               !extern rm
 &i               !extern imm
 &msr_reg         !extern rn r mask
@@ -121,6 +122,24 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
 }
 RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 
+# Data processing (plain binary immediate)
+
+%imm12_26_12_0   26:1 12:3 0:8
+%neg12_26_12_0   26:1 12:3 0:8 !function=negate
+@s0_rri_12       .... ... .... . rn:4 . ... rd:4 ........ \
+                 &s_rri_rot imm=%imm12_26_12_0 rot=0 s=0
+
+{
+  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%imm12_26_12_0
+  ADD_rri        1111 0.1 0000 0 .... 0 ... .... ........     @s0_rri_12
+}
+{
+  ADR            1111 0.1 0101 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%neg12_26_12_0
+  SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
+}
+
 # Multiply and multiply accumulate
 
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
-- 
2.17.1


