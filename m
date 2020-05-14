Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D09205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+C1TcS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D09205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFEx-0004es-12
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEko-0003tE-Pz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkn-00060c-PW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id y3so4399240wrt.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gjbVHc2/Yfi0L0CZNHhwdyHWC0bXOSnoFP1EIBL00CI=;
 b=S+C1TcS9VBDUw7Ckz8ooyTDTM5kGkLuGRM39GdGGt6YOpObpCVXENngOIElSBJjo8a
 ZOvrSlP364RcKdTenPb5mzwdgnCUUcUm4MzW6h+DwlowfGKGMGR9ifAP4lV9SfXPdOZt
 crEAjLY4MyWSDubjAzcoskgLvL9M3Q6fxYkNZoVdqdntPhJGaiqRCitWas/UuCiwzB0z
 QoWho/1S9/u7MmizAIwjJqwJefsSY8O0jHmm5WAfmBv+UuheCljQi7kTMGHPBRXgxkTr
 B/7g22OFKzwwG2gHd3TFYYNOlQ2BegHq4g+hyxx+Tq4i82T5dL6B4sIiOKBM1jhKBaRA
 c1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gjbVHc2/Yfi0L0CZNHhwdyHWC0bXOSnoFP1EIBL00CI=;
 b=FzB46gDta2gxcDZrracGse4UBgHwuVU2mY6DK/U1SFcvHCFYgNB6Bj7UWKoeLk7uYX
 feNrVUkGOwrBdEcvbSccJvL719ASQiuRBNdeQq0FfDj4k46hfSERVBlB7Ge56tInX5GE
 AxDxR7IPVCG/+hJOVAAjFpj6iYdDisqpWOCdmtq6St1ZorlcQK3KifcVO1RgnDzJ5gxQ
 tMiu4b4yXkzBDKWK6uItBqXU/J+AoujtOnuNkWTvGVqZpWWObbKGSFsO41pFE5JtvtxO
 LaT3yS4K4fm+tAdRw/0JDufQLxTin/vzppu0Rvwko8yMUOlA50zglxFHnVOXo58pP+qH
 kWHQ==
X-Gm-Message-State: AOAM531hHUdqI5isOvQlrBJ4lUBsAiYj2eDC8b3TvmDJsQniD5Hk92QS
 scklmgYjqrkwDQsSVSY9deik0vMrRi3c2A==
X-Google-Smtp-Source: ABdhPJx1w1KfWqp2QSt9USGYOpxNorNrUg9zv0viNSxugZIl1Kc8f+al4GFMSJq+TKLJCEzlI4W57Q==
X-Received: by 2002:adf:9447:: with SMTP id 65mr5803516wrq.331.1589466148118; 
 Thu, 14 May 2020 07:22:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/45] target/arm: Convert Neon VPADD 3-reg-same insns to
 decodetree
Date: Thu, 14 May 2020 15:21:30 +0100
Message-Id: <20200514142138.20875-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Convert the Neon integer VPADD 3-reg-same insns to decodetree.  These
are 'pairwise' operations.  (Note that VQRDMLAH, which shares the
same primary opcode but has U=1, has already been converted.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-10-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c |  2 ++
 target/arm/translate.c          | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 2edcaba9f85..3659fb036c7 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -152,6 +152,8 @@ VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
 VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 
+VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
+
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 
 SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7db6b856598..e0137364075 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -990,8 +990,10 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
 #define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
 #define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
 #define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
+#define gen_helper_neon_padd_u32  tcg_gen_add_i32
 
 DO_3SAME_PAIR(VPMAX_S, pmax_s)
 DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
+DO_3SAME_PAIR(VPADD, padd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 82be4d40282..ce30417014d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5397,13 +5397,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            if (!u) {
-                break;  /* VPADD */
-            }
-            /* VQRDMLAH : handled by decodetree */
-            return 1;
-
         case NEON_3R_VFM_VQRDMLSH:
             if (!u) {
                 /* VFM, VFMS */
@@ -5438,6 +5431,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
+        case NEON_3R_VPADD_VQRDMLAH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5448,9 +5442,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            pairwise = 1;
-            break;
         case NEON_3R_FLOAT_ARITH:
             pairwise = (u && size < 2); /* if VPADD (float) */
             break;
@@ -5528,14 +5519,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VPADD_VQRDMLAH:
-            switch (size) {
-            case 0: gen_helper_neon_padd_u8(tmp, tmp, tmp2); break;
-            case 1: gen_helper_neon_padd_u16(tmp, tmp, tmp2); break;
-            case 2: tcg_gen_add_i32(tmp, tmp, tmp2); break;
-            default: abort();
-            }
-            break;
         case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


