Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED94C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC5F20679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0VYwNye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC5F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37Dd-0005u8-LP
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BR-0004AQ-Gy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BQ-0008FV-Eo
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i37BQ-0008FJ-9W
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id x15so506652pgg.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tDJarBQckpHfmmZQqSzy2ha1vD1pFwdD3YsUtk0RotI=;
 b=D0VYwNye3al5GsUig7yHFzdRrwlPr/RYP7Wa3kgkSvxJq4NbC0cwOtBQOgRIvYJn7M
 oNzT7HCtyEoCIX2JATPuONq9G2SRy5Q3SoH2et2++HU336Heg139AreD9x5hhRzmP0O5
 Tau+9xYiPhFhzws4P7PpvHMuFf35Lw4dixeSTTlR3Fp4jBFvpRuFENVpWcjvurbdNpOs
 pkffJsJpuv0tAFQ7ag3beAubHExhEX/kcczlB9PXI+pklvDZLKUQBwcG06A5yt/ewbAh
 zxBqZli8bZOUNWBSmjyxMghsuayTDbNMneiCTNcmkPUCFSVip67nB3UwLtqk5HfBKx/1
 Thrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tDJarBQckpHfmmZQqSzy2ha1vD1pFwdD3YsUtk0RotI=;
 b=rP5deIwUkTgyI40gIEbZxy7doU4Nkz9hWAjNvMb5H7TTy+ZLzSYYqa89DHxSL40WO5
 gGzwJl1ejWp1tKUwFw0MoxTx12PZPg1sFZSW+uLLCrN6qGUV9h/ixEVjIPVEkY4Kj0km
 Ittg8X2Il4L9Efqfu5smxnLFHqkOA43oJNFIGnIA1fLfSIgYWq0hGnJVvZkgr94VnwYG
 j+Toi3UnClLXdcSdhHd/iHwXMf6PN48hTfr0of7KQ6GdNxRLbylSZynXmWcNbKt8UF25
 IEh8I9pjyFodfZuc6cQ/Ixq9J4uObeK5WiR6r7kosRip4b56z+bzP7xQDI9OslJsKe4a
 7sQg==
X-Gm-Message-State: APjAAAU6/zWf4fdstuG8BDuf3ykzn6OogufZ3iUuCsYDuRjk98Qq7tG+
 Mt+5y1KF9fC43Y5KpmdpherXR5+A5Xc=
X-Google-Smtp-Source: APXvYqyjPBW5QKcYAte+6fH6xVT0pSkbiENVKWqqMC/3taH4DQYDP5cwkVSsn/Nbohy2cT4qJcXonA==
X-Received: by 2002:a65:5584:: with SMTP id j4mr5571598pgs.258.1567034214749; 
 Wed, 28 Aug 2019 16:16:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm485197pfm.97.2019.08.28.16.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 16:16:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 16:16:44 -0700
Message-Id: <20190828231651.17176-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828231651.17176-1-richard.henderson@linaro.org>
References: <20190828231651.17176-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 1/8] exec: Move user-only watchpoint stubs
 inline
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the user-only watchpoint stubs resolve to empty inline functions.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 23 +++++++++++++++++++++++
 exec.c                | 26 ++------------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77fca95a40..6de688059d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1070,12 +1070,35 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
     return false;
 }
 
+#ifdef CONFIG_USER_ONLY
+static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                        int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                                        vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
+                                                CPUWatchpoint *wp)
+{
+}
+
+static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+#else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+#endif
 
 /**
  * cpu_get_address_space:
diff --git a/exec.c b/exec.c
index 53a15b7ad7..31fb75901f 100644
--- a/exec.c
+++ b/exec.c
@@ -1062,28 +1062,7 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 }
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-
-{
-}
-
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags)
-{
-    return -ENOSYS;
-}
-
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
-{
-}
-
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-#else
+#ifndef CONFIG_USER_ONLY
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
@@ -1173,8 +1152,7 @@ static inline bool cpu_watchpoint_address_matches(CPUWatchpoint *wp,
 
     return !(addr > wpend || wp->vaddr > addrend);
 }
-
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
-- 
2.17.1


