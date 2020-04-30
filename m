Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D6C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1547F20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MijK5GN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDoW-0000FM-3Y
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeH-0001lm-5Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdm-0001Bb-4G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdl-0001Aw-Iy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so3072662wmh.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w26jlTM40qeiGBZbRUdPuo9dr2IcHrAl6DOSMQrLqTU=;
 b=MijK5GN2MAeztVmQfmDcBtPFMzB4bdg94jj0PeE8J33AI2Y3Mr2QKpPLhv7ZgaJL/+
 sJR6tS8hb3dZonsGEWybTuyTUCWq99xRHd6L3xA/em/FVGURwvXZz7EetX8Bno66LrVh
 noyGs24M5lSEB+lriHAhrBXYah0gLni2IhCqxJQRpEDb2vXnL1pmJHbTgOS82qb2FP4q
 7cKAgGPFW0y1wcYuXq3IHEYx38w4hVpSeyRK1IuREqLfZaEQu9kYRutUm0s3MFkyu0Py
 0/YkcG/WCbt+EUAebTe6uSOmPzey4ANW0rBT551qCiHJD4K5ot3ILp30DDNFr+Vq2gWE
 tI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w26jlTM40qeiGBZbRUdPuo9dr2IcHrAl6DOSMQrLqTU=;
 b=AmklU/AYY25lCRbndUPV+ShgVn5iKj8+aDssJVGjw0UGC2qsfsMl6Bt+HLeAruCZ5o
 B66rI+oAlhdS6DsyZ7c5nnFnWouk9qNSVaO1yNlto8oL4DpAcU2IRX+eDH3sz3uz9Wu4
 PGUHracRSXbxkNX2x3yskLeXKVFMs6AzTTMqbskfUFj74/1RDN1a11CF45YVLLD58quq
 +CzXAkqxVbTU9tmmIa/IZWAqFj343GU23QC8GnJ9DiDo7dlw8Qxq8Wbna4r3LNRki0ZD
 ACLdFm5EbqmexGu1ox2wRWv9bqPjs08Bo4D/LCilRaPu8VP6gBVzKbvroxdBFNhKSQed
 L8Dg==
X-Gm-Message-State: AGi0PuZjp3P6XGJ6GPwXD1IoFst1I8q6YHB+2V1BExjh2wE04NRG/2TP
 jIwtB4I2liVHsAPV/2qfVcYYIw==
X-Google-Smtp-Source: APiQypJSi+2ZyjzucDjkop74LRZCl0PdgQfFsXEur3cMyq57X1Nqu1lwJtneNTuIY2G+7lNdQ6B0FQ==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr4147308wmi.57.1588270228231; 
 Thu, 30 Apr 2020 11:10:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/36] target/arm: Convert Neon 3-reg-same comparisons to
 decodetree
Date: Thu, 30 Apr 2020 19:09:44 +0100
Message-Id: <20200430181003.21682-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon comparison ops in the 3-reg-same grouping
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 22 ++++++++++++++++++++++
 target/arm/translate.c          | 23 +++--------------------
 target/arm/neon-dp.decode       |  8 ++++++++
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index ab1740201c4..952e4456f5e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -631,3 +631,25 @@ DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
 DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
 DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
 DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
+
+#define DO_3SAME_CMP(INSN, COND)                                        \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_cmp(COND, vece, rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz); \
+    }                                                                   \
+    DO_3SAME_NO_SZ_3(INSN, gen_##INSN##_3s)
+
+DO_3SAME_CMP(VCGT_S, TCG_COND_GT)
+DO_3SAME_CMP(VCGT_U, TCG_COND_GTU)
+DO_3SAME_CMP(VCGE_S, TCG_COND_GE)
+DO_3SAME_CMP(VCGE_U, TCG_COND_GEU)
+DO_3SAME_CMP(VCEQ, TCG_COND_EQ)
+
+static void gen_VTST_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                         uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &cmtst_op[vece]);
+}
+DO_3SAME_NO_SZ_3(VTST, gen_VTST_3s)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a22aee802a5..7e4a57157c2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4879,26 +4879,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                            u ? &mls_op[size] : &mla_op[size]);
             return 0;
 
-        case NEON_3R_VTST_VCEQ:
-            if (u) { /* VCEQ */
-                tcg_gen_gvec_cmp(TCG_COND_EQ, size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            } else { /* VTST */
-                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
-                               vec_size, vec_size, &cmtst_op[size]);
-            }
-            return 0;
-
-        case NEON_3R_VCGT:
-            tcg_gen_gvec_cmp(u ? TCG_COND_GTU : TCG_COND_GT, size,
-                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
-            return 0;
-
-        case NEON_3R_VCGE:
-            tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
-                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
-            return 0;
-
         case NEON_3R_VSHL:
             /* Note the operation is vshl vd,vm,vn */
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
@@ -4909,6 +4889,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
         case NEON_3R_VMIN:
+        case NEON_3R_VTST_VCEQ:
+        case NEON_3R_VCGT:
+        case NEON_3R_VCGE:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index b721d39c7ba..b89ea6819a9 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -54,6 +54,11 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VCGT_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 0 .... @3same
+VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
+VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
+VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
@@ -61,3 +66,6 @@ VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
 
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
+
+VTST_3s          1111 001 0 0 . .. .... .... 1000 . . . 1 .... @3same
+VCEQ_3s          1111 001 1 0 . .. .... .... 1000 . . . 1 .... @3same
-- 
2.20.1


