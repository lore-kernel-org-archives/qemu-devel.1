Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1805D2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/cNR2lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1805D2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfWb-0002bd-Aq
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE9-0003I3-8j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:09 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:43608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE5-0008Vc-2z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:08 -0400
Received: by mail-qv1-xf43.google.com with SMTP id dp10so1742987qvb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sbez58I4EiEfgiO/NYT9T3e4CNH+JdYMM0H0+QygWQ0=;
 b=r/cNR2lkier1zsQCfbqN+DznF2rDQqhEHqzWL8z3/6fRWGjh5S98S3sIqQB1jGRRxn
 jr66U4ove8He3107YfX8oGCerP7Q7KVb2Jqp5mgQ9cyEZnV3P5ezICRtEDTXVDkkgSzf
 69WJvV+RVzFIjuqPxQ7yIVL4LcHulHZixEBPMF+CwLRbWrtI1MsO2df33qT0jHenJEd4
 Duxo6v51uLzJgcqhijwqPoMddz/aVJtpaDpy3cFgkREkpZwHBToM9f3DKlv9v8IsfJHa
 741NG9taUGI5akF6ktd1OR9CaOJJ43wwGOUJhTZIR1nTy86r6nR6QsoFRTjEJSn/9ne9
 S7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sbez58I4EiEfgiO/NYT9T3e4CNH+JdYMM0H0+QygWQ0=;
 b=okRmljyn+swDJzvevu85T8SZaJYsbAPH5eRZ1zThDlCRjE4p9p+mmypPGyf/piDCN9
 Ix3Iaru2p8iaizswKxOd3PnvKwWAzuZsBzy8PYxpQQBrA4wIZ1oTPPcaqOEWQjvOkyvT
 EAh349HaXEX5OX850VVLe2ax5wC4eUjm1e74qZUOY2mXk+OTu+36Ic9zGpWR/2xG90fi
 jo9Cucbcn/5qqYvO+xKOXtLSerUDVJN1+6nKSqQJDzA6EdvmAF5aHqC9kATWz9IfeErf
 ii7AXb08p4eLbaKbrvTeS/3/bJ8q5TvTZ82LCpmSmouclsxZtuExy6SRzQTbb1WLge8r
 6fwg==
X-Gm-Message-State: AOAM533ZRLpE+/jf21gwkKvuBXmqVZ6me0EmGWU513PEzHgLZ9QPqfWO
 6oxUiL6WeWNDEUiKyC742Z5WWd2gC15/3A==
X-Google-Smtp-Source: ABdhPJxf/Fia+TxyAytQCRWEJI2MUmt8v+j8/rMBqU5C1YznoiI6qJaYCQq7Z0rs7mF+vn9f8iYtGA==
X-Received: by 2002:a05:6214:1842:: with SMTP id
 d2mr535702qvy.197.1592427841007; 
 Wed, 17 Jun 2020 14:04:01 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:00 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 31/73] cpu: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:49 -0400
Message-Id: <20200617210231.4393-32-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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

This finishes the conversion to cpu_halted.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c       | 2 +-
 cpus.c                     | 4 ++--
 hw/core/cpu.c              | 2 +-
 hw/core/machine-qmp-cmds.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e296894ea1..099dd83ee0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -435,7 +435,7 @@ static inline bool cpu_handle_halt_locked(CPUState *cpu)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
 
-            /* prevent deadlock; cpu_mutex must be acquired _after_ the BQL */
+            /* locking order: cpu_mutex must be acquired _after_ the BQL */
             cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
             cpu_mutex_lock(cpu);
diff --git a/cpus.c b/cpus.c
index 8edc9858d6..e070bffbff 100644
--- a/cpus.c
+++ b/cpus.c
@@ -223,7 +223,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     if (cpu_is_stopped(cpu)) {
         return true;
     }
-    if (!cpu->halted || cpu_has_work(cpu) ||
+    if (!cpu_halted(cpu) || cpu_has_work(cpu) ||
         kvm_halt_in_kernel()) {
         return false;
     }
@@ -1865,7 +1865,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 1d2cafe76c..64a1bf3e92 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -259,7 +259,7 @@ static void cpu_common_reset(DeviceState *dev)
     }
 
     cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 2c5da8413d..a35559b5d8 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -62,7 +62,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info->value = g_malloc0(sizeof(*info->value));
         info->value->CPU = cpu->cpu_index;
         info->value->current = (cpu == first_cpu);
-        info->value->halted = cpu->halted;
+        info->value->halted = cpu_halted(cpu);
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
 #if defined(TARGET_I386)
-- 
2.17.1


