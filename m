Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52772076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/O4ms78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52772076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5kfj-0007UT-2M
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 02:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kdv-0005Ea-Ao
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:40114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5kdt-00041H-CJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:53:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id k18so530367pfp.7
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x+CUNWxmdwpnm0VPcjEokAjthjrI6ArpKh4ph7vyRmQ=;
 b=n/O4ms78CjwxGMaoAtJnso/7mOl9+MmCYRd6naB25F8FsdUnmPoVu82Rofqkbpnun1
 7r5PKR8jNxVuqnFS1c7k8F1D3t9rWk5ppuE7H8DTUlr2xMhADnsu7AoQ8vnXJCy7yuar
 ggOv0QeNEoHekcVMgNCxINfnqiQ8+0wLT915h3KQE2rrOwpmYcbgswXSj1qq8inLjSyU
 P7r1jshZnczsSzUEPGga6tjCO/1JwPo5gU2NII1+yttlV3YtQP8lc3BFgWzszoX8thMv
 aQpV2ogXk5t0Wf0r9wfENmDo2nzrCYnHpL5fFf1GXWNuO5M+EzQ3BVDXDqBh+ObCvDo3
 +Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x+CUNWxmdwpnm0VPcjEokAjthjrI6ArpKh4ph7vyRmQ=;
 b=TmzqXNXSI+niJgXW9rBopWZrMNTC9eFxbubOHH2Glb5kC19RkI1HKBtraItQa3sMoO
 aGWineUo1sBlfn27Uxf8DTk46Pvwqiw1tNnz5483Nkhwdzu2UUOeO4xVgqz1+4aFN+hP
 UXMLUJh5W5SE32TRa1N8wj9rZWusay1B3RVSr4aT1dgKHTl4AVjMgWBEvHGcNYofAPTU
 SbTHDIitf/SRshL0nm4ZZNAk0cd5+SOLcAw80b5kExKD64UCvvMkPsQOBc4WHDaizHvF
 FPG1/51OgcTEXN93dVLMmyvIZkx84MdKcGxPpLoPrRdyMNpTb5lIQgqn7k4VwaaUMywE
 e/XA==
X-Gm-Message-State: AOAM530x9xqcZg3mIKLnL1ZHudfWGyIhZvdvd0NZtozlVgM2bpTDdKJr
 vjEzFQDMoLE/5kdvH9mou1HG/E83MyU=
X-Google-Smtp-Source: ABdhPJyTLWwgWdYbMYXQRdN51PyGk+lYSZF6tSiZkriHOXXw/uksAQWXxO8pfijP4LNQS+0fKycDVQ==
X-Received: by 2002:a62:4e07:: with SMTP id c7mr9186715pfb.10.1597215223619;
 Tue, 11 Aug 2020 23:53:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b26sm1242781pff.54.2020.08.11.23.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 23:53:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Implement an IMPDEF pauth algorithm
Date: Tue, 11 Aug 2020 23:53:39 -0700
Message-Id: <20200812065339.2030527-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812065339.2030527-1-richard.henderson@linaro.org>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without hardware acceleration, a cryptographically strong
algorithm is too expensive for pauth_computepac.

Even with hardware accel, we are not currently expecting
to link the linux-user binaries to any crypto libraries,
and doing so would generally make the --static build fail.

So choose XXH64 as a reasonably quick and decent hash.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 75 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 6dbab03768..f1a4389465 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -207,8 +207,8 @@ static uint64_t tweak_inv_shuffle(uint64_t i)
     return o;
 }
 
-static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
-                                 ARMPACKey key)
+static uint64_t __attribute__((noinline))
+pauth_computepac_architected(uint64_t data, uint64_t modifier, ARMPACKey key)
 {
     static const uint64_t RC[5] = {
         0x0000000000000000ull,
@@ -272,6 +272,71 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
     return workingval;
 }
 
+/*
+ * The XXH64 algorithm from
+ * https://github.com/Cyan4973/xxHash/blob/v0.8.0/xxhash.h
+ */
+#define PRIME64_1   0x9E3779B185EBCA87ULL
+#define PRIME64_2   0xC2B2AE3D27D4EB4FULL
+#define PRIME64_3   0x165667B19E3779F9ULL
+#define PRIME64_4   0x85EBCA77C2B2AE63ULL
+#define PRIME64_5   0x27D4EB2F165667C5ULL
+
+static inline uint64_t XXH64_round(uint64_t acc, uint64_t input)
+{
+    return rol64(acc + input * PRIME64_2, 31) * PRIME64_1;
+}
+
+static inline uint64_t XXH64_mergeround(uint64_t acc, uint64_t val)
+{
+    return (acc ^ XXH64_round(0, val)) * PRIME64_1 + PRIME64_4;
+}
+
+static inline uint64_t XXH64_avalanche(uint64_t h64)
+{
+    h64 ^= h64 >> 33;
+    h64 *= PRIME64_2;
+    h64 ^= h64 >> 29;
+    h64 *= PRIME64_3;
+    /* h64 ^= h64 >> 32; -- does not affect high 64 for pauth */
+    return h64;
+}
+
+static uint64_t __attribute__((noinline))
+pauth_computepac_impdef(uint64_t data, uint64_t modifier, ARMPACKey key)
+{
+    uint64_t v1 = 1 + PRIME64_1 + PRIME64_2;
+    uint64_t v2 = 1 + PRIME64_2;
+    uint64_t v3 = 1 + 0;
+    uint64_t v4 = 1 - PRIME64_1;
+    uint64_t h64;
+
+    v1 = XXH64_round(v1, data);
+    v2 = XXH64_round(v2, modifier);
+    v3 = XXH64_round(v3, key.lo);
+    v4 = XXH64_round(v4, key.hi);
+
+    h64 = rol64(v1, 1) + rol64(v2, 7) + rol64(v3, 12) + rol64(v4, 18);
+    h64 = XXH64_mergeround(h64, v1);
+    h64 = XXH64_mergeround(h64, v2);
+    h64 = XXH64_mergeround(h64, v3);
+    h64 = XXH64_mergeround(h64, v4);
+
+    return XXH64_avalanche(h64);
+}
+
+static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
+                                 uint64_t modifier, ARMPACKey key)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    if (FIELD_EX64(cpu->isar.id_aa64isar1, ID_AA64ISAR1, APA)) {
+        return pauth_computepac_architected(data, modifier, key);
+    } else {
+        return pauth_computepac_impdef(data, modifier, key);
+    }
+}
+
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
@@ -292,7 +357,7 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     bot_bit = 64 - param.tsz;
     ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
 
-    pac = pauth_computepac(ext_ptr, modifier, *key);
+    pac = pauth_computepac(env, ext_ptr, modifier, *key);
 
     /*
      * Check if the ptr has good extension bits and corrupt the
@@ -341,7 +406,7 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     uint64_t pac, orig_ptr, test;
 
     orig_ptr = pauth_original_ptr(ptr, param);
-    pac = pauth_computepac(orig_ptr, modifier, *key);
+    pac = pauth_computepac(env, orig_ptr, modifier, *key);
     bot_bit = 64 - param.tsz;
     top_bit = 64 - 8 * param.tbi;
 
@@ -442,7 +507,7 @@ uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
     uint64_t pac;
 
     pauth_check_trap(env, arm_current_el(env), GETPC());
-    pac = pauth_computepac(x, y, env->keys.apga);
+    pac = pauth_computepac(env, x, y, env->keys.apga);
 
     return pac & 0xffffffff00000000ull;
 }
-- 
2.25.1


