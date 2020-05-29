Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC5E20721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxDAMQAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC5E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef08-0005om-Ls
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeez6-0004FE-Pj
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeez5-0003YQ-KD
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id d10so1486457pgn.4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RseCa26F61nDIy9E0oS7cXPax4VaGb6c+jHKYyFKj1U=;
 b=pxDAMQAJ5dYvpU2v+D/M4UDHrAs8jItoUXgA46fx67QwcXWqxXXzcYBrzxnfJv0Ryq
 AQp+O8OwVXGjre5JEjlFay6wEz0R5EUY3a3Sd11JWosxFxl2ym51mZ2s/QtiBIZRsNIn
 IxqriWUvfWWdkFiQAn8lmENM1yJwc3DG4EXhISovJiqT3rlKvfDd73tFYcbIelP3Uapg
 VJxXtADqD0Hlyoxq26NzFZvs4BSgIgnRa+l9iKlL9MBlbbS1LLwHIn7yk/SD7TCdubNd
 x+w6HLNOkH2tHudSYc8Njicct3CDa92nviHByBdy8+5f1TLPfk8wPD3EEbyGOZ7q3n1K
 yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RseCa26F61nDIy9E0oS7cXPax4VaGb6c+jHKYyFKj1U=;
 b=FI7y3BoQmbeQOC/ESuudf848KMpPYQpaMNliIfedGS2u7qRff7NIRk8y1LWx6r8n7C
 jh+pdiZ9OyjyzNoKeK8UYY+KwyfBaTbxHl20q5rqfDya6RxDdfe3Zf918fCH1h6S3XEI
 4Yx6idLEnRqNjUqN1aV+O3iTaMHnim1o9KcijA6NtXB9kt7csmdawL7J4+1PW6ex5OW6
 64OUbtg1rt+ZLLiU8TcMT/wsR4jyx1zwCBvW11AM9tXp/2MuwqbQf6ijGcl9LH1oE1Fr
 EKlGHO5SjbphwhVDSRQ3JK+8eL7AMNIbDZp6JAip5rk6tfc2BHlQryvtVWulB9QSy4JO
 CGhQ==
X-Gm-Message-State: AOAM530QMFJ60ShCF+ad94DsT9bswCfWPyYB7XYuXjyKTIoEymaY7Ttu
 zcpcQxQME5E2N1c1DKFOwYAEcGuKm6LNew==
X-Google-Smtp-Source: ABdhPJwXP5tMLW8pc0UK6wNO/w7yWh35dNhAK4CHQASMiJBFpFjA5klkuVh+NJ8DjiSEnWkz46mqog==
X-Received: by 2002:aa7:9515:: with SMTP id b21mr8383189pfp.282.1590758617773; 
 Fri, 29 May 2020 06:23:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/12] cpu: convert queued work to a QSIMPLEQ
Date: Fri, 29 May 2020 09:23:32 -0400
Message-Id: <20200529132341.755-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x542.google.com
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
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 25 ++++++++-----------------
 cpus.c                | 14 ++++++++++++--
 hw/core/cpu.c         |  1 +
 include/hw/core/cpu.h |  6 +++---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 55d5df8923..210fc7fc39 100644
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
index 5284d384fb..77703d62b7 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -368,6 +368,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->work_mutex);
+    QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f7698155..d78ff1d165 100644
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


