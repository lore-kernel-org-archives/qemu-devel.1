Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF87F207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMj8KPVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF87F207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboXo-0000B5-VN
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIb-0003LY-5h
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:01 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32]:43923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIa-0006Zj-4K
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:00 -0400
Received: by mail-qv1-xf32.google.com with SMTP id p4so3346259qvr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vmVPXwFQm0m0SAqlzFsT5BhTrQzusWHBnvRHdxyhIFI=;
 b=NMj8KPVlLlhzODFX4C1vHZ8TOeFAaZ+gz6xo7CPO0X3bl/kX38yuw0Y2fqmoynghIk
 wVjelWmkoGmWoW+sCxNPVdFLrQtwK526N/a7F9F/Y6iV9GKhHp3I+4Jf/nHNTMQ0ACVl
 1Hjz2LDEHqFTH3Rnjxvz6stC42NMzTiUX4sXi0uOJRvFC4TgfCnTL5X+zkpUMi/HXvSN
 xpeCZrGLKKCUBXYzQSuGeW92KKJFG3BjZaKLyIKvkmC6lw3ERCjZTsBqpWax/H2KDETR
 kiCAY/giOqioKt1PE95ZJciq+M2jJleN4M1lEsh5u0R9xWMS9Or1jeVVwAjwBUod602r
 cvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vmVPXwFQm0m0SAqlzFsT5BhTrQzusWHBnvRHdxyhIFI=;
 b=GiDw0rhUpma8apRm82mwoSNKc1k4zr29gzUQwc9G74+QH1oAR1F2slUZPeP8YiNxuO
 UguMSAWCHXIKJwXRyuOYlbZvmWUFlmLnzvX2qXPWEkXcN24oZKkRErQDaLBvD280awpe
 y09phtaecy5zy1L3BW0lCRAKbwO82J9LybLlsZCWJM/SCQwPkifmoaWPq7U3lZwMoo1Q
 lHYiXnd0yzSGiC7L3fOJSHWjEQAXytR5uu386/I6pzngCFz4yljX65v8tmZcpwTlIbbr
 kMK9tcOpPa56qoXuw+1MhO3u7PN3KF0bdF86Kj56l+sB/eYSCc0+QS1TmmhWUWDz2OuO
 jfcA==
X-Gm-Message-State: AOAM5319th99ow/ecG1n/XG0Zfr1Akj4ksPRcCW6e7VrZqfIjRa+jcs1
 srM8v6XIf/W5zBqFIckiZ1ViP9uy7pNBqA==
X-Google-Smtp-Source: ABdhPJwgDGpkrtjl+AEyv+jblDswv3iCg4HsVm5TEPGbTvq9a1ycy4l9Mc4CWj0kkUa1KzRzSmj00Q==
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr10929438qvf.119.1590079438779; 
 Thu, 21 May 2020 09:43:58 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:58 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 33/74] cpu: define cpu_interrupt_request helpers
Date: Thu, 21 May 2020 12:39:30 -0400
Message-Id: <20200521164011.638-34-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Add a comment about how atomic_read works here. The comment refers to
a "BQL-less CPU loop", which will materialize toward the end
of this series.

Note that the modifications to cpu_reset_interrupt are there to
avoid deadlock during the CPU lock transition; once that is complete,
cpu_interrupt_request will be simple again.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/core/cpu.c         | 27 +++++++++++++++++++++------
 include/hw/core/cpu.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 67a9c2bb16..be9efbeaf4 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -99,14 +99,29 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
  * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !qemu_mutex_iothread_locked();
+    bool has_bql = qemu_mutex_iothread_locked();
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
 
-    if (need_lock) {
-        qemu_mutex_lock_iothread();
+    if (has_bql) {
+        if (has_cpu_lock) {
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+        } else {
+            cpu_mutex_lock(cpu);
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+            cpu_mutex_unlock(cpu);
+        }
+        return;
+    }
+
+    if (has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        qemu_mutex_unlock_iothread();
+    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    qemu_mutex_unlock_iothread();
+    if (!has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
 }
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 820c5b0a9a..6ed806db60 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -522,6 +522,43 @@ static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
     cpu_mutex_unlock(cpu);
 }
 
+/*
+ * When sending an interrupt, setters OR the appropriate bit and kick the
+ * destination vCPU. The latter can then read interrupt_request without
+ * acquiring the CPU lock, because once the kick-induced completes, they'll read
+ * an up-to-date interrupt_request.
+ * Setters always acquire the lock, which guarantees that (1) concurrent
+ * updates from different threads won't result in data races, and (2) the
+ * BQL-less CPU loop will always see an up-to-date interrupt_request, since the
+ * loop holds the CPU lock.
+ */
+static inline uint32_t cpu_interrupt_request(CPUState *cpu)
+{
+    return atomic_read(&cpu->interrupt_request);
+}
+
+static inline void cpu_interrupt_request_or(CPUState *cpu, uint32_t mask)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+    cpu_mutex_unlock(cpu);
+}
+
+static inline void cpu_interrupt_request_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, val);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, val);
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
-- 
2.17.1


