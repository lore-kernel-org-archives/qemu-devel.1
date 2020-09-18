Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589FE221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrK7WOsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589FE221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLxh-0004SA-CR
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIB-000144-Cs
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:47038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0007GV-0Z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:31 -0400
Received: by mail-pg1-x52a.google.com with SMTP id 34so3965882pgo.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Myz+Lsz2iwOPmsiQ4nxJKVJHSA2kWzSrZKdUlA8XURc=;
 b=UrK7WOsiz3KescKGh9Dx2c1IKhdkjEh2Mycnv4zxd39k25cFF5UbLerm8Ninkp1Snd
 TiBvygQ47Cybxcb7PHujx9StUNRnXH4R0Dfw7wMcumxiM4Ie8TOwPYHkeLnTzYQVzGPi
 e8f6jO8wbZulvztpKMf5Sb+AhpYGeq7kAr0LjZAZ3P25xfKMVApX7mKZ9KfEH8Utf7hS
 0qwmOgAOBiQggFTX83PQMEq5kze1u5utTt9M4ADch8xQIHqsEY+5UwO8iafXFYpkb7xc
 ecwIcf62o70mbm0q/uE1KNhd4tp8YEgLgPQILoN3MxMv0R5VJ0C6+UH0Boef6HdGkTbm
 DywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Myz+Lsz2iwOPmsiQ4nxJKVJHSA2kWzSrZKdUlA8XURc=;
 b=AEbGvg7YS95xcgAFmKVSvrwo6A0En5rMGZoOEGPs5Pe/0C0u/E8vGu4S1F4xjhsDoC
 quxCPu2ZJ6lGgiAySQSAYvuy9QQDPjHHdQWeNb9Ik5WOCbe0l3uMTk6V36YeknnLnYxi
 hb3a2GKLAL5Z6YKqLCH8MK2q9YAMr38ylA26wI9DD4ek837p92Ab+GYhMe0/UCsarQyO
 L2QhB0JKorsezgLaS0QiCh+79AUfiW9t86/mFbz9HcZwSWMnuTaPrS02+NyOrHb7+N9G
 LhIYyERuDo7ExuslIuoj5FPSXU/AHpd0X9AebVK1jXMvSMZgDXo8FHQ2lMA19C+bOmk1
 Du1Q==
X-Gm-Message-State: AOAM530KdWgjoqxnN0uRcWAGKuoEK0UB5kUT1DKjG4mIDmxVHtUnQzRL
 7nxLOqjTzgzfJJzuyFU5WMKofxwz5ZP85Q==
X-Google-Smtp-Source: ABdhPJwMWOF61vqmUTlETHYUf6V9hPuy6IlOw+V0Y3nCK8plpdUJeqyGLdywK/2VDcYKtrPnqPKiqw==
X-Received: by 2002:a62:5a04:0:b029:142:2501:397f with SMTP id
 o4-20020a625a040000b02901422501397fmr17135229pfb.68.1600454361056; 
 Fri, 18 Sep 2020 11:39:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 66/81] target/arm: Implement SVE mixed sign dot product
Date: Fri, 18 Sep 2020 11:37:36 -0700
Message-Id: <20200918183751.2787647-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 target/arm/helper.h        |  2 ++
 target/arm/sve.decode      |  4 ++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 target/arm/vec_helper.c    | 18 ++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0f17b59f45..868c2e9121 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -599,6 +599,8 @@ DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 51acbfa797..0be8a020f6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1523,6 +1523,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
+## SVE mixed sign dot product
+
+USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+
 ### SVE2 floating point matrix multiply accumulate
 
 FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ae61659b1d..4341b83414 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8111,3 +8111,19 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_SQRDCMLAH_zzzz *a)
     }
     return true;
 }
+
+static bool trans_USDOT_zzzz(DisasContext *s, arg_USDOT_zzzz *a)
+{
+    if (a->esz != 2 || !dc_isar_feature(aa64_sve2_i8mm, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           vsz, vsz, 0, gen_helper_gvec_usdot_b);
+    }
+    return true;
+}
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 8dccc6789d..c8d1656797 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -579,6 +579,24 @@ void HELPER(gvec_udot_b)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_usdot_b)(void *vd, void *vn, void *vm,
+                          void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *a = va;
+    uint8_t *n = vn;
+    int8_t *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = (a[i] +
+                n[i * 4 + 0] * m[i * 4 + 0] +
+                n[i * 4 + 1] * m[i * 4 + 1] +
+                n[i * 4 + 2] * m[i * 4 + 2] +
+                n[i * 4 + 3] * m[i * 4 + 3]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_sdot_h)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-- 
2.25.1


