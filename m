Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E673C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E8020714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSlGMQPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E8020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYKj-0006Zz-CA
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJZ-0005GF-O7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJY-0001AC-Dw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:17 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:39781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJY-00019w-9B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:16 -0400
Received: by mail-qv1-xf42.google.com with SMTP id v38so3695257qvf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjFm//DWMi6cEsZVv5KoKUnVyxoBxmxtsqRICwgP0/8=;
 b=aSlGMQPlb5nN8SVlB/gPsmL3JQwCKOn5KAj18XjH1V5OgPpP38dD/uqga8jCWaR/Uj
 jwZqWSzx7NhhTnqV+rQUcFGFUvieyo92dPeqGtN19G1+MtXm+/Q+hNIVTM8jFptpCAfd
 KAdZw4c1hH5IXo9K6aHR+t5ujINHigNvYlHLrlVZFO0cmCxVD+JszyZMWj5WhwDuOSGi
 duPyhIJY0UbZtPDDzzpprfS1cVcsy9JtT+DE6t6Cyt/0RyTwvURVdhj1+RQuHWPZU6k+
 qvGQubtOUVZhe7jxnCbE2CnKw+KyLkljGwd6wM8j2mDkFhqpPFq68kbvI1RgE3dSwBBa
 ophw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjFm//DWMi6cEsZVv5KoKUnVyxoBxmxtsqRICwgP0/8=;
 b=b+3Djsl1XW/VqfBHIdNcXIbaVUg5rIYHK44MQkPBBOZUL0wzVsckhLgthlKqZhPLw5
 xbi5DLY78lar+L9TbuW6WlnRHh22OinrnxfvNBV/oWF7vAc0QpcUW2P4fc0dl47ze3OQ
 Oqg8m0oUHyLdH2kwIww3+t97InO5OQcTsVrpikL+2XzcW+l+DWcR47zp47o+QabXyXM8
 IfmIrCSaors6MBZpasIQnbWDg2XeoUwb+5y+UVn/BHK+ezBH9/5W8vIrkrz1xF1xjCAE
 iNnKiGVAOKeKOpWHO7sVki2PcV2jS+QAv9efim8AmSC2ryWoBLWP8sbjWBultF8XitND
 nP4g==
X-Gm-Message-State: ANhLgQ2w9NsvdrriXoBUJCiXbt1Aaas5BNzx48gM7H3Co8GJZatcqKat
 q9LfZpsKiZA7FZwug8Yvm50wZXUA+D+oYg==
X-Google-Smtp-Source: ADFU+vvNmnOMjuZ3Wsw4ASN1lxxCU1+2qByz40IX/jxTUtP2lxYQ9wL647/607JsmbhN+fhI2+6nOA==
X-Received: by 2002:a0c:aee5:: with SMTP id n37mr9662382qvd.173.1585251435240; 
 Thu, 26 Mar 2020 12:37:15 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/74] cpu: convert queued work to a QSIMPLEQ
Date: Thu, 26 Mar 2020 15:30:43 -0400
Message-Id: <20200326193156.4322-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Instead of open-coding it.

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
index eaf590cb38..3d659df464 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -99,7 +99,7 @@ void cpu_list_remove(CPUState *cpu)
 }
 
 struct qemu_work_item {
-    struct qemu_work_item *next;
+    QSIMPLEQ_ENTRY(qemu_work_item) node;
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
@@ -108,13 +108,7 @@ struct qemu_work_item {
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
 
@@ -310,17 +304,14 @@ void process_queued_cpu_work(CPUState *cpu)
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
index ef441bdf62..151abbc04c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -96,9 +96,19 @@ bool cpu_is_stopped(CPUState *cpu)
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
@@ -1490,7 +1500,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 786a1bec8a..2fc6aa2159 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -368,6 +368,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_threads = 1;
 
     qemu_mutex_init(&cpu->work_mutex);
+    QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..398b65159e 100644
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


