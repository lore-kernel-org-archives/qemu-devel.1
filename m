Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9422B206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QklJLJf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9422B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB28-00084g-TH
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtu-00008q-7d
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtq-0005VE-Er
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id w17so641774ply.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5VzK4FfmnYHyUZyCqlp+i7B88c5pm8MmOilNV0BSO0Y=;
 b=QklJLJf2nBMImWuvTqWCq3S1nw+R2H/D7+SCjLAX2Wdd3xKsDc3KeOIhuK78NWLeZI
 wCRvvoADh/KxOlBOeuIhBRxWa+/QQHix1VWdhm9BmxYjlUcZbyacUSI/xzRUyx3SNcnC
 T5V79NHCdYKVmkGg1JTeOYoJuEouT49e6lo7XqyCpn1lGDPINPbYvwPjripr6eGPNDwC
 L3F/U5qaawDwGqfk2xJy4N3RVG0ynOm5eCOevDfCudbeqvCBNCtuCUgzJpVuJ4gbZrLY
 1ugjq7pNuePuC+TjZDkqDfBi3Lf0BQRE6uOHacvONOUJSAHw6NQHYYx69ySj294Xw9K4
 yvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5VzK4FfmnYHyUZyCqlp+i7B88c5pm8MmOilNV0BSO0Y=;
 b=BX0trrQjdpFl+oSbbmXgB34VY/YE7+jpWng/7R0O9gR9iWnPsXlwRTN6MighBbI9Nn
 t3hayU8DoYs+tpYl9msHtzSEVs1FEgvOTPVspuUSxoHuU9orOfBZbzo9z+vsLT9OiV0R
 ftOM/ZV8zfFmtb53t9zBVkjjl8Rn+vabQnWQK7aM2s59QX+ZmcImWpYpjBEgNXAvaYtt
 XFcUYFO/tqfWvG6G4eOilOwGzgIgyBQrf01xb+VNnJ5mnwpQdHJWRZf/mZY4cEcpRWC/
 AzDwT5mK7Q8SrRPU9TV0UEgqSIz+T6tp/ysvDAqIFFrJKdBUEh2+6wEHUC9/xU3fJ8hS
 6Jfw==
X-Gm-Message-State: AOAM533ucsaCtTUE+Xt5dtrDSqPLNzAl2Wnmx6Z3SpfrCgtAnxDPtPF3
 TGHXWOO20M5oPiMqrMw9b3uIZ0ricMc=
X-Google-Smtp-Source: ABdhPJxg/0HDfAYFILQxyLLOPKPhwzLczlhmM7Mr4Bao7uCuBTs4DtcedrTrPY6pcU/o+PSoVxVu2A==
X-Received: by 2002:a17:90b:3114:: with SMTP id
 gc20mr8471985pjb.233.1595409532898; 
 Wed, 22 Jul 2020 02:18:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:52 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 19/76] target/riscv: rvv-0.9: add narrower_nanbox_fpr helper
Date: Wed, 22 Jul 2020 17:15:42 +0800
Message-Id: <20200722091641.8834-20-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x630.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

For floating-point operations, the scalar can be taken from a scalar
f register. If FLEN > SEW, the value in the f registers is checked for
a valid NaN-boxed value, in which case the least-significant SEW bits
of the f register are used, else the canonical NaN value is used.

Add helper to generate the correspond NaN-boxed value or the SEW-bit
canonical NaN for floating-point operations.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h        |  2 ++
 target/riscv/vector_helper.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index acc298219d..3cbd66a887 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1150,3 +1150,5 @@ DEF_HELPER_6(vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_3(narrower_nanbox_fpr, i64, i64, i32, env)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83e317c500..fb689ab3f9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3207,6 +3207,38 @@ GEN_VEXT_VX_RM(vnclipu_vx_w, 4, 4, clearl)
 /*
  *** Vector Float Point Arithmetic Instructions
  */
+
+/*
+ * For SEW < FLEN,
+ * if f is not correctly NaN-boxed for SEW bits,
+ * canonical SEW-bit NaN is returned.
+ * Otherwise, original f is returned.
+ */
+static uint64_t narrower_nanbox_fpr(uint64_t f, uint32_t sew, float_status *s)
+{
+    uint64_t mask = MAKE_64BIT_MASK(sew, 64 - sew);
+    if ((f & mask) == mask) {
+        return f;
+    } else {
+        switch (sew) {
+        case 16:
+            return float16_default_nan(s);
+        case 32:
+            return float32_default_nan(s);
+        case 64:
+            return float64_default_nan(s);
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+uint64_t HELPER(narrower_nanbox_fpr)(uint64_t f, uint32_t sew,
+                                     CPURISCVState *env)
+{
+    return narrower_nanbox_fpr(f, sew, &env->fp_status);
+}
+
 /* Vector Single-Width Floating-Point Add/Subtract Instructions */
 #define OPFVV2(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
 static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
-- 
2.17.1


