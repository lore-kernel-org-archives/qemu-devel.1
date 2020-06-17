Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E72C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6725D206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9e2iGt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6725D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfid-0004Dl-Dq
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfF2-0004ns-Rv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:05 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:42314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEz-0000Qm-JY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:04 -0400
Received: by mail-qv1-xf41.google.com with SMTP id p15so1751615qvr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mMSK5jG93ccRv0iEW+yiTm1N/o9bSTPpnWnCySDcIBA=;
 b=l9e2iGt6X9bkA7GiikT3IzyDF6HuI1DQNYrztcTjfl8hAnrUokmdoS8PMcQrkKIeGi
 i2IydSAEhYYwj/gw+8kng65TMrgpptccie9kfRrkNpJoJJsIAG7Brc5J43IvQcqv+4wc
 sTvV2gKAKN1ujjKiyRmaPZqFuOdUqTPMQFFBsqh93Ep91TrKKvZWkPDfrUr3oIq5Ae7H
 ynlk5QG4s4RGMZZpg3fWGGqcMbCY2qRWXVuo0k2m7RHRvapYoFTSMkC1R0z2ve9YiNr+
 XQyrCXHy6LBJL6EuDBEeTybBZiaVUPCoMjIXrDvdE+vj4lERk1t1xyT2duLOklQ4oCt5
 KAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mMSK5jG93ccRv0iEW+yiTm1N/o9bSTPpnWnCySDcIBA=;
 b=YpLrGFpnacXPWzgGq5gZUQTYNW+XEriamxf22/N8xzd5T5x/VdCVg34rER9aZwAEK9
 vQuHnhUeKn8enesw9VIt5daMlEY9NHjVJw/QIsWNSQ+CtlDWcsPmSCg+0RiPcDFyy8fN
 v9y5yGV1DaTRD5WYdcgvl66F/wbhAmScJwJ0d0sWlXn2MkRLZmHIqhGWUBCVQ5fR9iaQ
 +lBNRM9J797RYmjEskNvch2CiVQS5FGRaAlosUNZGzN1MHJH0uV4hL8+cr9QGqH4TVFl
 LNtbVIsBKFmpbNVPE+81m2VBZqUIe0ZDEnf+93vTIxF/QrGGTiaoKVhj7kjcoZiXJ0Ck
 Lgyw==
X-Gm-Message-State: AOAM532brwhKB05+o+zcP+hFdKUOASXiyrix5fVMnxW4eIL3vVXLnSrg
 Kl3tdjmSDt3f92MCG0bFF3J2Hei/Dqk8rA==
X-Google-Smtp-Source: ABdhPJxTQJNn6gVu0kYsPjcH5hefyPmvER9VyoPxwhgIlAjoVhLUNN6NskyInwv3AeCf0UwKDrbVhw==
X-Received: by 2002:a0c:9ba0:: with SMTP id o32mr553544qve.129.1592427899987; 
 Wed, 17 Jun 2020 14:04:59 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:58 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 72/73] cpu: add async_run_on_cpu_no_bql
Date: Wed, 17 Jun 2020 17:02:30 -0400
Message-Id: <20200617210231.4393-73-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some async jobs do not need the BQL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 39 ++++++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index eecd63029a..923371a997 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -99,6 +99,7 @@ struct qemu_work_item {
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
+    bool bql;
 };
 
 /* Called with the CPU's lock held */
@@ -145,6 +146,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
+    wi.bql = true;
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
@@ -169,6 +171,21 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi->func = func;
     wi->data = data;
     wi->free = true;
+    wi->bql = true;
+
+    queue_work_on_cpu(cpu, wi);
+}
+
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data)
+{
+    struct qemu_work_item *wi;
+
+    wi = g_malloc0(sizeof(struct qemu_work_item));
+    wi->func = func;
+    wi->data = data;
+    wi->free = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -315,6 +332,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     wi->data = data;
     wi->free = true;
     wi->exclusive = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -339,6 +357,7 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
+            g_assert(!wi->bql);
             if (has_bql) {
                 qemu_mutex_unlock_iothread();
             }
@@ -349,12 +368,22 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
                 qemu_mutex_lock_iothread();
             }
         } else {
-            if (has_bql) {
-                wi->func(cpu, wi->data);
+            if (wi->bql) {
+                if (has_bql) {
+                    wi->func(cpu, wi->data);
+                } else {
+                    qemu_mutex_lock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_unlock_iothread();
+                }
             } else {
-                qemu_mutex_lock_iothread();
-                wi->func(cpu, wi->data);
-                qemu_mutex_unlock_iothread();
+                if (has_bql) {
+                    qemu_mutex_unlock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_lock_iothread();
+                } else {
+                    wi->func(cpu, wi->data);
+                }
             }
         }
         cpu_mutex_lock(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d5e4c339e1..e37f64b57a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -894,9 +894,23 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
  * @data: Data to pass to the function.
  *
  * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * See also: async_run_on_cpu_no_bql()
  */
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * async_run_on_cpu_no_bql:
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * This function is run outside the BQL.
+ * See also: async_run_on_cpu()
+ */
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data);
+
 /**
  * async_safe_run_on_cpu:
  * @cpu: The vCPU to run on.
-- 
2.17.1


