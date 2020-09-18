Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B29C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC36E2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5ki9XWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMYV-0000ox-IT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIQ-0001OE-VA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIJ-0007Je-Av
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id b124so3979573pfg.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uWrP993e91NZdCWoZj580puJQVNQnFvVcyTMSpehn0g=;
 b=Z5ki9XWLvCwVriNIcIn+QVFUsXS1b/KN64STsLKcltH/2QLG3FB71xsqun2Gcq5FOl
 ebAtB1WgwXA7jHb765Y1A1va/3xaFnCPLOBf8/gAE+R828AtezOUJdKUvmShvHrWrcE0
 dIUKzzn54f37Y0aZ4qUruTTiK6CFosTkmR57ZvDq9U/IRm4DfQcS+ALbLqfo0Cg1hdmv
 TwwVLt0RmhA6/CS30ZLy0Df6KVCuoXMAC8BYasWXN6WsldOSwm819KARhuGvhNixYMI7
 uE/wECIiaQn+K3Z8mN/RAzbDgplQBc2CWkDpTsd1GN0nFwtIbFTO0zmj1QbjI1wl1lQa
 N7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uWrP993e91NZdCWoZj580puJQVNQnFvVcyTMSpehn0g=;
 b=A2BBPfn/qFkfkrcTBoEQDVK+jXw0Upzs2G+QV79pilYcvZAQ3u0THZ2q+lqzD5128m
 BwuV0soyOF8NceNAoMENx5aVwEqApj92WexBgwYPUcyVTd2PtG8uQUP4gxDducBEMgZP
 xeeD5OkEhQDY2u4JEZ4k6oc8W5GaApYNTsk5JDR42h/abm5OkGWzVKG73BODHmL+rUoI
 2PF89YtKWKT1TIxOpyg9gIr77zca8qD7yhJW0eimKSmHFhpnsG34mmZmE+vftIizSofD
 tFGBCmcjLC6YbofB5d3/OtpWp3h9VfDIv43QghptFYz4Z6FyKcQOLXwvCJnV9z3c5QiP
 Z4Ew==
X-Gm-Message-State: AOAM532N8G88eKub8A0K93n1A+U7xdnQVLQqzN/BP3oi2WGzIB6jRBDZ
 EdhjHwzAhTbeNoxWjxY/UV5gIyOkjLTHnA==
X-Google-Smtp-Source: ABdhPJzKKKZyqAadQBL8IEAcZAG+pvL8iXPnWxL42/bd7VMUTypL9hN0UuNqfQ016N/0yhaz4ouYUw==
X-Received: by 2002:aa7:96c7:0:b029:142:38cd:13de with SMTP id
 h7-20020aa796c70000b029014238cd13demr14042045pfq.66.1600454377587; 
 Fri, 18 Sep 2020 11:39:37 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 78/81] target/arm: Implement SVE2 bitwise shift immediate
Date: Fri, 18 Sep 2020 11:37:48 -0700
Message-Id: <20200918183751.2787647-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Implements SQSHL/UQSHL, SRSHR/URSHR, and SQSHLU

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200430194159.24064-1-steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 33 +++++++++++++++++++++
 target/arm/sve.decode      |  5 ++++
 target/arm/sve_helper.c    | 35 ++++++++++++++++++++++
 target/arm/translate-sve.c | 60 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index feed23bbd1..9542f01c42 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2738,6 +2738,39 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqshlu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_ds, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4e21274dc4..d2f33d96f3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -342,6 +342,11 @@ ASR_zpzi        00000100 .. 000 000 100 ... .. ... .....  @rdn_pg_tszimm_shr
 LSR_zpzi        00000100 .. 000 001 100 ... .. ... .....  @rdn_pg_tszimm_shr
 LSL_zpzi        00000100 .. 000 011 100 ... .. ... .....  @rdn_pg_tszimm_shl
 ASRD            00000100 .. 000 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
+SQSHL_zpzi      00000100 .. 000 110 100 ... .. ... .....  @rdn_pg_tszimm_shl
+UQSHL_zpzi      00000100 .. 000 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
+SRSHR           00000100 .. 001 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
+URSHR           00000100 .. 001 101 100 ... .. ... .....  @rdn_pg_tszimm_shr
+SQSHLU          00000100 .. 001 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
 
 # SVE bitwise shift by vector (predicated)
 ASR_zpzz        00000100 .. 010 000 100 ... ..... .....   @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 12d21dcd65..ef04a0f95a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2203,6 +2203,41 @@ DO_ZPZI(sve_asrd_h, int16_t, H1_2, DO_ASRD)
 DO_ZPZI(sve_asrd_s, int32_t, H1_4, DO_ASRD)
 DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
 
+/* SVE2 bitwise shift by immediate */
+DO_ZPZI(sve2_sqshl_zpzi_b, int8_t, H1, do_sqshl_b)
+DO_ZPZI(sve2_sqshl_zpzi_h, int16_t, H1_2, do_sqshl_h)
+DO_ZPZI(sve2_sqshl_zpzi_s, int32_t, H1_4, do_sqshl_s)
+DO_ZPZI_D(sve2_sqshl_zpzi_d, int64_t, do_sqshl_d)
+
+DO_ZPZI(sve2_uqshl_zpzi_b, uint8_t, H1, do_uqshl_b)
+DO_ZPZI(sve2_uqshl_zpzi_h, uint16_t, H1_2, do_uqshl_h)
+DO_ZPZI(sve2_uqshl_zpzi_s, uint32_t, H1_4, do_uqshl_s)
+DO_ZPZI_D(sve2_uqshl_zpzi_d, uint64_t, do_uqshl_d)
+
+DO_ZPZI(sve2_srshr_b, int8_t, H1, do_srshr)
+DO_ZPZI(sve2_srshr_h, int16_t, H1_2, do_srshr)
+DO_ZPZI(sve2_srshr_s, int32_t, H1_4, do_srshr)
+DO_ZPZI_D(sve2_srshr_d, int64_t, do_srshr)
+
+DO_ZPZI(sve2_urshr_b, uint8_t, H1, do_urshr)
+DO_ZPZI(sve2_urshr_h, uint16_t, H1_2, do_urshr)
+DO_ZPZI(sve2_urshr_s, uint32_t, H1_4, do_urshr)
+DO_ZPZI_D(sve2_urshr_d, uint64_t, do_urshr)
+
+#define do_suqrshl_b(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, (int8_t)m, 8, false, &discard); })
+#define do_suqrshl_h(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, (int16_t)m, 16, false, &discard); })
+#define do_suqrshl_s(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, m, 32, false, &discard); })
+#define do_suqrshl_d(n, m) \
+   ({ uint32_t discard; do_suqrshl_d(n, m, false, &discard); })
+
+DO_ZPZI(sve2_sqshlu_b, int8_t, H1, do_suqrshl_b)
+DO_ZPZI(sve2_sqshlu_h, int16_t, H1_2, do_suqrshl_h)
+DO_ZPZI(sve2_sqshlu_s, int32_t, H1_4, do_suqrshl_s)
+DO_ZPZI_D(sve2_sqshlu_d, int64_t, do_suqrshl_d)
+
 #undef DO_ASRD
 #undef DO_ZPZI
 #undef DO_ZPZI_D
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 214788ea23..acd6d53724 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1044,6 +1044,66 @@ static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a)
     }
 }
 
+static bool trans_SQSHL_zpzi(DisasContext *s, arg_rpri_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqshl_zpzi_b, gen_helper_sve2_sqshl_zpzi_h,
+        gen_helper_sve2_sqshl_zpzi_s, gen_helper_sve2_sqshl_zpzi_d,
+    };
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_UQSHL_zpzi(DisasContext *s, arg_rpri_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_uqshl_zpzi_b, gen_helper_sve2_uqshl_zpzi_h,
+        gen_helper_sve2_uqshl_zpzi_s, gen_helper_sve2_uqshl_zpzi_d,
+    };
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_SRSHR(DisasContext *s, arg_rpri_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_srshr_b, gen_helper_sve2_srshr_h,
+        gen_helper_sve2_srshr_s, gen_helper_sve2_srshr_d,
+    };
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_URSHR(DisasContext *s, arg_rpri_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_urshr_b, gen_helper_sve2_urshr_h,
+        gen_helper_sve2_urshr_s, gen_helper_sve2_urshr_d,
+    };
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_SQSHLU(DisasContext *s, arg_rpri_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqshlu_b, gen_helper_sve2_sqshlu_h,
+        gen_helper_sve2_sqshlu_s, gen_helper_sve2_sqshlu_d,
+    };
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
 /*
  *** SVE Bitwise Shift - Predicated Group
  */
-- 
2.25.1


