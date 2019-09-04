Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F786208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFs7DNhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F786208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bBd-0007iF-N8
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b01-0004Rw-2p
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azz-0002KF-F0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azz-0002JX-8E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id x127so1220327pfb.7
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Br2b0vbKeN/2j/h9uyRFZAyuwQitptP6m+++156fwxo=;
 b=dFs7DNhzB5u2A91Ak+rjbPDGaGeks5wjKoIQ1+RLRSx/0nxs2YzaGimIR3Usv+tVBs
 mZvcoZkf8P2pIUSZy/EE8ymjymAhrLf/xdJwlVy8/uLR66mIS3Z3JVLBJ6OlPrKTT70n
 X6KVWYY8HN7LYYvjMWp6lejaEV4dO5G92Je/vPaaWhE8EN/Il8Gh9ZFmpek0gCXQ7gMp
 3uJoWzfv7m4dmg8/eGMYMwgLJmfLBKoGDKDdkWqVx5zTwDXjBJksJcdBT4fZ1rpOGb8p
 i6pm+M4dqNV1DnTDn04dk4GCSQGeW4Tmn1nICDVAUzew1eUFd/FofRGLLCj6Davx4tQs
 DMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Br2b0vbKeN/2j/h9uyRFZAyuwQitptP6m+++156fwxo=;
 b=LeHyM1CU0s6YegEeG6r+t6yOIeShXP4bZssK1eTrD1jwl3eHw+zsP1G4cHfqJc2WR+
 mM6jSRpxa2FZbLkyOIaIB5a2GhBh/jKT/T1h/Nwq7W72Xj+ZZWTvuoBvS6NbhrTx4AkM
 cTpa8V8nhhQNK8VHqharfyxaJE5BHv8+HxGKzDeZX7M4IKqgbo2JOiSNgjZltkiUFnUf
 fro6AbcJItdNCXbo+Cibhjaiy5/cs2ViDWy7o0jIg6Ir2MTR5Lf47d3Ur3OMOrTAVxiO
 /ufVIpjhIJLh8oAYorcwmcMjXv44pzvBBo9CHyt8DG6qRE5jWvc+Sjrv6JZEMF+1r8LN
 MNKA==
X-Gm-Message-State: APjAAAXQhRBwoHgaGbbMoivqqLw+IQJs+huqlZH/e9KcnphTFoTMJS3C
 sasqOF43L0olGZrVG10CntzhJNYCwhY=
X-Google-Smtp-Source: APXvYqwcBq1qJu3RFxmxwyJUlCRJOOMJjSC1qFt1CPRfgy4GV5BEAQxxm1NTnTqQGG0ocwqlWyrBAw==
X-Received: by 2002:a62:55c1:: with SMTP id
 j184mr28269987pfb.104.1567625481933; 
 Wed, 04 Sep 2019 12:31:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:07 -0700
Message-Id: <20190904193059.26202-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 17/69] target/arm: Convert ERET
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

Pass the T5 encoding of SUBS PC, LR, #IMM through the normal SUBS path
to make it clear exactly what's happening -- we hit ALUExceptionReturn
along that path.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use unallocated_encoding for IS_USER check.
---
 target/arm/translate.c | 62 ++++++++++++++++--------------------------
 target/arm/a32.decode  |  2 ++
 target/arm/t32.decode  |  8 ++++++
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7de6949db3..9589e9bbb9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8503,6 +8503,27 @@ static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
     return true;
 }
 
+static bool trans_ERET(DisasContext *s, arg_ERET *a)
+{
+    TCGv_i32 tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        unallocated_encoding(s);
+        return true;
+    }
+    if (s->current_el == 2) {
+        /* ERET from Hyp uses ELR_Hyp, not LR */
+        tmp = load_cpu_field(elr_el[2]);
+    } else {
+        tmp = load_reg(s, 14);
+    }
+    gen_exception_return(s, tmp);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8797,29 +8818,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x4: /* crc32 */
             /* All done in decodetree.  Illegal ops reach here.  */
             goto illegal_op;
-        case 0x5:
-            /* Saturating addition and subtraction.  */
+        case 0x5: /* Saturating addition and subtraction.  */
+        case 0x6: /* ERET */
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
-        case 0x6: /* ERET */
-            if (op1 != 3) {
-                goto illegal_op;
-            }
-            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
-                goto illegal_op;
-            }
-            if ((insn & 0x000fff0f) != 0x0000000e) {
-                /* UNPREDICTABLE; we choose to UNDEF */
-                goto illegal_op;
-            }
-
-            if (s->current_el == 2) {
-                tmp = load_cpu_field(elr_el[2]);
-            } else {
-                tmp = load_reg(s, 14);
-            }
-            gen_exception_return(s, tmp);
-            break;
         case 7:
         {
             int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
@@ -10628,24 +10630,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     case 4: /* bxj, in decodetree */
                         goto illegal_op;
                     case 5: /* Exception return.  */
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        if (rn != 14 || rd != 15) {
-                            goto illegal_op;
-                        }
-                        if (s->current_el == 2) {
-                            /* ERET from Hyp uses ELR_Hyp, not LR */
-                            if (insn & 0xff) {
-                                goto illegal_op;
-                            }
-                            tmp = load_cpu_field(elr_el[2]);
-                        } else {
-                            tmp = load_reg(s, rn);
-                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
-                        }
-                        gen_exception_return(s, tmp);
-                        break;
                     case 6: /* MRS, in decodetree */
                     case 7: /* MSR, in decodetree */
                         goto illegal_op;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 182f2b6725..52a66dd1d5 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -211,3 +211,5 @@ BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
 BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
 
 CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
+
+ERET             ---- 0001 0110 0000 0000 0000 0110 1110
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 67724efe4b..6236d28b99 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -218,4 +218,12 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
   }
   BXJ            1111 0011 1100 rm:4 1000 1111 0000 0000      &r
+  {
+    # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
+    # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
+    # The distinction between the two only matters for Hyp mode.
+    ERET         1111 0011 1101 1110 1000 1111 0000 0000
+    SUB_rri      1111 0011 1101 1110 1000 1111 imm:8 \
+                 &s_rri_rot rot=0 s=1 rd=15 rn=14
+  }
 }
-- 
2.17.1


