Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651E62064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1Xi4wHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIho-00053G-7z
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8x-0008FZ-95
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8s-0001It-DO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:47 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8s-00010k-1Y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:42 -0400
Received: by mail-qk1-x742.google.com with SMTP id y81so16141632qkb.7
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wk2rFtSmeyIzF6QnNFgZDZnR49h41R/PQfqDCLolPT8=;
 b=m1Xi4wHUB/rzh8DpWQCx77XUam/NZg86g5fXAVetykgByxXTBaAFPeQ1uAMWCy4Hmd
 /OZppLkfuU0wTbUAXtwcsbfhXndK6buDKQ5bRcH4xM7SRB2p0lfMdnjVJ5aUPY8novNs
 6OsJAGTfu+X1KkUYf11KhXS4LkTWU6baMUESKtzszMJVLT4CHnTZex/TmF7EQoRpbdmi
 sx5vCXuCndE2PWMfRXBJOwpnaqJti4Z3Ij7tGnvNn9HXdhKzaBDtTQTNWI23xhaJA4CP
 GQ6wbDn4avRbHN/tfGsXUqX/fcQp2jKnLG5BLQAi2fZ4lszGdkCUjZ3BbW4s6LIS39j5
 FtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wk2rFtSmeyIzF6QnNFgZDZnR49h41R/PQfqDCLolPT8=;
 b=msshhGLtlPcs9UFI258bjDnAuyTNJ0WuFZ9qbNXn6GJmn1mF5lkMHAKqRrZhdmu01a
 ZBwrJa6VeX22MYGI8S2eRXQEXBXW3OkZhuf/FvnVy/p8B9N/ejG8TN5lHzqj2lBQqn5L
 Rt9i/jrCPGNv2t5WVNmYIbdSQXfnwNc0rknielNEHiaA4qcsxBixOtGspSfl8svLqoTW
 o/gT93LSxmHfTlV9oN2HLwl8u+zzztgocbbo3pCQCpW7IPiWh+SEA+TPsD/PGmguo+AL
 REyf2WANgREbE8ScHDN2zbA+GDai+wh6iQ2iNoTuno/Qkk9XOcikzVcjXKUdAQzQRk4L
 2f+g==
X-Gm-Message-State: APjAAAU+UCgffhFCU8KKqAJgT/PDfE/ivvOIPj+pmH4thPM2QF64B4Ga
 Cfw/5c7TtOa9csUIYGjcJDCTDSJeoMo=
X-Google-Smtp-Source: APXvYqwr+wzFrhvS+T8g5inbOTFRc932keyo8BgxS41VtRlSxXeQiRKwig7qW3Kri2NYQlwUsR3uOg==
X-Received: by 2002:a37:93c4:: with SMTP id v187mr9021367qkd.490.1571842867655; 
 Wed, 23 Oct 2019 08:01:07 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 04/24] target/arm: Split arm_cpu_data_is_big_endian
Date: Wed, 23 Oct 2019 11:00:37 -0400
Message-Id: <20191023150057.25731-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set TBFLAG_ANY.BE_DATA in rebuild_hflags_common_32 and
rebuild_hflags_a64 instead of rebuild_hflags_common, where we do
not need to re-test is_a64() nor re-compute the various inputs.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 49 +++++++++++++++++++++++++++------------------
 target/arm/helper.c | 16 +++++++++++----
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ad79a6153b..4d961474ce 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3108,33 +3108,44 @@ static inline uint64_t arm_sctlr(CPUARMState *env, int el)
     }
 }
 
+static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+                                                  bool sctlr_b)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * In system mode, BE32 is modelled in line with the
+     * architecture (as word-invariant big-endianness), where loads
+     * and stores are done little endian but from addresses which
+     * are adjusted by XORing with the appropriate constant. So the
+     * endianness to use for the raw data access is not affected by
+     * SCTLR.B.
+     * In user mode, however, we model BE32 as byte-invariant
+     * big-endianness (because user-only code cannot tell the
+     * difference), and so we need to use a data access endianness
+     * that depends on SCTLR.B.
+     */
+    if (sctlr_b) {
+        return true;
+    }
+#endif
+    /* In 32bit endianness is determined by looking at CPSR's E bit */
+    return env->uncached_cpsr & CPSR_E;
+}
+
+static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
+{
+    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
+}
 
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
-    /* In 32bit endianness is determined by looking at CPSR's E bit */
     if (!is_a64(env)) {
-        return
-#ifdef CONFIG_USER_ONLY
-            /* In system mode, BE32 is modelled in line with the
-             * architecture (as word-invariant big-endianness), where loads
-             * and stores are done little endian but from addresses which
-             * are adjusted by XORing with the appropriate constant. So the
-             * endianness to use for the raw data access is not affected by
-             * SCTLR.B.
-             * In user mode, however, we model BE32 as byte-invariant
-             * big-endianness (because user-only code cannot tell the
-             * difference), and so we need to use a data access endianness
-             * that depends on SCTLR.B.
-             */
-            arm_sctlr_b(env) ||
-#endif
-                ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
+        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
     } else {
         int cur_el = arm_current_el(env);
         uint64_t sctlr = arm_sctlr(env, cur_el);
-
-        return (sctlr & (cur_el ? SCTLR_EE : SCTLR_E0E)) != 0;
+        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
     }
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f05d042474..4c65476d93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11061,9 +11061,6 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX,
                        arm_to_core_mmu_idx(mmu_idx));
 
-    if (arm_cpu_data_is_big_endian(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
-    }
     if (arm_singlestep_active(env)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
     }
@@ -11073,7 +11070,14 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
 static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
                                          ARMMMUIdx mmu_idx, uint32_t flags)
 {
-    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    bool sctlr_b = arm_sctlr_b(env);
+
+    if (sctlr_b) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, 1);
+    }
+    if (arm_cpu_data_is_big_endian_a32(env, sctlr_b)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
+    }
     flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
@@ -11122,6 +11126,10 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     sctlr = arm_sctlr(env, el);
 
+    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
+    }
+
     if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
         /*
          * In order to save space in flags, we record only whether
-- 
2.17.1


