Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFCC47264
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5273E2075B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktYfZCgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5273E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVacL-0005P7-GU
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaID-0001Ak-7C
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIC-0001IX-A1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id f13so20664302wrm.13
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PB2k+btSaeaPZEheXtOJspuO2CstyB/BRj+8mRMF+Qs=;
 b=ktYfZCggCGlbsO2NS8BoNU8VB2IBhsA/FUAq+ySJNZWxYDUskWqd6o7ysgmqGh+1xy
 MoFjxJvdHGUXNV6VLBIb9JgVwzlZWbJAxuvWUHwRw7sbQT03Ksp1qsHWx/wlfjKkad6L
 T6imyPlkMWbPCP8MhlPy13C5EetRVJEupVZG2NtYCaHlErT1WgXNGwpnJvWVCPJUjzuQ
 NrWDREr3zv5E8ikR5MSssCxKS2IpsszExuBrT6ePXYSuRWGWVOYG+ezs6ouFUzReO4HM
 7+KaPfJboJdinu/6pcwhCpp3sSYovKmfZ6/BTk3dRsmAMhOR+WeQM/AyK6/GfKo5c0/0
 oDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PB2k+btSaeaPZEheXtOJspuO2CstyB/BRj+8mRMF+Qs=;
 b=OAB0hK33BZ88yiVOUD+rfJadFTUWTSaUJQ8WdlgiXohLUpxwaqHwkOxs3Jednk02Zs
 AgcL/noJxjtZLhWhwORRC6pTfVOhnEZMeepwfIT/kwen+ln0x6XRv4r4kQLkB0kRMcen
 jv9bbJkWNgXvmIXDUJfUS6lBg1vIny2ZRI3B7Y1fXO4E3+0F0byLQ6aGPEtEH20grIi1
 ytFFX2KJ2xw1vMFTI4WH3iOCDw9WQIXQpXw7/Z+8CPxeyD+lMcYV0ibpMtZy6L4fN7KD
 1plU67Ugh6ATYdsXT9yzOsm6ec6PPR2rwCVBnCPpBb9DYLeGXuw+SLaqSJ3lbpiia8Jm
 jaJQ==
X-Gm-Message-State: AGi0PuaWfOEt461KNIsNsTW57/VAba0OPRFbFg40LJYGdP3XZG3PXCnR
 fI9oNaBEKC2Uhyot2LgsUc62zA2MjO8YYw==
X-Google-Smtp-Source: APiQypKkFoSBOPDQhv0KZEEa4tXF/pepKiIYQGoRnzTHRyVOM/Rp+4lfSoTNLKashvwb42OI0l6qBQ==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr18586023wrc.214.1588595630676; 
 Mon, 04 May 2020 05:33:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/39] target/arm: Convert Neon 3-reg-same VMAX/VMIN to
 decodetree
Date: Mon,  4 May 2020 13:33:05 +0100
Message-Id: <20200504123309.3808-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
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

Convert the Neon 3-reg-same VMAX and VMIN insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-17-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  5 +++++
 target/arm/translate-neon.inc.c | 14 ++++++++++++++
 target/arm/translate.c          | 21 ++-------------------
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f62dbaa72d5..b721d39c7ba 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -54,5 +54,10 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
+VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
+VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
+VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 507f0abe801..ab1740201c4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -617,3 +617,17 @@ DO_3SAME(VEOR, tcg_gen_gvec_xor)
 DO_3SAME_BITSEL(VBSL, rd_ofs, rn_ofs, rm_ofs)
 DO_3SAME_BITSEL(VBIT, rm_ofs, rn_ofs, rd_ofs)
 DO_3SAME_BITSEL(VBIF, rm_ofs, rd_ofs, rn_ofs)
+
+#define DO_3SAME_NO_SZ_3(INSN, FUNC)                                    \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (a->size == 3) {                                             \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
+DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
+DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
+DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9affa92cbe7..2f054cfa783 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4899,25 +4899,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                              rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
             return 0;
 
-        case NEON_3R_VMAX:
-            if (u) {
-                tcg_gen_gvec_umax(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_smax(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            }
-            return 0;
-        case NEON_3R_VMIN:
-            if (u) {
-                tcg_gen_gvec_umin(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_smin(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            }
-            return 0;
-
         case NEON_3R_VSHL:
             /* Note the operation is vshl vd,vm,vn */
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
@@ -4926,6 +4907,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
+        case NEON_3R_VMAX:
+        case NEON_3R_VMIN:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


