Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234392087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8z0f6M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234392087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bkc-0004Q5-ND
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0u-0005Vw-Ap
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0r-000396-Ni
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:19 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0r-00031c-Bx
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id w10so11781623pgj.7
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kYh+jTzMtTJhUz3xyrw306VQI42LXaHYhBmdbXyrNe4=;
 b=j8z0f6M1DbmESvbrLP6Ai+6mNPVjcfyALCXzvJ+N1/hv/9xQp9JCdpBI7SVBvIu9us
 dql2/jSKMRgHEIJBT87Y18/fvO5kg236IRb0R6mNAp2s1BM/dQKOcDh4pkLRj3KxyMpW
 EYZGWPeNCf9hKbhr6k4RyaFinT6JUsL+kAwurUYhd+1lj8qnzdATs5bJUuhVPbbD+UrR
 bqXrYY6XG3HezqMhic337kD9dUddbDt/XAQOUB1UWeleSsVnEyZqvmHLHg7MzbSvMbNa
 +9N/TZRp5aOclAy048u5yLVwIrFvs6xlm1lnoGCiBZseVztVV+3fwL3JNt69ZyotcQf4
 r52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kYh+jTzMtTJhUz3xyrw306VQI42LXaHYhBmdbXyrNe4=;
 b=n3yyG6y8kjaaKr3jKUFgjzxfktwYPPiz/rSwEA3oT4u4KOXURRi7M1e958TQok+/2j
 U+8jbsLQtefGud4h/dEO6qUiosQ2hUKelMaEGYdfnVKOU558ZApkD8XsiCBc2Qu0hTlf
 VU4PnXBrq1qA+so6tyU9xnmb+XrnegQEltSviUFp436fMu1VRJNnmavn4WybY2cRvcMy
 c6Sm7U0J9PW0Sk661M+mxnFkV5q4pdng3DcKidrdsRJ1qMj0g+8bQucnSi+V9fiKkqUK
 yliTavkrBw4+0TXHOeh0Men1G06NYoAbHmN8Li58iUiOhtznd56us2R7q0aBoF/U3RAO
 Sn4Q==
X-Gm-Message-State: APjAAAV3HWK6+LzopqlRk9bMaBs73uCequIM76QeGsVsPfdVykx0Dn0n
 p6hJPTiNtd/th/xI5B9afU4/8ZfK5Ms=
X-Google-Smtp-Source: APXvYqzQo4WNHxUh7pjEgkLigfVCINbpEvHdQ+e+SlOz19+teiM9N1QHpbhLUIXwHqtC/wmIDjP+Hg==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr35822424pgr.156.1567625528338; 
 Wed, 04 Sep 2019 12:32:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:43 -0700
Message-Id: <20190904193059.26202-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 53/69] target/arm: Convert T16 branch and
 exchange
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
 target/arm/translate.c | 70 +++++++++++++++++-------------------------
 target/arm/t16.decode  | 10 ++++++
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 405176527c..e6ef935247 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8364,7 +8364,7 @@ static bool trans_BX(DisasContext *s, arg_BX *a)
     if (!ENABLE_ARCH_4T) {
         return false;
     }
-    gen_bx(s, load_reg(s, a->rm));
+    gen_bx_excret(s, load_reg(s, a->rm));
     return true;
 }
 
@@ -8391,6 +8391,32 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+/*
+ * BXNS/BLXNS: only exist for v8M with the security extensions,
+ * and always UNDEF if NonSecure.  We don't implement these in
+ * the user-only mode either (in theory you can use them from
+ * Secure User mode but they are too tied in to system emulation).
+ */
+static bool trans_BXNS(DisasContext *s, arg_BXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        unallocated_encoding(s);
+    } else {
+        gen_bxns(s, a->rm);
+    }
+    return true;
+}
+
+static bool trans_BLXNS(DisasContext *s, arg_BLXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        unallocated_encoding(s);
+    } else {
+        gen_blxns(s, a->rm);
+    }
+    return true;
+}
+
 static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
 {
     TCGv_i32 tmp;
@@ -10756,49 +10782,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 }
                 break;
             case 3:
-            {
                 /* 0b0100_0111_xxxx_xxxx
                  * - branch [and link] exchange thumb register
+                 * In decodetree
                  */
-                bool link = insn & (1 << 7);
-
-                if (insn & 3) {
-                    goto undef;
-                }
-                if (link) {
-                    ARCH(5);
-                }
-                if ((insn & 4)) {
-                    /* BXNS/BLXNS: only exists for v8M with the
-                     * security extensions, and always UNDEF if NonSecure.
-                     * We don't implement these in the user-only mode
-                     * either (in theory you can use them from Secure User
-                     * mode but they are too tied in to system emulation.)
-                     */
-                    if (!s->v8m_secure || IS_USER_ONLY) {
-                        goto undef;
-                    }
-                    if (link) {
-                        gen_blxns(s, rm);
-                    } else {
-                        gen_bxns(s, rm);
-                    }
-                    break;
-                }
-                /* BLX/BX */
-                tmp = load_reg(s, rm);
-                if (link) {
-                    val = (uint32_t)s->base.pc_next | 1;
-                    tmp2 = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp2, val);
-                    store_reg(s, 14, tmp2);
-                    gen_bx(s, tmp);
-                } else {
-                    /* Only BX works as exception-return, not BLX */
-                    gen_bx_excret(s, tmp);
-                }
-                break;
-            }
+                goto illegal_op;
             }
             break;
         }
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 0654275e68..edddbfb9b8 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &ri              !extern rd imm
+&r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
@@ -144,3 +145,12 @@ MOV_rxi         00100 ... ........              @arith_1i %s
 CMP_xri         00101 ... ........              @arith_1i s=1
 ADD_rri         00110 ... ........              @arith_1i %s
 SUB_rri         00111 ... ........              @arith_1i %s
+
+# Branch and exchange
+
+@branchr        .... .... . rm:4 ...            &r
+
+BX              0100 0111 0 .... 000            @branchr
+BLX_r           0100 0111 1 .... 000            @branchr
+BXNS            0100 0111 0 .... 100            @branchr
+BLXNS           0100 0111 1 .... 100            @branchr
-- 
2.17.1


