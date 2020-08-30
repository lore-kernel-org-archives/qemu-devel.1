Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A2C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E72B207DF
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+HXbP9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72B207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCD9d-000456-Po
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8c-0002ZT-NN
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:43812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8a-0002XA-Rr
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id y206so2663538pfb.10
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MTrqYXi8FbHIZwqK1xJgmyOC3wH3/xVVNcE5HVvBvBI=;
 b=s+HXbP9Lk42Q6yAVfvWq57l0gic62WXNQuABmIuOYrEpc1MmS6P/al15IRyy7sHjTh
 h/FDj5Nvzbrkl5pwqNT0KHHrDwW8mB+iUJ8VkZ7TUfRoJA3DNtR/Y+M3yuz+kz4E4SM2
 nVdCCEMG08VClHOBjS326sdzPXffY/XW50wc1nJoxT5h/WJR1KDwZgkr13aCYqJsxBwZ
 7qOdpqnOrzKwHQh7jyBXavhZsCvtpdyODGwXUmYgS0do3A/biQwHV95qYg/JAWUG0BX/
 DA/1dj7cGHM6rOJEaMizhYljWw3wsHct0yUAm8442VPHVWTS9w2Mcve6w3iR9lw8t1Br
 dGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MTrqYXi8FbHIZwqK1xJgmyOC3wH3/xVVNcE5HVvBvBI=;
 b=bR1fCz57QVKqG6y6n5ZCrGObA+opYdvYC80gynKo+neUKugdrw2yO9SA1YfcDbjk7L
 sPRvnbEC74g/9u8O50MEfgaHFI+qzCZyiyTExFZ3L+ZQNNXtv0BnN6pcLVSY0XaNo89r
 ru45bSwiC7KcFp9VpteDIk+byaBvEXI3QfesutVTa/VhwIa3jYXIW4eCTiZOSJH8vMrX
 6ZIo/monwxTicieajtI++er55mA5PCwDsnLatn5+uhD950jhQZ+M6tIp+kcP85/3Hcgx
 gv2K3cKGjotcrZDmxYAdsgdTDF65z1etaHI6RTF6ewsc5Jir7TM7NNZYAdy7NY8hqnYi
 3dTw==
X-Gm-Message-State: AOAM5310DF0wpebnXO3NmD50opzuzyKsc8rDVbwVvdfyFtlqnBwrwxgP
 Bo6JjIfUqO1OO/zwpi2vx4c6xNDpvDVfrg==
X-Google-Smtp-Source: ABdhPJwNWBk12YKyLtqqLAjqGlvrw6/HLpH3TnNcZkAa9ZVf72grcONXx1iTyddJpb/4dpRms2JB/w==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr3881682pgt.192.1598754727167; 
 Sat, 29 Aug 2020 19:32:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] softfloat: Implement the full set of comparisons for
 float16
Date: Sat, 29 Aug 2020 19:31:57 -0700
Message-Id: <20200830023203.612312-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Cc: peter.maydell@linaro.org, Kito Cheng <kito.cheng@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kito Cheng <kito.cheng@sifive.com>

Implement them in softfloat and remove the local versions in riscv.

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596102747-20226-2-git-send-email-chihmin.chao@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h      | 41 ++++++++++++++++++++++++++++++++++++
 target/riscv/vector_helper.c | 25 ----------------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 659218b5c7..573fce99bc 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -285,6 +285,47 @@ static inline float16 float16_set_sign(float16 a, int sign)
     return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
 }
 
+static inline bool float16_eq(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool float16_le(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float16_lt(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool float16_unordered(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool float16_eq_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool float16_le_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float16_lt_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool float16_unordered_quiet(float16 a, float16 b,
+                                           float_status *s)
+{
+    return float16_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define float16_zero make_float16(0)
 #define float16_half make_float16(0x3800)
 #define float16_one make_float16(0x3c00)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 793af99067..a156573d28 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3955,12 +3955,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     }                                                         \
 }
 
-static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare_quiet(a, b, s);
-    return compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
@@ -4017,12 +4011,6 @@ GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
 GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
 GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
 
-static bool float16_lt(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
@@ -4030,13 +4018,6 @@ GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
 
-static bool float16_le(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less ||
-           compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
@@ -4091,12 +4072,6 @@ GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
 GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
 GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
 
-static bool float16_unordered_quiet(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare_quiet(a, b, s);
-    return compare == float_relation_unordered;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
 GEN_VEXT_CMP_VV_ENV(vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
 GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
-- 
2.25.1


