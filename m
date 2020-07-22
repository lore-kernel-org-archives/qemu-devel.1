Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4081C2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LtE6qf82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4081C2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBGG-0005HM-FI
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwB-000566-SQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:46554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwA-00061t-0N
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:19 -0400
Received: by mail-pf1-x42d.google.com with SMTP id a23so850650pfk.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rgRsumD+WyP+g+9ywiEhwYNS2OqBdlvEKjanU4B1RZU=;
 b=LtE6qf826ci3D7L3stHnLZ4IxQdcpNzXYKRjHxlMvlmy0w/BWZKmndqxLcrbOn5HVq
 z6e0pZnvfB2ErKm2AYLU/1yv3EBGifBf8MOBWYK0lwrZ7afkb1hCui08Mp4nloXrPknf
 tsf31SZjQDjYVaJtez8q+OoLMBBHrlkE+I+eU+pH3YnSeRACpkmtakgpoD0QrkMjn1UN
 GNGGyrKUIFz9l3MTabNXCwd6P3nU8N9/sBTs/fqCOqFJwUsDOjJUm2ZPPUQEfu0JItCA
 A6ojSUd8cjYOhQTOVoDuE74vY4SJquFecQWrmzdM9LSBSbccBj6E/6lchEHNz3oANly0
 l4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rgRsumD+WyP+g+9ywiEhwYNS2OqBdlvEKjanU4B1RZU=;
 b=HdNsJifTtp3Rr7FEHQD1KsF/EQShYG4hkqSLmBSOleSpJTTbU7koYb7c2PGn2Tm/jU
 lzDRMS5VNdKxVnhBS0yaLAYOfVKFWWfylOG3zmHhBGxW9vLcpGIJjjDnWAb7sQIX0Yuc
 qw4rWP9zSFbNM3WBFzxS+CuulCXuk9wKI7e0jfWBBWgfvv0GJQlkeiwKIklzv3WhMePH
 rovqKU3vGCHFsATC1Z+pGjYRMvHivLvXtwRyI3Ix+bagOBkra/+MC8PhK+PjxMXQMhVp
 a209IogWDRPOK+JPWeNyCMb+Dp8pNT3bPy4nRUCyBFAtB2Bugr5mP+jPr4BImiSRTPHJ
 1uSA==
X-Gm-Message-State: AOAM532LP49Kv4VLoWuhVHFM3D/F11nyA/Zeen2qZv6ZANYLXweOSodS
 UPFadLzBMCAnj01m5jnDadUIwPFXQaM=
X-Google-Smtp-Source: ABdhPJzJAg1FBZ5yz5oMup7bXnqJFltT2P+fmSTrDrZimyZiFP4rPJJmx+/D7S2I3Q6KZ1MpVr91eg==
X-Received: by 2002:a62:1ad6:: with SMTP id
 a205mr27235306pfa.109.1595409676608; 
 Wed, 22 Jul 2020 02:21:16 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 52/76] fpu: implement full set compare for fp16
Date: Wed, 22 Jul 2020 17:16:15 +0800
Message-Id: <20200722091641.8834-53-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Frank Chang <frank.chang@sifive.com>, Chih-Min Chao <chihmin.chao@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kito Cheng <kito.cheng@sifive.com>

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
 include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 79be4f5840..9c6640862e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -401,6 +401,34 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
+/*----------------------------------------------------------------------------
+| Returns the fraction bits of the half-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline uint32_t extractFloat16Frac(float16 a)
+{
+    return float16_val(a) & 0x3ff;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the exponent bits of the half-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline int extractFloat16Exp(float16 a)
+{
+    return (float16_val(a) >> 10) & 0x1f;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the sign bit of the half-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline bool extractFloat16Sign(float16 a)
+{
+    return float16_val(a) >> 15;
+}
+
+
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the single-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ff4e2605b1..267519cd65 100644
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
-- 
2.17.1


