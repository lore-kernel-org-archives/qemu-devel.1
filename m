Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BFBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4928206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUsCMggl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4928206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAMN-0004gF-35
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIb-0005dL-LO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:33405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIa-0007Q8-FL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:01 -0400
Received: by mail-pg1-x532.google.com with SMTP id s10so5351300pgm.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hk+iH5vXCwSqMT7V5a8G2hQq/dm0/a4SltBeNIVr26o=;
 b=pUsCMgglXneHm4jZk6wHJHRwyTqwmBQwpeY7j8lNJYZBYRO8QnI9mqBFi6Kgkp7w82
 ve4nT7vdDawHVHW7Qn9u8jHw3L7KX5oGjNuJqPyEfumm9HOXI4QF28DQnvTu0VkOVReG
 /Dd+Ll41eBmaYFJNJ9E2EqkSx0Dj/frCqMhb6tnUYUhEG7LXVJN9YKOBjTKPVdraa0+b
 UJhYexVod4dL2C2zybnO2j2I4oc/xzXltdpCrp4YXQMxOauHAE5Z6MBP0F2jM/SDnkxj
 qprvTsNOxPFFdk1gBRZOsNQQCc+L7JZCY/1kizu/OtCjyFlVp/JI5i3mNRipFzFbvW2d
 nUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hk+iH5vXCwSqMT7V5a8G2hQq/dm0/a4SltBeNIVr26o=;
 b=Rx705fRv1DzgqgDYZKj4XbgT+5FG5q+0jLowL7ZcSxnmx69IWGz1/sGNwjKcZBhZHb
 l2AGqnFnS9jxKON61HXuCKV4VNhQD7wpQ5deSUYTecVB+0BHYvIYN7CDR4MgFGe5x7e+
 f2KpFMN1lQIHADJxtS8T+YDi9MNhKWxHRHHLiHdOclDzQoe+ENwMnXFH7U/j/xX5zhJK
 Jpvmq3zIYzkhrOVGxWlvMV2swtg7AbioEwv8RPMdfvtJoweZ9/uWjYaI6RZpctGrJodZ
 sinY+33svVpdCj7gxrxteq7Zza1U5mcpz2i1fd5tREk+/ppM3a4zSDVT42cufstm8hr4
 dLxw==
X-Gm-Message-State: AOAM530G1YkijTJg0awhZ9dUx4eJN8wDRE6FJPyGgBG8V4SOUaySMMTA
 9vyNbAbRJwD/2smGbNkb8vfH7jIdOm4=
X-Google-Smtp-Source: ABdhPJzkpnsZGHztOhHua5dSmFl17eZFR6/NGhxkwzRmvvOIuU0amWsMt+spZh9Lrob1SBWkLhZ8sg==
X-Received: by 2002:a62:1606:: with SMTP id 6mr3395273pfw.148.1591117318605;
 Tue, 02 Jun 2020 10:01:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] tcg: Implement gvec support for rotate by scalar
Date: Tue,  2 Jun 2020 10:01:43 -0700
Message-Id: <20200602170151.321389-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No host backend support yet, but the interfaces for rotls
are in place.  Only implement left-rotate for now, as the
only known use of vector rotate by scalar is s390x, so any
right-rotate would be unused and untestable.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  2 ++
 include/tcg/tcg-op.h      |  1 +
 include/tcg/tcg-opc.h     |  1 +
 include/tcg/tcg.h         |  1 +
 tcg/aarch64/tcg-target.h  |  1 +
 tcg/i386/tcg-target.h     |  1 +
 tcg/ppc/tcg-target.h      |  1 +
 tcg/tcg-op-gvec.c         | 22 ++++++++++++++++++++++
 tcg/tcg-op-vec.c          |  5 +++++
 tcg/tcg.c                 |  2 ++
 10 files changed, 37 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index 2d768f1160..c69a7de984 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -345,6 +345,8 @@ void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
 
 /*
  * Perform vector shift by vector element, modulo the element size.
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 5523ee7810..5abf17fecc 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -1005,6 +1005,7 @@ void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 69f98d6523..e3929b80d2 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -253,6 +253,7 @@ DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
 DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
+DEF(rotls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rots_vec))
 
 DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index b2cb30305c..380014ed80 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -183,6 +183,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index a5477bbc07..9bc2a5ecbe 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -134,6 +134,7 @@ typedef enum {
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 4c806c97db..99ac1e3958 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,6 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7993422526..4a17aebc5a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -162,6 +162,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2b71725883..3707c0effb 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2976,6 +2976,28 @@ void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
 }
 
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2sh g = {
+        .fni4 = tcg_gen_rotl_i32,
+        .fni8 = tcg_gen_rotl_i64,
+        .fniv_s = tcg_gen_rotls_vec,
+        .fniv_v = tcg_gen_rotlv_vec,
+        .fno = {
+            gen_helper_gvec_rotl8i,
+            gen_helper_gvec_rotl16i,
+            gen_helper_gvec_rotl32i,
+            gen_helper_gvec_rotl64i,
+        },
+        .s_list = { INDEX_op_rotls_vec, 0 },
+        .v_list = { INDEX_op_rotlv_vec, 0 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
+}
+
 /*
  * Expand D = A << (B % element bits)
  *
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index fb1250fee6..f784517d84 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -747,6 +747,11 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
     do_shifts(vece, r, a, b, INDEX_op_sars_vec);
 }
 
+void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s)
+{
+    do_shifts(vece, r, a, s, INDEX_op_rotls_vec);
+}
+
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bd6ffab79b..97558ec068 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1663,6 +1663,8 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_rotli_vec:
         return have_vec && TCG_TARGET_HAS_roti_vec;
+    case INDEX_op_rotls_vec:
+        return have_vec && TCG_TARGET_HAS_rots_vec;
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
         return have_vec && TCG_TARGET_HAS_rotv_vec;
-- 
2.25.1


