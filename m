Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9704C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763DC206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCvQhIfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763DC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYUM-00005S-Kg
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKa-00079U-Jh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKZ-0001ip-7s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:20 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKY-0001iN-Py
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:18 -0400
Received: by mail-qk1-x744.google.com with SMTP id l25so8186115qki.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lqZ7VnMREamwmHiAXruvzR+fgaqzM3eON98Z9dE0b+o=;
 b=UCvQhIfUcPfh/PFnN4XvCTeZTf8m35iJfoFlILVkw85cSuOWp1bX55OxF7Qa2C9rD2
 o4sPh7aO0KP0WF7EV+TQFEkPwJ53WValgNUr4CPMX4sTCXI/Lc9E0sstPekWkploUyay
 LubC8DjMhNheMrdAhEICkW71sUY/ijsdz9xlJ9ufcK4EXGBdM/UdI9ly0KHdCuCia5w6
 4Rlj+6MZ6K9L2sDdIkis6JKrMyB5h7CZThb3Y+Q8U/tEabYfvv2z6H4SxtIfgO1BgXPO
 0eqj5+cRAIWQYsP7L/0ml+CTif9YECrmXaGtDzqg+FKtU1QtMWH6e+ti4uiskMpbsR51
 9o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lqZ7VnMREamwmHiAXruvzR+fgaqzM3eON98Z9dE0b+o=;
 b=OTlMslZQN6dUtCdY7bu3Sfbp+Bitkp3WzCkAzQIUCLLpmWz6Mir+ZKFYUfp4EiH0co
 NXtfXVyF9BKEOPVc9GpJGBiyRoBysU0r4FbO8d4dTiGF2S6jh+QLDZFRRnZ3sils6Mea
 eCm4+Uq2rdrzubmfVucuNC3PXkENXRqeqnuV7Y8/PK22V4xAQ2tRvP5lh5sHj+wcjWtJ
 qmpKxzb0v+lp4sKH/ufHSgI7p6VOB5fKDIDXbZDf8Wl3egkMEyYCM1TqYvCofCbbiALO
 igiwr7GEWIzhlh2nqpoIHzib8gx/8aTx/2bv22cLD3Svq4fAK98e2r5ewVpYS75nUXvs
 4kfQ==
X-Gm-Message-State: ANhLgQ2aulDQrqFUs8b9qi1DxzFG9mjCDRKGR7NQX6ue87wy12ODSxN+
 9AB6MXOEGvU4NMMwihDCe5EICJvr5TqG4A==
X-Google-Smtp-Source: ADFU+vvafTpxQQNmV1oSE1zmB/zCDIzSL+ybLW7X/XTF3UAOtbQHQXWmx7O75gX85803k5WhGWkadA==
X-Received: by 2002:a37:6357:: with SMTP id x84mr10357028qkb.490.1585251497714; 
 Thu, 26 Mar 2020 12:38:17 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:17 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 32/74] cpu: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:14 -0400
Message-Id: <20200326193156.4322-33-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
index f27fb19b7c..50ced4369f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -225,7 +225,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     if (cpu_is_stopped(cpu)) {
         return true;
     }
-    if (!cpu->halted || cpu_has_work(cpu) ||
+    if (!cpu_halted(cpu) || cpu_has_work(cpu) ||
         kvm_halt_in_kernel()) {
         return false;
     }
@@ -1840,7 +1840,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index d67bd58827..9683d6408a 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -257,7 +257,7 @@ static void cpu_common_reset(DeviceState *dev)
     }
 
     cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index eed5aeb2f7..7d33489110 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -58,7 +58,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
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


