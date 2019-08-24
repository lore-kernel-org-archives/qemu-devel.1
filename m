Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B2C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8363F2133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="En1UUyrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8363F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1dkS-0004MN-KL
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgc-0001Lf-Pf
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dga-00031a-N5
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dgY-0002xa-OO
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id v12so9038138pfn.10
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QLLa7oQzyNor8g5gTrV1Ih0+YyC/eiYlSSeR+q2HgEY=;
 b=En1UUyrgUGT8iUh8n38uG58R3mBWmOF+zjaCpwoX6dTbq+TV/nuUJZy6g/2anJlf0m
 yz0Hmnb/aP7EsFJmjumP7523NCkpzJ3/hmzD4IDSb1y5yfJDfj6lKos/8KhW5GZxCcoV
 B0eTUU0g2G2I6csQmH+HlydAbkFWopqhhzTKTcRZxkHjgvsJf0ns1B5plu7ogbsng9P4
 K3oTPml3fGYrncaScbYKL5uWIeYzQnyVAjckioCO732603remXhLPzQvzcuMoN7VSwNN
 DYgBjcBfQb/GFEGiJJyccA9WQHme3MxNhPMBd6FrmczzbznsA+nbELNgF5mIZDo4/oLU
 /gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QLLa7oQzyNor8g5gTrV1Ih0+YyC/eiYlSSeR+q2HgEY=;
 b=tBfWrOh7hJeOOpM3r+ywxMZmz8GfCQOatRXtPXFyIouuilFUdqriQoyLIUl5dB2y1w
 2BxjuX9SqAgbu6WXLqnxvFBWjETqEVwhTBVKUg6DEzr1PBASmFPtEQ6XG3ifRiLw8Gun
 IpQe0aD0DkT/hwwft2bw8B9a4hfVMI6XXehikGUzK+cKg0UC+qg+1mP7yuNDEYLRakCO
 jqwftMcv4QzF+pG/RoFUdXY333yZrD2nVBpbdFVxayRYAHsy5gfG/E6tlNXg7AqO2Nkr
 6qhD6h1s+cFqR4iDLwWEl+0eJfb4x1OYtLyGk5Uk4d0G2F6SZvFdXhGlNZqguG79CIUO
 sW6A==
X-Gm-Message-State: APjAAAVIxhDoiAzTP3dVihwGeqPmQie6PIaSOxj2Xv0nPZtSVCNTAdIx
 SrJ4Ng44Hc5iu4wlKHPTNLaBtfn9mog=
X-Google-Smtp-Source: APXvYqzJyOCP37Tvq/hhE8kaF/4yp4yt38bEJcZR56jdXlxAVn/zYkIcHarrCC2EoUDA+jOvzvV3Qw==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr12431590pfa.96.1566682495598; 
 Sat, 24 Aug 2019 14:34:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:34:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:46 -0700
Message-Id: <20190824213451.31118-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
References: <20190824213451.31118-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 1/6] exec: Move user-only watchpoint stubs
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
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the user-only watchpoint stubs resolve to empty inline functions.

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


