Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94841C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED2720826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymGxfTzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED2720826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboXN-0007MX-Gd
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIZ-0003HF-Lu
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:59 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIY-0006ZZ-Kc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:59 -0400
Received: by mail-qk1-x741.google.com with SMTP id z80so7918616qka.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=84L+h8uFg3q7QdwSmv1gXpJhNAJlpTSMoYkmOBESzcw=;
 b=ymGxfTzdloXlZM0VfvEF0nI3toXOk1Lfcuzt/jMz2NpgokHLp7j2pSJB9HLhwIlYzy
 kiVNe9R9XnktkyHSHtS0KrXo9eEAprSSbRb7ywhFj9A2/U4qlQMwQr9XJMOJPbL6cT8g
 4EmwaWh7VQ2ANO7A6DhlR0WfulX0UuoyzkxMyNmg7xLBSFzaSO0W2eYiSnLXNCwdbC92
 d1Y422hGnTX//BJZRqUtoIcc9pR+qJn4lED1N3aTaxF01akF2ISTMadlSlyLiWmNBTnh
 H8J4bmXZq90zsJexYTo6ZHtybNVn/F3Cd0Evcu6zKSEl2QkIXow/zjjoTd2RRcOyq0tH
 vq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=84L+h8uFg3q7QdwSmv1gXpJhNAJlpTSMoYkmOBESzcw=;
 b=oquKxzqkmCKCQ12RDd4uuy30fhgLWP0jKqtnCi042wmuGK2X1lecvbblkN9r4KRA7f
 jnUr3ZmKMabflSQUu0RCv9yjJe9YVkpckpEKolDo1MsT90EPec8GR2/P0UPnjC4vOpjT
 OHCEsDBpWzIaE9zL5hRg3c2B/qZ8lakFRUmw1ZHU3JUkIYRlbbgeAwsWyJyQoCIm1y2j
 Nf2qlutOTD5ASN9WU3JHzQUqnfCcKsLeVJXuIKgINRQqJNnYurdpI4RFoWE3q6VcwlJ4
 gF9NJfiC01HS0cs+Np51a4XuVtcXgxwKUYbWb8gDFzhIhkxeuPvc7EovuqIVKhWsxkQX
 h1sg==
X-Gm-Message-State: AOAM533qWqd//0rF25jY2qTwTHA6XWn95SzvmkL6hj+QQbNDXLUVnuiF
 ve425rgfRZb5leuh/VG1F8tnC/wRZSdaoQ==
X-Google-Smtp-Source: ABdhPJzDBclugsiMHZuoxNfn75c6deQK9foRsA5qT/IBLEIroFZlSfTD92Lyvdamd9ZiVGJCh+KBfA==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr1797829qkg.393.1590079437539; 
 Thu, 21 May 2020 09:43:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 32/74] cpu: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:29 -0400
Message-Id: <20200521164011.638-33-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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
index 9cc5f4767e..ff67fa9f5f 100644
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
@@ -1845,7 +1845,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 620feed3e9..67a9c2bb16 100644
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


