Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0BFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45ECE2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYH0QYOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ECE2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmct-0006mg-H1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCE-00023y-Rx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:33078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCB-000386-9F
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id b7so2993588pju.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BPPBRhqQhzVipTu/GwvwF4ZpzBDHMnXz++JILhmzMX4=;
 b=QYH0QYOKUUy2+xiBc+7iT7vST5zwEVI6fSycTuaItZjzEevpGluM2SYeJvFyKSF3Pw
 qeYxci32TGNsfWBmonDQ1khniATBhGxJm0lhfPp7BdTuIqinJK5j3fY3rQuT/dmZdjkL
 r2+U5asas3QSAD9o4g395IOfcuNDA/q//xwcj2wSTf0pgINTYf5HkKRjsFf4jZnexBnA
 hQkIG6bBRbdLV8EKCv6T8PAI4uA2Ft2LtjA6TFRqt0JcpRHFECHqa5bt28ShdBAP/lZ5
 3grKo9x2eSDDuggP+ljxRjkt2AhlK4aqwZyB2oVY383x+GJIDDEcpeV8WD4pJmmQkmFU
 SlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BPPBRhqQhzVipTu/GwvwF4ZpzBDHMnXz++JILhmzMX4=;
 b=NHjLHeCu/kdcmQPTRciehNKia99hct5HPRT5M6F3N1f1Y78EoKLzSqxXBr9qtbtayr
 3oBPUWVinxX4SKJ1h7fIRaqow4A3iaMSF4DvCdSO159meZNkIivUie7DFUI/Gv0Y0vkk
 lB9rnEl1J8bwqxEQQvzoc20URq83xoNYoxFvMGBHHFq3YYiugc78sNnzqaplbKwWUgIs
 93XntQYGvoJ7G2//iX8MYzxh+Tc7KDF7mVfBBKdxCQVJOGNahDizhS50/g6uvkxSqL5L
 C9l/ipydBK2pMYacFbA5/Y5QsZArvMvLfwBNgPTZCCOPO0/lmtCjh8CkJxWA/MNy1QNL
 pvFw==
X-Gm-Message-State: AOAM532RjivmVWulrIjOhoWiZtfMfBZpN2XCSpfjUCm5xncF3tWpEuV8
 rEqeZOAhKrdJN+lYbYTm4uweyp5+s/I=
X-Google-Smtp-Source: ABdhPJyusl0RrfE2Omf6I4EcbiYCTF7QBhd/biXzOwvwFesuLe+WvJKlQZOVRWXtEpYAPLjFhEyEJw==
X-Received: by 2002:a17:902:d394:: with SMTP id
 e20mr2220122pld.79.1592454631880; 
 Wed, 17 Jun 2020 21:30:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i191sm1298861pfe.99.2020.06.17.21.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 054/100] target/arm: Implement SVE2 ADDHNB, ADDHNT
Date: Wed, 17 Jun 2020 21:25:58 -0700
Message-Id: <20200618042644.1685561-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200417162231.10374-2-steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  8 ++++++++
 target/arm/sve.decode      |  5 +++++
 target/arm/sve_helper.c    | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 13 +++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4029093564..84281e3f9d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2021,6 +2021,14 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_addhnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_addhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a03d6107da..af9e87e88d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1320,6 +1320,11 @@ UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
+## SVE2 integer add/subtract narrow high part
+
+ADDHNB          01000101 .. 1 ..... 011 000 ..... .....  @rd_rn_rm
+ADDHNT          01000101 .. 1 ..... 011 001 ..... .....  @rd_rn_rm
+
 ### SVE2 Character Match
 
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b4613d90dc..7f3dd2dfdb 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2091,6 +2091,42 @@ DO_SHRNT(sve2_uqrshrnt_d, uint64_t, uint32_t,     , H1_4, DO_UQRSHRN_D)
 #undef DO_SHRNB
 #undef DO_SHRNT
 
+#define DO_BINOPNB(NAME, TYPEW, TYPEN, SHIFT, OP)                           \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
+{                                                                           \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {                           \
+        TYPEW nn = *(TYPEW *)(vn + i);                                      \
+        TYPEW mm = *(TYPEW *)(vm + i);                                      \
+        *(TYPEW *)(vd + i) = (TYPEN)OP(nn, mm, SHIFT);                      \
+    }                                                                       \
+}
+
+#define DO_BINOPNT(NAME, TYPEW, TYPEN, SHIFT, HW, HN, OP)                   \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
+{                                                                           \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {                           \
+        TYPEW nn = *(TYPEW *)(vn + HW(i));                                  \
+        TYPEW mm = *(TYPEW *)(vm + HW(i));                                  \
+        *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = OP(nn, mm, SHIFT);         \
+    }                                                                       \
+}
+
+#define DO_ADDHN(N, M, SH)  ((N + M) >> SH)
+
+DO_BINOPNB(sve2_addhnb_h, uint16_t, uint8_t, 8, DO_ADDHN)
+DO_BINOPNB(sve2_addhnb_s, uint32_t, uint16_t, 16, DO_ADDHN)
+DO_BINOPNB(sve2_addhnb_d, uint64_t, uint32_t, 32, DO_ADDHN)
+
+DO_BINOPNT(sve2_addhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_ADDHN)
+DO_BINOPNT(sve2_addhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_ADDHN)
+DO_BINOPNT(sve2_addhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_ADDHN)
+
+#undef DO_ADDHN
+
+#undef DO_BINOPNB
+
 /* Fully general four-operand expander, controlled by a predicate.
  */
 #define DO_ZPZZZ(NAME, TYPE, H, OP)                           \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0ad55ad243..7dc30ed1bd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7023,6 +7023,19 @@ static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+#define DO_SVE2_ZZZ_NARROW(NAME, name)                                    \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)                 \
+{                                                                         \
+    static gen_helper_gvec_3 * const fns[4] = {                           \
+        NULL,                       gen_helper_sve2_##name##_h,           \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d,           \
+    };                                                                    \
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);                            \
+}
+
+DO_SVE2_ZZZ_NARROW(ADDHNB, addhnb)
+DO_SVE2_ZZZ_NARROW(ADDHNT, addhnt)
+
 static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
                                gen_helper_gvec_flags_4 *fn)
 {
-- 
2.25.1


