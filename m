Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CCC2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udiLio37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CCC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIsR-0000eq-AW
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc4-0004Tk-C7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc1-0001sU-Cw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id o3so3735466pgr.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EhkdHT0Y0sf1vj+jVq46ouiJkTQDiOCLodMdEnwCB18=;
 b=udiLio37T5afpZcNWLKcW9iXG0GpkmgTuRG3Q9Ua/WzCsgpEN29/eKxLhuV7LN5G1I
 KCsLii2YrivaUGGS1u9VIOeGxVaXLRb5oVSpREk0eEzel0PCwHyD8hOeS7BHmnM6TH+O
 Prf+lEUTHRTDdF4wbKBOVP0vBogecbPBkNlXwfrTWd4a7IwA0c4q78KY7swNfTt3K4BM
 9+X3RGebWexGeFda+8Z+cNicsOQYRcapfje931PRvVUxvTTxYuNrJiZej12+E3Q9lPyX
 iLAWmG54gw8t0dgE8gPvhALjpzjD/ypsf1MYWDxeIEICVBYqGCvYqCBE/0K4N1uSa3Ib
 m4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EhkdHT0Y0sf1vj+jVq46ouiJkTQDiOCLodMdEnwCB18=;
 b=miPBibgV0HUI06jGZj0Zq12RtTCvVM5i4TuziqbQ6fVkjPkclqduHxi7nHfveiIdXL
 uEQzpuv2AIJ7197ifNTQxr60XG8HF7buUekqf5bKUB7+AoOqKidxpinStWi1aPaYp96l
 fxZIU9FduxA0Ul6fwGAoa//RSg61evo3krfvUdATdaz5Uz2ns+n16oZojxGt8KpKMZa5
 c3weSaq5D6HL20z7D6L5g8LHdlPkN4dMe/Uq37ZZl4+CwRmLaQhTl7g8iEqO9X/vq+7f
 iwTLmuTbTQA4N107B1q9gXJ7WqFZCKZzu/mzjd+KQsp2amhcTV0L0AfyDCTHarykj1A7
 t9QQ==
X-Gm-Message-State: AOAM530x+J1RMB8iEX1r11YYe7loJkbvwIXzC/5ryVGXDctU0bOYzKWV
 ChBUNYzqPTiIAZkLZ3zbXWE02JiYInPa1A==
X-Google-Smtp-Source: ABdhPJx8xEZZBE0dJbJ9v1ryHHa2f11PnCIoXgzyZW2is3T+bHDvP3ACqT1rF2iRpp+ZXEqyx5xZjg==
X-Received: by 2002:a63:af02:: with SMTP id w2mr6195839pge.339.1604018987674; 
 Thu, 29 Oct 2020 17:49:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/19] tcg/aarch64: Implement flush_idcache_range manually
Date: Thu, 29 Oct 2020 17:49:20 -0700
Message-Id: <20201030004921.721096-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy the single pointer implementation from libgcc and modify it to
support the double pointer interface we require.  This halves the
number of cache operations required when split-rwx is enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 11 +-------
 tcg/aarch64/tcg-target.c.inc | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

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
index bd888bc66d..5e8f3faad2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2968,3 +2968,56 @@ void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
+
+/*
+ * Flush the dcache at RW, and the icache at RX, as necessary.
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
-- 
2.25.1


