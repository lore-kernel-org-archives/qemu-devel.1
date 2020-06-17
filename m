Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23558C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FB52080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxbDiHWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FB52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfdi-0005QR-V9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE9-0003Hi-0J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:09 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736]:36744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE5-0008Vj-2Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:07 -0400
Received: by mail-qk1-x736.google.com with SMTP id 205so3519792qkg.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MqrgrNTQ/ix1Dv7Vxho5rUxV7/F8VuXS30653W0xsHs=;
 b=pxbDiHWqDjdbSYz4Nr7qe5Nnf8SNlv3vdF/xKuTyXCanWL0j11BVGokBv3jrVA3Pva
 Vpy7wd5AbO8HJ/ScuLEmDLK47ube3CtN8MBU7gS4qipZ75UpXCOzb4/GeJbCMfz9QUIJ
 VAwy5Iiozk9ejkKCiYZLxNnBWpRpvWTT6Mkh8Z1Dt2Sb462J7edP/vx855pnj3iioVbi
 RLFc6cDA2XM8IqOQyfqpPP98XCKSDRiffJCfX/h33K9e3zbp2/dgjNTcwjSXqykpnDVr
 MmHZrvSfsXXhQ+zlfq3wMr8m3mGgoAov+WkdeoaoYIL3IVaMAymWPpijGPit3+aYjCVi
 b63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MqrgrNTQ/ix1Dv7Vxho5rUxV7/F8VuXS30653W0xsHs=;
 b=Z4A9TBqTfyz8W46nChgVXBuehH7WpIZ8GlRXWrHAKOJeeWi47EmqmE0LEc5Bvcn2CU
 WJDXhtczpRc6p+ObKINOuKhqSWzYHd3FFxHiSkO0Mltaz+Ei0QqIB3Wv4IsJoX7w4iDy
 gVgFMzLM3TwwdJ2tHy6NggANG9xt7MGF/xL0LAFTK1W+J9uzsRecaHKmS0BswsFdNGtc
 ew7vFccZFmK742BkUMa+DNd7eU7e0MReKd+MDUD4DKs0XUwcM3arBk0PA2Eo/hogxZa2
 IhW6R99PJp0gHRNYMH5WiVso26b0WAJGs1GRQEtXpeN2YNulPYlppOk6jf5p/9FM//Tg
 djtg==
X-Gm-Message-State: AOAM532AU8A7TnrAIqSqXLLQAZ1qX4hoIh1yE34EVXnvzEZ7CNiv21df
 PrdXJ2xNB2gqvxeuR5zdm+gf9pTi5PFZHg==
X-Google-Smtp-Source: ABdhPJyQmN7ygmXBAnkvcrrWpT2g1xjvKyQ/lYMBvAtkb/JtQFLFDOb4OPLRpBdCRdpypnR5Y9di9Q==
X-Received: by 2002:a37:a84c:: with SMTP id r73mr332364qke.0.1592427842402;
 Wed, 17 Jun 2020 14:04:02 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:01 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 32/73] cpu: define cpu_interrupt_request helpers
Date: Wed, 17 Jun 2020 17:01:50 -0400
Message-Id: <20200617210231.4393-33-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x736.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
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
index 64a1bf3e92..d3223f6d42 100644
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
index 92069ebc59..6f2c005171 100644
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


