Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F2BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D018C21532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUm9OP/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D018C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfFJ-0004UD-2J
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDO-0002bL-KJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:22 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDJ-0008OM-A1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:22 -0400
Received: by mail-qk1-x742.google.com with SMTP id 205so3517535qkg.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dhx8kBlipihHAeKCJXfkKKAuD+dwgXnNkcughiZZtFw=;
 b=ZUm9OP/ppA5whu7a9OgxbPtF42XrPrAo3DlE/0Oi8XdHuGRkCj8ljfQu4IZ+PPMZMx
 3SxjAS6qfhPkLmupKJY2PDyYcrZ4hiHz7DgeJEN0v96tLPAWs5SOT3tDE73CHfHAdbVX
 vGa4A+z+Z4UktE/zkKvJpPgN5+pc0dfddvQ2CuakTgZdfACZyl7VHlyZvRGjEkH/ModE
 sJ1TSSi5lA09LkKMVhqPO3KaIUzW3TqArcjbwD1DB+uGvBKowxJBDTqKoUxWzMj1jyF1
 0zrSrdLyE7JfcAHg6f5DtlFb363BiXBJ9dnc2/GaAL2Cy0Ktrg0Pkpa/hUJbuQo/H+Kw
 I/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dhx8kBlipihHAeKCJXfkKKAuD+dwgXnNkcughiZZtFw=;
 b=ixTWwtW6QqgbzBtqDffgnF2yFjTcLeXvF2y+CZKTlwyf2Pf6bey7KB85afhNrWMPFR
 z4J3eJoKDLkCTydK0e3O7WMtn7huoyjh9NjKCidgtrl/ZncYn7CbsdxNLNC1MYSeT7sH
 YZXGMedM3b2XCbjNjUUhHNqBQbYS/hQben32mSUb7JZUhqEuAJmenPOW2/WncJFCzxi8
 URANrZOSbTw9NDWIrVenz4CLzl1WCVHSkObTP1L8//qoma2790wz1uaDIa78crZK4WBc
 qLk19LzqyyP37zoTGKRBqbUOq7eUMG5uQiIvd/XsWj6l3ijFn+/FYlF7CI2SwDMjigmF
 /Fmw==
X-Gm-Message-State: AOAM530bzCxr4F5JavuoOvLBt5AEQu2WMPdvAtvfoY+DVxnd8tYaKKuJ
 bPRWRKm1v9TJ3uuGHIGGnN9NxOv/GsnUxg==
X-Google-Smtp-Source: ABdhPJxc/8ec9dUq51782MJ5+QI5GVOXnnEBtuHcz9MJ3sIgaS9ONS86do7WVTT9iYw9gFmjR4KSyA==
X-Received: by 2002:a05:620a:164c:: with SMTP id
 c12mr500828qko.343.1592427796072; 
 Wed, 17 Jun 2020 14:03:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 01/73] cpu: rename cpu->work_mutex to cpu->lock
Date: Wed, 17 Jun 2020 17:01:19 -0400
Message-Id: <20200617210231.4393-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
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
index 8f5512b3d7..622430bd33 100644
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
index 7317ae06b9..3c011ec452 100644
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
index 0f23409f1d..1cba5b6e69 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -369,7 +369,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->work_mutex);
+    qemu_mutex_init(&cpu->lock);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
@@ -381,7 +381,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
-    qemu_mutex_destroy(&cpu->work_mutex);
+    qemu_mutex_destroy(&cpu->lock);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b79318..afc8081ca8 100644
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


