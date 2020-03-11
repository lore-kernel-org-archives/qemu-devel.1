Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D5C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C92208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GshumYDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C92208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvBE-0004eL-Nj
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6U-00067p-0u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6S-0001nR-9i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6S-0001hI-4P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id c7so645489pgw.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B3XDGQrOIHo2Z/Fxm4hqpcuhDa9MTHMM7/GJHSmNf48=;
 b=GshumYDGLFLuvesKBTQC9q0ilBA4N4T54w6gyQPr9gXCq4SD15BazgVA4Dze02YJEj
 RdGGW+qMy4eYhuAM0HTSXQYYOVfGekhn8MoWFP3NgI0+Zy0pi69L6o9X5xJJ+qruIMw4
 dYH1Q8KSF1a6SwDOgg8y3js+Ib15hBL3oSa3V4M5tqp5C6pD5AIRJuxNY0GSDRpKkukt
 4dDaPwC5j+or5ACIrzO0WHc0CQ6kE3Iojl84TVuDMy9u9ffvwHxcipzjndCplSySkJ6u
 dkGCMiaURON6IW0WxGhs1uTyMSL4kQhHmqUsoLARvngm3bTwVE4Cnn/CGh7RMRP1Zkmw
 DskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B3XDGQrOIHo2Z/Fxm4hqpcuhDa9MTHMM7/GJHSmNf48=;
 b=p/S70XvQ0F9fNM120i7gJOynfNH79XUsrFMZawi0+3M/htGclLPl6r80S33aR5vOMR
 W65/7pfSFsyUOrvTuwU3XHOfcm3+wn9/qojXsBUi9P6ZpFrzkslGrSmwJGZnv0Etrqkx
 HZAZZDYEiXSADCdCsBKxqB1kNGZvqUXAC3uBVEQO7uYIfdx6FNXcuMc+ZxgwFf5UGRww
 SUidxA4ica+ucIzL1bmoYNX1rLAZAuROcqU/WHTHTXjiy/hWTPCmO8lx8McAwq32pZ+j
 S9eMyoPDDpKCsdsthbdo8UocyCTe0OrTL5gJunwdDPTATnw1NBIWMhSYz75/CngZG8cg
 Q3Rg==
X-Gm-Message-State: ANhLgQ0V8zPOtg0/cgOnwnRewbK2eOB5RNEFGM4ReSwwhNbjawbaats0
 mBTcEUJ78dRqBuCeeJ/aQHcF6txKsXA=
X-Google-Smtp-Source: ADFU+vsDE5YtRcI3StH6dTp1gXyvB9ugFozopyK1HGRiWTX0lDd2N6a4UY92uZlvFbLbCQ0wK4CZPA==
X-Received: by 2002:aa7:9732:: with SMTP id k18mr1368276pfg.231.1583909065441; 
 Tue, 10 Mar 2020 23:44:25 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] exec: Add cpu_probe_watchpoint
Date: Tue, 10 Mar 2020 23:44:07 -0700
Message-Id: <20200311064420.30606-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Allow probing of a watchpoint *without* raising an exception.
This is of most use for no-fault loads, which should indicate
via some architectural means that the load did not occur.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  7 +++++++
 exec.c                | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a4..8ec44267a4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1090,6 +1090,12 @@ static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 {
 }
 
+static inline bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                                        int flags)
+{
+    return false;
+}
+
 static inline int cpu_watchpoint_address_matches(CPUState *cpu,
                                                  vaddr addr, vaddr len)
 {
@@ -1104,6 +1110,7 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra);
+bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len, int flags);
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 #endif
 
diff --git a/exec.c b/exec.c
index 0cc500d53a..2b8f601b9e 100644
--- a/exec.c
+++ b/exec.c
@@ -2735,6 +2735,25 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
     }
 }
 
+bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len, int flags)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUWatchpoint *wp;
+
+    assert(tcg_enabled());
+
+    addr = cc->adjust_watchpoint_address(cpu, addr, len);
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        if (watchpoint_address_matches(wp, addr, len) && 
+            (wp->flags & flags) &&
+            (!(wp->flags & BP_CPU) ||
+             !cc->debug_check_watchpoint(cpu, wp))) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                  MemTxAttrs attrs, void *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-- 
2.20.1


