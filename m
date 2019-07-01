Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A080C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186C7208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JC08Fcdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186C7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi6Bm-0004fB-Mz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Yn-00010W-Pq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Ym-000798-Db
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Ym-00078i-5Y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:00 -0400
Received: by mail-wr1-f49.google.com with SMTP id p13so15293860wru.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wcyxWSQr6ooIWGi3dHkpFWTd3ZA08bJNcEU2ip3p0QI=;
 b=JC08Fcdg3eZTwjCYyfjtE3GavaJ3dS2BdvXaZzJrkF/iqC3figEKtZ96K6USXRdNMf
 3/7ZfxZdRvPuBgKRoJCTpecN5j/jETcA/n27f1RRcmvyxirtUIOb7B+jOzJVtmJs9dgn
 uJS4fkpkcvjGZoQ2NgAoAPdZtghBIdBWHQwKLfEd68hBX8x1UjiB4yES1FmdrythHmnh
 /Z6AkdI/OHL5uG4+FuaV246MIqbtFhiADSjD7WwbazHd5mMgrf0CvxNzwZC1NcFgMmXz
 EDBabw3tD4K7G+BKOv4Y2G2Cr5ybUH2iNJOOYxAooDcv5wOEIAUWmsfuZcLCQY4x0/tg
 7/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wcyxWSQr6ooIWGi3dHkpFWTd3ZA08bJNcEU2ip3p0QI=;
 b=WWZW3+Oz29EjMZ9jcsZPfKRGiB3ccH7ZXMU7nJY5wEldQEBF6e6XmZ9YdaBNZyYnar
 n903LhlOc25Vww/HrcrMLPGRVP+sGOLjccir7gb9e8/J+7BIb7X8yLSI+Fg8zbqOQpMA
 2FyId/nqDzD5JmaFzT3cE37/c3qTvYwWV1OmDvPRkgD+8p91WHsA3wMhPaaoh1ztYk4h
 E6irJPcyYVGXMuk07SO4sUlopywmq/E5pu+BHzVBZavF/y7bGGPXuxcQi4lf4EAx5MYS
 tcHXx7KnZJ6Wu6QL0pf8NyLNBSM2/C8cbW3noT7W9exeoUXGK6lpTTQdb3LLKqXnR68j
 ldrA==
X-Gm-Message-State: APjAAAW7i6uf/nIz0AInoGemMleop7iLPVOjnFr53JdD+HLi0x9O+y/a
 zg4m4wJmKcTwWDfTMcD+BZhXN2MDeq8Q+Q==
X-Google-Smtp-Source: APXvYqyb8VnCF27PPxhc4ig/XxX0Zw7GGo8IW0pr9bg+HaBuiohmfQW5hZsZQHozRmVx8H46FnTUjA==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr19881836wrl.212.1561999236096; 
 Mon, 01 Jul 2019 09:40:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:43 +0100
Message-Id: <20190701163943.22313-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.49
Subject: [Qemu-devel] [PULL 46/46] target/arm: Declare some M-profile
 functions publicly
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In the next commit we will split the M-profile functions from this
file. Some function will be called out of helper.c. Declare them in
the "internals.h" header.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-22-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c    | 38 ++------------------------------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11bfdba5129..232d9638753 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -892,6 +892,27 @@ static inline uint32_t v7m_sp_limit(CPUARMState *env)
     }
 }
 
+/**
+ * v7m_cpacr_pass:
+ * Return true if the v7M CPACR permits access to the FPU for the specified
+ * security state and privilege level.
+ */
+static inline bool v7m_cpacr_pass(CPUARMState *env,
+                                  bool is_secure, bool is_priv)
+{
+    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
+    case 0:
+    case 2: /* UNPREDICTABLE: we treat like 0 */
+        return false;
+    case 1:
+        return is_priv;
+    case 3:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /**
  * aarch32_mode_name(): Return name of the AArch32 CPU mode
  * @psr: Program Status Register indicating CPU mode
@@ -988,6 +1009,27 @@ static inline int exception_target_el(CPUARMState *env)
 
 #ifndef CONFIG_USER_ONLY
 
+/* Security attributes for an address, as returned by v8m_security_lookup. */
+typedef struct V8M_SAttributes {
+    bool subpage; /* true if these attrs don't cover the whole TARGET_PAGE */
+    bool ns;
+    bool nsc;
+    uint8_t sregion;
+    bool srvalid;
+    uint8_t iregion;
+    bool irvalid;
+} V8M_SAttributes;
+
+void v8m_security_lookup(CPUARMState *env, uint32_t address,
+                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                         V8M_SAttributes *sattrs);
+
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                       int *prot, bool *is_subpage,
+                       ARMMMUFaultInfo *fi, uint32_t *mregion);
+
 /* Cacheability and shareability attributes for a memory access */
 typedef struct ARMCacheAttrs {
     unsigned int attrs:8; /* as in the MAIR register encoding */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc880b4dabc..38b73430cbb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -39,21 +39,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
-
-/* Security attributes for an address, as returned by v8m_security_lookup. */
-typedef struct V8M_SAttributes {
-    bool subpage; /* true if these attrs don't cover the whole TARGET_PAGE */
-    bool ns;
-    bool nsc;
-    uint8_t sregion;
-    bool srvalid;
-    uint8_t iregion;
-    bool irvalid;
-} V8M_SAttributes;
-
-static void v8m_security_lookup(CPUARMState *env, uint32_t address,
-                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                V8M_SAttributes *sattrs);
 #endif
 
 static void switch_mode(CPUARMState *env, int mode);
@@ -7733,25 +7718,6 @@ void arm_log_exception(int idx)
     }
 }
 
-/*
- * Return true if the v7M CPACR permits access to the FPU for the specified
- * security state and privilege level.
- */
-static bool v7m_cpacr_pass(CPUARMState *env, bool is_secure, bool is_priv)
-{
-    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
-    case 0:
-    case 2: /* UNPREDICTABLE: we treat like 0 */
-        return false;
-    case 1:
-        return is_priv;
-    case 3:
-        return true;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * What kind of stack write are we doing? This affects how exceptions
  * generated during the stacking are treated.
@@ -12117,7 +12083,7 @@ static bool v8m_is_sau_exempt(CPUARMState *env,
         (address >= 0xe00ff000 && address <= 0xe00fffff);
 }
 
-static void v8m_security_lookup(CPUARMState *env, uint32_t address,
+void v8m_security_lookup(CPUARMState *env, uint32_t address,
                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                 V8M_SAttributes *sattrs)
 {
@@ -12224,7 +12190,7 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
     }
 }
 
-static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
                               hwaddr *phys_ptr, MemTxAttrs *txattrs,
                               int *prot, bool *is_subpage,
-- 
2.20.1


