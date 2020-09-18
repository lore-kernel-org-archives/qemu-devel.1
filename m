Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED64C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B012621534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko3y9Fgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B012621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLOv-0007tb-Mj
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGz-00081J-Fn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:17 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGx-00074k-Il
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t7so3624140pjd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o4kREfopSj9D5g5uleOIWdafqm7OqEWz1vFizJAa+RE=;
 b=Ko3y9FgoJa1N4yIDQaYR1wRaSybnb9sjMCC7Qw+OxR/mVbb5wskMDdHu9P6qKP2mgX
 EBBqA0iHdWQVX6Z4ht1UZoGbBSOQxyK7qWILsq6THIWyaYvPe4sLiDkNQk+KMAR7rhn8
 SJyizt2EaLI+/ZSyq+DT1H+kYH91jiL62pqQ3rNbGRNME9Cyhm8yn4dWzRczDWIBFFGW
 stUb8VdUblmYy4pSOLbwBaVXJ8D/dkxqPi7PXcHIE4tci/fyJk+7BwoOMTHcLWGCKMsu
 yCaqtii9p2OVrmDKxEBWLhc7iPanQcRrxWuc4y0sD6cMmmZvLDd/DtA8GmDozMpTCWac
 25Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o4kREfopSj9D5g5uleOIWdafqm7OqEWz1vFizJAa+RE=;
 b=F9gYBOWiQ3m9vn1/PHgYjXOBdHn67FhcIbDDsweBNYv3l0m4BDAfe5Wv6rw89JIVu+
 Cipjwtxeg9aIrlDQtIhuVrGvXnz4e+ujJJKJX3dXHrz5HMN4+Sr/q6v/u4EFZyzrIZe7
 5lJ2jfg5P2sokG2MHMRuCKFmI3ZejyYZgfPtXtnupBNYdBs4YDoXor0fMq/QEQjAZWrc
 HWqH7kFe388Co+dKNtq1RlEffjyULWPQycNhSd3TWTe59mZiSU8flkgFPumKVNzihBhw
 FrmH6xCs5PVtL/ygFgl+HKpw/61NVD0y/5ukS6q5niwr7TsC8ai1oZGcouPwrPQ2eJX5
 2OLA==
X-Gm-Message-State: AOAM532ACaAH+vDXvb4SzeE+DjSBZnpp1kwNG9eJjVvW0i1nmG5aI3Uv
 DXdyrLLkDFnR3EWxtErESZdy+4cp+ZSb9A==
X-Google-Smtp-Source: ABdhPJzPuLPYd67XHDL650FRdTqHON30vBJIOAjkhFWc7A0ozHisnmaQscfR7rHeLmB5mQIO1BztnA==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id
 h11mr13619138pjs.195.1600454293867; 
 Fri, 18 Sep 2020 11:38:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/81] target/arm: Implement SVE2 integer add/subtract wide
Date: Fri, 18 Sep 2020 11:36:45 -0700
Message-Id: <20200918183751.2787647-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix select offsets (laurent desnogues).
---
 target/arm/helper-sve.h    | 16 ++++++++++++++++
 target/arm/sve.decode      | 12 ++++++++++++
 target/arm/sve_helper.c    | 30 ++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 676ddfbb2d..a3cbfe0ea5 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1391,6 +1391,22 @@ DEF_HELPER_FLAGS_4(sve2_uabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_saddw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_ssubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uaddw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_usubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a28172c017..b9a34726d6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1184,3 +1184,15 @@ UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
 SADDLBT         01000101 .. 0 ..... 1000 00 ..... .....  @rd_rn_rm
 SSUBLBT         01000101 .. 0 ..... 1000 10 ..... .....  @rd_rn_rm
 SSUBLTB         01000101 .. 0 ..... 1000 11 ..... .....  @rd_rn_rm
+
+## SVE2 integer add/subtract wide
+
+SADDWB          01000101 .. 0 ..... 010 000 ..... .....  @rd_rn_rm
+SADDWT          01000101 .. 0 ..... 010 001 ..... .....  @rd_rn_rm
+UADDWB          01000101 .. 0 ..... 010 010 ..... .....  @rd_rn_rm
+UADDWT          01000101 .. 0 ..... 010 011 ..... .....  @rd_rn_rm
+
+SSUBWB          01000101 .. 0 ..... 010 100 ..... .....  @rd_rn_rm
+SSUBWT          01000101 .. 0 ..... 010 101 ..... .....  @rd_rn_rm
+USUBWB          01000101 .. 0 ..... 010 110 ..... .....  @rd_rn_rm
+USUBWT          01000101 .. 0 ..... 010 111 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ca39b0f6f1..75b87b1070 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1156,6 +1156,36 @@ DO_ZZZ_TB(sve2_uabdl_d, uint64_t, uint32_t,     , H1_4, DO_ABD)
 
 #undef DO_ZZZ_TB
 
+#define DO_ZZZ_WTB(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    int sel2 = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPEN); \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {              \
+        TYPEW nn = *(TYPEW *)(vn + HW(i));                     \
+        TYPEW mm = *(TYPEN *)(vm + HN(i + sel2));              \
+        *(TYPEW *)(vd + HW(i)) = OP(nn, mm);                   \
+    }                                                          \
+}
+
+DO_ZZZ_WTB(sve2_saddw_h, int16_t, int8_t, H1_2, H1, DO_ADD)
+DO_ZZZ_WTB(sve2_saddw_s, int32_t, int16_t, H1_4, H1_2, DO_ADD)
+DO_ZZZ_WTB(sve2_saddw_d, int64_t, int32_t,     , H1_4, DO_ADD)
+
+DO_ZZZ_WTB(sve2_ssubw_h, int16_t, int8_t, H1_2, H1, DO_SUB)
+DO_ZZZ_WTB(sve2_ssubw_s, int32_t, int16_t, H1_4, H1_2, DO_SUB)
+DO_ZZZ_WTB(sve2_ssubw_d, int64_t, int32_t,     , H1_4, DO_SUB)
+
+DO_ZZZ_WTB(sve2_uaddw_h, uint16_t, uint8_t, H1_2, H1, DO_ADD)
+DO_ZZZ_WTB(sve2_uaddw_s, uint32_t, uint16_t, H1_4, H1_2, DO_ADD)
+DO_ZZZ_WTB(sve2_uaddw_d, uint64_t, uint32_t,     , H1_4, DO_ADD)
+
+DO_ZZZ_WTB(sve2_usubw_h, uint16_t, uint8_t, H1_2, H1, DO_SUB)
+DO_ZZZ_WTB(sve2_usubw_s, uint32_t, uint16_t, H1_4, H1_2, DO_SUB)
+DO_ZZZ_WTB(sve2_usubw_d, uint64_t, uint32_t,     , H1_4, DO_SUB)
+
+#undef DO_ZZZ_WTB
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 02eba872f9..a3eba11bab 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6030,3 +6030,23 @@ DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
 DO_SVE2_ZZZ_TB(SADDLBT, saddl, false, true)
 DO_SVE2_ZZZ_TB(SSUBLBT, ssubl, false, true)
 DO_SVE2_ZZZ_TB(SSUBLTB, ssubl, true, false)
+
+#define DO_SVE2_ZZZ_WTB(NAME, name, SEL2) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)       \
+{                                                               \
+    static gen_helper_gvec_3 * const fns[4] = {                 \
+        NULL,                       gen_helper_sve2_##name##_h, \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d, \
+    };                                                          \
+    return do_sve2_zzw_ool(s, a, fns[a->esz], SEL2);            \
+}
+
+DO_SVE2_ZZZ_WTB(SADDWB, saddw, false)
+DO_SVE2_ZZZ_WTB(SADDWT, saddw, true)
+DO_SVE2_ZZZ_WTB(SSUBWB, ssubw, false)
+DO_SVE2_ZZZ_WTB(SSUBWT, ssubw, true)
+
+DO_SVE2_ZZZ_WTB(UADDWB, uaddw, false)
+DO_SVE2_ZZZ_WTB(UADDWT, uaddw, true)
+DO_SVE2_ZZZ_WTB(USUBWB, usubw, false)
+DO_SVE2_ZZZ_WTB(USUBWT, usubw, true)
-- 
2.25.1


