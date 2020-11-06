Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD7C2072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjGF/+cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD7C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasg1-0002OZ-1Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRk-00056E-Ng
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:52 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRi-0006zm-On
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:52 -0500
Received: by mail-pf1-x441.google.com with SMTP id o129so63416pfb.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pKuwnlUIT6JfwyL/m5qNM+3MOPkBgPWHJhGqKzX+RB8=;
 b=fjGF/+crcWe4wFONKjPaVOqD72H+BNwvutDAFDtd2yxqCGi10BOCcv5WRuM0PBKAbG
 asjmsyZ99OTIRBEkDjMMiXXIqRSjCwvZ5aGvirGAW0KCe6O539QeJ8SnueTSApmJA3JW
 utPnAN05fXJUvn+rU0107Xu/jWAsfIhUeuWpG2EzVOfvp0LgmsYAR1WE3W2ENp5CwoKV
 n8GCYSa/FPHEHlkD2oSqD7JL4avIokeu23i4vcm7TEC+XDzU2QngtACIM1MzgelfZMaV
 jXGyAZ4XFPSPjH1OnFJ+r4JMg7b4cQux5moCqIfQijZk2aLewcBjALW+8R177wDWRQsh
 NM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pKuwnlUIT6JfwyL/m5qNM+3MOPkBgPWHJhGqKzX+RB8=;
 b=Cr6H6706Mgx9L3mh1kfaAncMg5yVGq8YGRsMNdOEuOh8tLJ1DoxNQvZOIxjkV4aZH+
 KAxWdFAPfPv2kyMyzHLpCvPWHo6GxQZObaA3p1+ouMuGX1OiyjAVzOngXI85Nz1dDEde
 xIv9zKs2CB4gUAVPL9qv4cccjz/TBYXDGtajxxcUHoCnnAs3ftRREvwf3tpPBIU+3dR5
 tVYwDi0OnAB7OuacJxcIeduBieYxuDf7+VqK5MzdHpDGcFvLgO8u+nU7GwISn8qblRCi
 qErJsExllKBaYJQE12euqSGE2zRAkwnhIH7S7833zZx0VMvfNCPz3mQ/HM4ZjLMmjQvM
 6exg==
X-Gm-Message-State: AOAM532yiONXZUBfjAgBb6f85mBll5tVGaXKQVk9Zue4cEek8PLMYR9D
 M8gND+81BdfLaZ6UbWe76S77xG4ahqIEsw==
X-Google-Smtp-Source: ABdhPJwh1Bs2pG6zaa7p1cAXAaB0qbiyhHWVJjSCpuJRDuaogvQkwCZRAYHOT7JaMn2OS0QfONLWMw==
X-Received: by 2002:a17:90a:80c6:: with SMTP id k6mr146051pjw.73.1604633389007; 
 Thu, 05 Nov 2020 19:29:49 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/41] tcg/aarch64: Implement flush_idcache_range manually
Date: Thu,  5 Nov 2020 19:29:00 -0800
Message-Id: <20201106032921.600200-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

Copy the single pointer implementation from libgcc and modify it to
support the double pointer interface we require.  This halves the
number of cache operations required when split-rwx is enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 11 +------
 tcg/aarch64/tcg-target.c.inc | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index fa64058d43..e62d38ba55 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -148,16 +148,7 @@ typedef enum {
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-/* Flush the dcache at RW, and the icache at RX, as necessary. */
-static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
-{
-    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
-    if (rw != rx) {
-        __builtin___clear_cache((char *)rw, (char *)(rw + len));
-    }
-    __builtin___clear_cache((char *)rx, (char *)(rx + len));
-}
-
+void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bd888bc66d..8aa1fafd91 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2968,3 +2968,67 @@ void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
+
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+#ifdef CONFIG_DARWIN
+/* Apple does not expose CTR_EL0, so we must use system interfaces. */
+extern void sys_icache_invalidate(void *start, size_t len);
+extern void sys_dcache_flush(void *start, size_t len);
+void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
+{
+    sys_dcache_flush((void *)rw, len);
+    sys_icache_invalidate((void *)rx, len);
+}
+#else
+/*
+ * This is a copy of gcc's __aarch64_sync_cache_range, modified
+ * to fit this three-operand interface.
+ */
+void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
+{
+    const unsigned CTR_IDC = 1u << 28;
+    const unsigned CTR_DIC = 1u << 29;
+    static unsigned int cache_info;
+    uintptr_t icache_lsize, dcache_lsize, p;
+
+    if (!cache_info) {
+        /*
+         * CTR_EL0 [3:0] contains log2 of icache line size in words.
+         * CTR_EL0 [19:16] contains log2 of dcache line size in words.
+         */
+        asm volatile("mrs\t%0, ctr_el0" : "=r"(cache_info));
+    }
+
+    icache_lsize = 4 << extract32(cache_info, 0, 4);
+    dcache_lsize = 4 << extract32(cache_info, 16, 4);
+
+    /*
+     * If CTR_EL0.IDC is enabled, Data cache clean to the Point of Unification
+     * is not required for instruction to data coherence.
+     */
+    if (!(cache_info & CTR_IDC)) {
+        /*
+         * Loop over the address range, clearing one cache line at once.
+         * Data cache must be flushed to unification first to make sure
+         * the instruction cache fetches the updated data.
+         */
+        for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
+            asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
+        }
+        asm volatile("dsb\tish" : : : "memory");
+    }
+
+    /*
+     * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
+     * of Unification is not required for instruction to data coherence.
+     */
+    if (!(cache_info & CTR_DIC)) {
+        for (p = rx & -icache_lsize; p < rx + len; p += icache_lsize) {
+            asm volatile("ic\tivau, %0" : : "r"(p) : "memory");
+        }
+        asm volatile ("dsb\tish" : : : "memory");
+    }
+
+    asm volatile("isb" : : : "memory");
+}
+#endif /* CONFIG_DARWIN */
-- 
2.25.1


