Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C7C55ABD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991020756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwKZPJPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasjP-0007g8-7D
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRr-0005OZ-DL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:59 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:35041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRp-00072p-9B
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id 1so31612ple.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oktQi4LY/JF34qnZTuyLsQ8kBIo/j/CH/m+PcKBIxn4=;
 b=mwKZPJPAWbMaHoCtW78bfp8y0RRtYPpk05IQNBoBjQGFVPxR8tB5A+ZrpBB5NuZXuN
 r1TGQl5iVpzUbiqrKo+GGvuseDOZGvAghcV8KeYW+cR9xuHvCYiUWefzlBZEBGCOzpnh
 xTJPp/DHWBFFNZODkruMIOqFFERlJ7b1EiB3J/7XQq42Xo4eKwbwlbxjwwRIFoN2nmyd
 u17Sc5cDbz4oHo/BD60pwWCs3w8U/eUW2rRFlZD4Y2pU6HEKDH4/ukcCDL8UBYu1FETD
 sO90sKiqp3Ah55Udqd2vCUgsJvmY3+ry86xRHUG3ZkJwZy0X6TH+Ph2yAcZh0PgX+keO
 IlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oktQi4LY/JF34qnZTuyLsQ8kBIo/j/CH/m+PcKBIxn4=;
 b=g0QXrIkwWdFR6uTX4EzEmGjiX2keRY6GpfsZF3R62Mn7/tzgdJydrQBe/hCBe9pYqw
 r+HCBzKh7b2YdybNJRi4aJnz9DCRpXc6bePSSOwfXOqd2PJfD/v4IC4J7XD3Sr/VtYwg
 NmJsXKRMqbWE4ssmvxT5E0JoJqGlD2R3q/6o/tCqFZQRAXGCCreVcHdSXiQDKvr1CvAp
 /txkT50DJQtP2ln4kP41d4rj3A/LPkcD1vO2PlIg4MeBVNd1l8cz6w4khZbV8DZpg8oY
 zgDl/EJ2Yl+0thXxTjylDoMjwQMfsT4Yw7Ho8E/U7Dn2gW0+/hH0BdfAx9YIrcGJAGUk
 CBDA==
X-Gm-Message-State: AOAM531lu8eeeeGLNXntkpXyv/KDdppt7wloXDPEA9gb38eILs2D/ACB
 Fb8EJ0nLlqtHk5uumkXI6VAHZJCBCJWrSA==
X-Google-Smtp-Source: ABdhPJzVhoebuV5aIFFg7/NCNkQaHsz4JKABQrk75UFtZgxwsv7qU4qfYupwpTlhkF5TD1piLDy2PA==
X-Received: by 2002:a17:902:b582:b029:d6:6008:264d with SMTP id
 a2-20020a170902b582b02900d66008264dmr5192126pls.80.1604633393382; 
 Thu, 05 Nov 2020 19:29:53 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/41] tcg/tci: Push const down through bytecode reading
Date: Thu,  5 Nov 2020 19:29:03 -0800
Message-Id: <20201106032921.600200-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 60 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 262a2b39ce..388c1dbee8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -163,34 +163,34 @@ static uint64_t tci_uint64(uint32_t high, uint32_t low)
 #endif
 
 /* Read constant (native size) from bytecode. */
-static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
+static tcg_target_ulong tci_read_i(const uint8_t **tb_ptr)
 {
-    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
+    tcg_target_ulong value = *(const tcg_target_ulong *)(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
 
 /* Read unsigned constant (32 bit) from bytecode. */
-static uint32_t tci_read_i32(uint8_t **tb_ptr)
+static uint32_t tci_read_i32(const uint8_t **tb_ptr)
 {
-    uint32_t value = *(uint32_t *)(*tb_ptr);
+    uint32_t value = *(const uint32_t *)(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
 
 /* Read signed constant (32 bit) from bytecode. */
-static int32_t tci_read_s32(uint8_t **tb_ptr)
+static int32_t tci_read_s32(const uint8_t **tb_ptr)
 {
-    int32_t value = *(int32_t *)(*tb_ptr);
+    int32_t value = *(const int32_t *)(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
 
 #if TCG_TARGET_REG_BITS == 64
 /* Read constant (64 bit) from bytecode. */
-static uint64_t tci_read_i64(uint8_t **tb_ptr)
+static uint64_t tci_read_i64(const uint8_t **tb_ptr)
 {
-    uint64_t value = *(uint64_t *)(*tb_ptr);
+    uint64_t value = *(const uint64_t *)(*tb_ptr);
     *tb_ptr += sizeof(value);
     return value;
 }
@@ -198,7 +198,7 @@ static uint64_t tci_read_i64(uint8_t **tb_ptr)
 
 /* Read indexed register (native size) from bytecode. */
 static tcg_target_ulong
-tci_read_r(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+tci_read_r(const tcg_target_ulong *regs, const uint8_t **tb_ptr)
 {
     tcg_target_ulong value = tci_read_reg(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -206,7 +206,7 @@ tci_read_r(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 }
 
 /* Read indexed register (8 bit) from bytecode. */
-static uint8_t tci_read_r8(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint8_t tci_read_r8(const tcg_target_ulong *regs, const uint8_t **tb_ptr)
 {
     uint8_t value = tci_read_reg8(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -215,7 +215,7 @@ static uint8_t tci_read_r8(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 #if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
 /* Read indexed register (8 bit signed) from bytecode. */
-static int8_t tci_read_r8s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static int8_t tci_read_r8s(const tcg_target_ulong *regs, const uint8_t **tb_ptr)
 {
     int8_t value = tci_read_reg8s(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -224,7 +224,8 @@ static int8_t tci_read_r8s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 #endif
 
 /* Read indexed register (16 bit) from bytecode. */
-static uint16_t tci_read_r16(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint16_t tci_read_r16(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     uint16_t value = tci_read_reg16(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -233,7 +234,8 @@ static uint16_t tci_read_r16(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 #if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64
 /* Read indexed register (16 bit signed) from bytecode. */
-static int16_t tci_read_r16s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static int16_t tci_read_r16s(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     int16_t value = tci_read_reg16s(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -242,7 +244,8 @@ static int16_t tci_read_r16s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 #endif
 
 /* Read indexed register (32 bit) from bytecode. */
-static uint32_t tci_read_r32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint32_t tci_read_r32(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     uint32_t value = tci_read_reg32(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -251,14 +254,16 @@ static uint32_t tci_read_r32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 #if TCG_TARGET_REG_BITS == 32
 /* Read two indexed registers (2 * 32 bit) from bytecode. */
-static uint64_t tci_read_r64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint64_t tci_read_r64(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     uint32_t low = tci_read_r32(regs, tb_ptr);
     return tci_uint64(tci_read_r32(regs, tb_ptr), low);
 }
 #elif TCG_TARGET_REG_BITS == 64
 /* Read indexed register (32 bit signed) from bytecode. */
-static int32_t tci_read_r32s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static int32_t tci_read_r32s(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     int32_t value = tci_read_reg32s(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -266,7 +271,8 @@ static int32_t tci_read_r32s(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 }
 
 /* Read indexed register (64 bit) from bytecode. */
-static uint64_t tci_read_r64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint64_t tci_read_r64(const tcg_target_ulong *regs,
+                             const uint8_t **tb_ptr)
 {
     uint64_t value = tci_read_reg64(regs, **tb_ptr);
     *tb_ptr += 1;
@@ -276,7 +282,7 @@ static uint64_t tci_read_r64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 /* Read indexed register(s) with target address from bytecode. */
 static target_ulong
-tci_read_ulong(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+tci_read_ulong(const tcg_target_ulong *regs, const uint8_t **tb_ptr)
 {
     target_ulong taddr = tci_read_r(regs, tb_ptr);
 #if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
@@ -287,7 +293,7 @@ tci_read_ulong(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 /* Read indexed register or constant (native size) from bytecode. */
 static tcg_target_ulong
-tci_read_ri(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+tci_read_ri(const tcg_target_ulong *regs, const uint8_t **tb_ptr)
 {
     tcg_target_ulong value;
     TCGReg r = **tb_ptr;
@@ -301,7 +307,8 @@ tci_read_ri(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 }
 
 /* Read indexed register or constant (32 bit) from bytecode. */
-static uint32_t tci_read_ri32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint32_t tci_read_ri32(const tcg_target_ulong *regs,
+                              const uint8_t **tb_ptr)
 {
     uint32_t value;
     TCGReg r = **tb_ptr;
@@ -316,14 +323,16 @@ static uint32_t tci_read_ri32(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 
 #if TCG_TARGET_REG_BITS == 32
 /* Read two indexed registers or constants (2 * 32 bit) from bytecode. */
-static uint64_t tci_read_ri64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint64_t tci_read_ri64(const tcg_target_ulong *regs,
+                              const uint8_t **tb_ptr)
 {
     uint32_t low = tci_read_ri32(regs, tb_ptr);
     return tci_uint64(tci_read_ri32(regs, tb_ptr), low);
 }
 #elif TCG_TARGET_REG_BITS == 64
 /* Read indexed register or constant (64 bit) from bytecode. */
-static uint64_t tci_read_ri64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
+static uint64_t tci_read_ri64(const tcg_target_ulong *regs,
+                              const uint8_t **tb_ptr)
 {
     uint64_t value;
     TCGReg r = **tb_ptr;
@@ -337,7 +346,7 @@ static uint64_t tci_read_ri64(const tcg_target_ulong *regs, uint8_t **tb_ptr)
 }
 #endif
 
-static tcg_target_ulong tci_read_label(uint8_t **tb_ptr)
+static tcg_target_ulong tci_read_label(const uint8_t **tb_ptr)
 {
     tcg_target_ulong label = tci_read_i(tb_ptr);
     tci_assert(label != 0);
@@ -477,8 +486,7 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 /* Interpret pseudo code in tb. */
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
 {
-    /* TODO: Propagate const through this file. */
-    uint8_t *tb_ptr = (uint8_t *)v_tb_ptr;
+    const uint8_t *tb_ptr = v_tb_ptr;
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
@@ -492,7 +500,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
         TCGOpcode opc = tb_ptr[0];
 #if defined(CONFIG_DEBUG_TCG) && !defined(NDEBUG)
         uint8_t op_size = tb_ptr[1];
-        uint8_t *old_code_ptr = tb_ptr;
+        const uint8_t *old_code_ptr = tb_ptr;
 #endif
         tcg_target_ulong t0;
         tcg_target_ulong t1;
-- 
2.25.1


