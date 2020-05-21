Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C887A2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZidtQ0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C887A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboIr-0003Ky-VP
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHu-0001bi-JE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHt-0006T4-IM
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:18 -0400
Received: by mail-qk1-x742.google.com with SMTP id i5so7786049qkl.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bON7YUxlhwgscX2SUVnZ4d6zlp9keY1L8USoWVcvoFg=;
 b=kZidtQ0XENdeengyKKW4whn3w3BbFo8YAwMqvx5iCkzwRhHySJ6WNbeEEBV9SLiM4p
 3dY/l1Ix/L/OzICp0SH2GNfc0SNqx9sQqfAIEskmmRYjLuhpIw9LaoRzKzT+ND8r/n2k
 Guf3KKhTPDlCkaJOq/7rjUWwnCocoDCYuJ8NKvXwzftHxSmJ3V83qqtQ59xC8B+Haf7s
 3DRP1EyOLMI9cm7883IuuRcxAqtVgxZWQU4YEJ7u7EO//cS3LKnxFMOr+9QX60/wSC5m
 h9TUbFzLloi9gzijPehgfrd385Ztj298vJn/RuNZhgRV9l9J2G9Jc5a8hrk1WAygY6Wf
 DNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bON7YUxlhwgscX2SUVnZ4d6zlp9keY1L8USoWVcvoFg=;
 b=Bh2mZbArXLa2ypSOe3RXVkDSf6wgfBLpG7eNxyH7gKYy9bspvYob96cKxBO5pk4g7N
 dzdPCN4U1sj8e9lSpQ1LyUmLUqbBL5aem4sMzdbr1Fp2yTgastzUpmGCwtJz6T/pPxWN
 LsIeKyg5T2mH5YCMyIIRVfx11Za+kNPMss3aOvN7bVtZzuZugYwscaraUUH9fPk9pus0
 feffF9gbjSNlTNaDv9zXBolYt3IpT+RpUlVgvXYuliZ53B8wrDxnxnnCwincd/wDyoKQ
 5FYrQHW/nEpq5wyGWaQ7yzQ7SlFDIJaJnciqUU15r5yvVDwBC7B8T2AjaF+iCRIHMBvD
 BD6A==
X-Gm-Message-State: AOAM533p8wdi2n+CH1joqmqr9GY0jK8t1KZbt/Njyq97sFmeqJCxZ0rJ
 s7QMF7sbz3d+8FCBmz/VrBaQ7FTgbSuKMA==
X-Google-Smtp-Source: ABdhPJyWocePND1w9eVhDHgqmbLFLBR00tujlFaGNijLepzgdvSHnUAK8NBlHiP2m3pkSiJpo4t2aA==
X-Received: by 2002:a37:f517:: with SMTP id l23mr10957493qkk.475.1590079396278; 
 Thu, 21 May 2020 09:43:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/74] cpu: rename cpu->work_mutex to cpu->lock
Date: Thu, 21 May 2020 12:38:59 -0400
Message-Id: <20200521164011.638-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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

This lock will soon protect more fields of the struct. Give
it a more appropriate name.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 14 +++++++-------
 cpus.c                |  4 ++--
 hw/core/cpu.c         |  4 ++--
 include/hw/core/cpu.h |  6 ++++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 210fc7fc39..34025923e3 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -105,10 +105,10 @@ struct qemu_work_item {
 
 static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 {
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
 
     qemu_cpu_kick(cpu);
 }
@@ -300,15 +300,15 @@ void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -324,13 +324,13 @@ void process_queued_cpu_work(CPUState *cpu)
         } else {
             wi->func(cpu, wi->data);
         }
-        qemu_mutex_lock(&cpu->work_mutex);
+        qemu_mutex_lock(&cpu->lock);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&qemu_work_cond);
 }
diff --git a/cpus.c b/cpus.c
index af44027549..77a2d7b7cf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -101,9 +101,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     return ret;
 }
 
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 77703d62b7..4d58399cfc 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -367,7 +367,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->work_mutex);
+    qemu_mutex_init(&cpu->lock);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
@@ -379,7 +379,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
-    qemu_mutex_destroy(&cpu->work_mutex);
+    qemu_mutex_destroy(&cpu->lock);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d78ff1d165..873bf23a39 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -331,7 +331,8 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
- * @work_mutex: Lock to prevent multiple access to @work_list.
+ * @lock: Lock to prevent multiple access to per-CPU fields. Must be acquired
+ *        after the BQL.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -375,7 +376,8 @@ struct CPUState {
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
-    QemuMutex work_mutex;
+    QemuMutex lock;
+    /* fields below protected by @lock */
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
-- 
2.17.1


