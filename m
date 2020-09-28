Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A3C4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9D6208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Khkhq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9D6208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwmH-0005sY-My
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkg-0004B1-TQ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwka-0006KO-RW
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id k10so2212262wru.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tEiQnyrePNI+SA5QcWB5N9e6IHcTd69FaWZKVkP2uZM=;
 b=R+Khkhq6C3muXCn8UA/xx8ZuX0GdytX17BoZpEA83SH+ZrjpJ36yP61wvjIYhFA6WE
 cyHo94UlCKVPD1WuBBXQwhA5N6ez3uzah64J+ncpM8+FSRvnVtGu07dPsU1QyH+JT9FU
 ddNIgX1bZmAQHoiEFEB8SpYEOoxTuDbfOAKNeek8wUPXzjcaPUtkKVNudNBA2UwOqpz8
 nJWRurXXF1DDy5uhrN/K6OAltTuLfsRI/7q+pzCgjTTGHjnDTlfuaqttmXJOhVBWVW3e
 lWOLe600k6960nqcgAGb+tbY0yVxRRujLMB/U73mG3VjUbL0PueyEpLsv/K1KGiHMwB7
 IAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tEiQnyrePNI+SA5QcWB5N9e6IHcTd69FaWZKVkP2uZM=;
 b=AC7IeB2Z4imZ2G7X+dldEfhqz8/o8boVKW5rzWqMDChddSA/diaUxJtHmK2dlfhiHU
 V/rRddU05t7kY6PUpEa6nhFb6BUYLRNihGszLpaHTMuafA51feSzYNkRdMPicb4NS7ww
 M2X5WukOCJLayVMCWfrIKdKgNRJJG2wbmqIMQZ1TKjTevnMCcIW/P7O9+/DxOPGWWcbt
 fZUzHyFZ2R62DX5jOQ3bC1ucnbStr/pB+lAamPr8glu/izecYFhScmjaDlqgfF+mivfQ
 iec8F91jDklm/O5enKvc07JuJuzWucW+I+aJg8WdEh+byK8v+LqKei4o4fdTzsUNW8bX
 4uLw==
X-Gm-Message-State: AOAM530iGS8Uj50VdO5qrIOlLrUzlS/ouYyejzpaydhlYjaQ6i35e9Eo
 20+EBHR2SpYYFHcAiINdw+fajiUZmH4=
X-Google-Smtp-Source: ABdhPJz8H+WYfCEcF040REWDSx5gl2HXfOX3SOuwGT5J909C4q0wNdhCusE7/uXn0b8x34T4rf0dpg==
X-Received: by 2002:adf:d089:: with SMTP id y9mr2705178wrh.234.1601313343215; 
 Mon, 28 Sep 2020 10:15:43 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] hw/core/cpu: Let CPU object have a clock source
Date: Mon, 28 Sep 2020 19:15:24 +0200
Message-Id: <20200928171539.788309-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let CPUState have a clock source (named 'clk') and CPUClass
have a clock_update() callback. The clock can be optionally
set Using qdev_connect_clock_in() from the Clock API.
If the clock changes, the optional clock_update() will be
called.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/core/cpu.h |  5 +++++
 hw/core/cpu.c         | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6c34798c8b3..6989d90c193 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
 #include "qom/object.h"
+#include "hw/clock.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
                                      void *opaque);
@@ -155,6 +156,7 @@ struct TranslationBlock;
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
+ * @clock_update: Callback for input clock changes
  *
  * Represents a CPU family or model.
  */
@@ -176,6 +178,7 @@ struct CPUClass {
                                   unsigned size, MMUAccessType access_type,
                                   int mmu_idx, MemTxAttrs attrs,
                                   MemTxResult response, uintptr_t retaddr);
+    void (*clock_update)(CPUState *cpu);
     bool (*virtio_is_big_endian)(CPUState *cpu);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
@@ -316,6 +319,7 @@ struct qemu_work_item;
  *   QOM parent.
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
+ * @clock: this CPU source clock (an output clock of another device)
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
@@ -400,6 +404,7 @@ struct CPUState {
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
+    Clock *clock;
 
     void *env_ptr; /* CPUArchState */
     IcountDecr *icount_decr_ptr;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index c55c09f734c..37fcff3ec64 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -30,6 +30,7 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "trace/trace-root.h"
 #include "qemu/plugin.h"
@@ -247,6 +248,16 @@ void cpu_reset(CPUState *cpu)
     trace_guest_cpu_reset(cpu);
 }
 
+static void cpu_clk_update(void *opaque)
+{
+    CPUState *cpu = opaque;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->clock_update) {
+        cc->clock_update(cpu);
+    }
+}
+
 static void cpu_common_reset(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
@@ -367,6 +378,7 @@ static void cpu_common_initfn(Object *obj)
     /* the default value is changed by qemu_init_vcpu() for softmmu */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
+    cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk", cpu_clk_update, cpu);
 
     qemu_mutex_init(&cpu->work_mutex);
     QSIMPLEQ_INIT(&cpu->work_list);
-- 
2.26.2


