Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1897C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF5B2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCQnDTZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF5B2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikcC-0003WF-Ms
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ3-0007Os-67
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:41 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ2-0005ZH-7E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:40 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q24so1885049pjd.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pD3JWxT76a4NROnBN3hpZMTAPaW7sxqBc70GvHSGYPw=;
 b=wCQnDTZKeoZgWMDzK6ZzWdAIyphAjAWuDsiT1OCXPbI2zLvafiPEIs3hsKVdrm0LQv
 4c7ABOz46g0c/CtX9kuWYATO/3bTb9ToHouMW3cjNrgLYRsbubnYCDEETXG5EH6ISEtc
 0dPqkXzdw8t2NhpxWntekoroRYJalibvDEKKraXQKwq1PGsY77Ky8dtZ0A5d7iuedN/Z
 FF2OZu/YKr8jyl6yH2n8TFMrOaRmCh/6p3464DttMRgKevX8w18Kn0HQQrIO1JVwIdrh
 4gGBEz4xB5Jv0/A7CNs6NPSD3DhzLb+wLdMSQiLWAMsVlsLCGEY3DzHGDKfJQK8K5P9F
 mJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pD3JWxT76a4NROnBN3hpZMTAPaW7sxqBc70GvHSGYPw=;
 b=qO8o+YNZqE6DA3pX2s9WB8i885AZTkmAmxuH6LRRL4PhSvPKfpa2x62QXIPBopVxOL
 JHEvhi5BhULb0elgZiWVq99jPHEdnAtIEEhcXGvJbXbWwvc6SvoLVM2RAOOoktZ79kiS
 u7LKU2x1RfAtK7hYnq5v/S/8nmUAbv/Yr0C5kULTAOnv8cwzdVA7bRDZP6DjeoiiPWFZ
 pRVaBm3cCoCsJLBl4gIBiwHMfUjBSlRNqdhECngK3oPpF7cyX25WgOJj4E7Xhmj0U6k+
 BM+MSy53MWuYCTVyAI81zLdpbFGqcq728NaUTeIZkFjmfiDwbbdEIEf6haRwcOtCP3Eo
 JxiA==
X-Gm-Message-State: AOAM532QSaRyNMTuara+MUnPn2yNtPq8p4UaW84QVOBEydm9WCgaaE6s
 MJNwIj12p9Cp4uEX/Vj9ZZKAqEFHKVrUMA==
X-Google-Smtp-Source: ABdhPJwSE+qwkssRPlMyXQ7j15XVFeebiljc43KOVqesCJuEldCz7vB+6h9yrLpbT6bUj29O5qFldA==
X-Received: by 2002:a17:90a:240c:: with SMTP id
 h12mr6670763pje.42.1591733378558; 
 Tue, 09 Jun 2020 13:09:38 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/13] cpu: convert queued work to a QSIMPLEQ
Date: Tue,  9 Jun 2020 16:07:27 -0400
Message-Id: <20200609200738.445-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

We convert queued work to a QSIMPLEQ, instead of
open-coding it.

While at it, make sure that all accesses to the list are
performed while holding the list's lock.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 25 ++++++++-----------------
 cpus.c                | 14 ++++++++++++--
 hw/core/cpu.c         |  1 +
 include/hw/core/cpu.h |  6 +++---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 70a9d12981..8f5512b3d7 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -97,7 +97,7 @@ void cpu_list_remove(CPUState *cpu)
 }
 
 struct qemu_work_item {
-    struct qemu_work_item *next;
+    QSIMPLEQ_ENTRY(qemu_work_item) node;
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
@@ -106,13 +106,7 @@ struct qemu_work_item {
 static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 {
     qemu_mutex_lock(&cpu->work_mutex);
-    if (cpu->queued_work_first == NULL) {
-        cpu->queued_work_first = wi;
-    } else {
-        cpu->queued_work_last->next = wi;
-    }
-    cpu->queued_work_last = wi;
-    wi->next = NULL;
+    QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
     qemu_mutex_unlock(&cpu->work_mutex);
 
@@ -306,17 +300,14 @@ void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
 
-    if (cpu->queued_work_first == NULL) {
+    qemu_mutex_lock(&cpu->work_mutex);
+    if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        qemu_mutex_unlock(&cpu->work_mutex);
         return;
     }
-
-    qemu_mutex_lock(&cpu->work_mutex);
-    while (cpu->queued_work_first != NULL) {
-        wi = cpu->queued_work_first;
-        cpu->queued_work_first = wi->next;
-        if (!cpu->queued_work_first) {
-            cpu->queued_work_last = NULL;
-        }
+    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
+        wi = QSIMPLEQ_FIRST(&cpu->work_list);
+        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
         qemu_mutex_unlock(&cpu->work_mutex);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
diff --git a/cpus.c b/cpus.c
index 5670c96bcf..af44027549 100644
--- a/cpus.c
+++ b/cpus.c
@@ -97,9 +97,19 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
+static inline bool cpu_work_list_empty(CPUState *cpu)
+{
+    bool ret;
+
+    qemu_mutex_lock(&cpu->work_mutex);
+    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
+    qemu_mutex_unlock(&cpu->work_mutex);
+    return ret;
+}
+
 static bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || cpu->queued_work_first) {
+    if (cpu->stop || !cpu_work_list_empty(cpu)) {
         return false;
     }
     if (cpu_is_stopped(cpu)) {
@@ -1498,7 +1508,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index f31ec48ee6..80d51c24dd 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -370,6 +370,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->work_mutex);
+    QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 497600c49e..b3f4b79318 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -331,8 +331,8 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
- * @work_mutex: Lock to prevent multiple access to queued_work_*.
- * @queued_work_first: First asynchronous work pending.
+ * @work_mutex: Lock to prevent multiple access to @work_list.
+ * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
@@ -376,7 +376,7 @@ struct CPUState {
     sigjmp_buf jmp_env;
 
     QemuMutex work_mutex;
-    struct qemu_work_item *queued_work_first, *queued_work_last;
+    QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
-- 
2.17.1


