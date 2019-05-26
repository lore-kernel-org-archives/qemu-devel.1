Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341EC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CDE20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CDE20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiAI-0006nY-Jv
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:41:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxG-0003Hg-Ud
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgF-0006OX-BW
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgF-0006Nt-5H
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so7500594pfg.6
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=bfzh+MZSvmEZNQxWgTa76qcItrVzLJNNgdvUdoTR8cc=;
	b=lUfWSWT0pcUe5wz4y9IjovmOajQ4BommYwtL+7hoyMix2omaAXNRT5RWJbsbQ+RhQW
	dUGe2Sek/21ueVCVZrr+bUZ0vqnENuWnhR+ZrKPfPrZX/m168n0pFonlhVjthLoj0ZdZ
	bhLH7EAgZ1i3W6VCe/hlKaSYdZEGKAda/pnh6DfR7iLZu3SdmgBdvms0V7ODkcSYGIHQ
	tQ/tmE1kAFZjinbu3LmzZ2eyyRenn9ijJYC2/OMKSTIgeUm9Ut9vV7d/Ba4SyJq6zdPm
	Zq8itMZhbB1qOWDuPQEjXXxcwmSL9VO96NBE7V9DKNK8JX2hzvpfgmHxCg7mX38W/yo3
	xymQ==
X-Gm-Message-State: APjAAAVytW4ZSyDhnlMKzTwFUEZ1hgEQf2105LqE0x5/fzaDp7eW/0eS
	QzYC8gPODkESufEJLlnBjtGc/Q==
X-Google-Smtp-Source: APXvYqyFAmvr2ZnxR9RzHhk9CKgWsvCJCzeJzqr7CJHHs223C6ARSyjNDqf8d8d6nWvjRBXzFjWC2g==
X-Received: by 2002:a62:5e06:: with SMTP id s6mr65039168pfb.193.1558833029855; 
	Sat, 25 May 2019 18:10:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id n9sm6879354pfq.53.2019.05.25.18.10.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:29 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:39 -0700
Message-Id: <20190526010948.3923-21-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.195
Subject: [Qemu-devel] [PULL 20/29] target/riscv: Trigger interrupt on MIP
 update asynchronously
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

The requirement of holding the iothread_mutex is burdersome when
swapping the background and foreground registers in the Hypervisor
extension. To avoid the requrirement let's set the interrupt
asynchronously.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 33 +++++++++++++++++++++++++++------
 target/riscv/csr.c        |  2 --
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 41d6db41c3dd..7318da289f6e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,10 +82,31 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
     }
 }
 
-/* iothread_mutex must be held */
+struct CpuAsyncInfo {
+    uint32_t new_mip;
+};
+
+static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
+                                            run_on_cpu_data data)
+{
+    CPURISCVState *env = &RISCV_CPU(target_cpu_state)->env;
+    RISCVCPU *cpu = riscv_env_get_cpu(env);
+    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
+
+    if (info->new_mip) {
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    }
+
+    g_free(info);
+}
+
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
 {
     CPURISCVState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    struct CpuAsyncInfo *info;
     uint32_t old, new, cmp = atomic_read(&env->mip);
 
     do {
@@ -94,11 +115,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
         cmp = atomic_cmpxchg(&env->mip, old, new);
     } while (old != cmp);
 
-    if (new) {
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    }
+    info = g_new(struct CpuAsyncInfo, 1);
+    info->new_mip = new;
+
+    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
+                     RUN_ON_CPU_HOST_PTR(info));
 
     return old;
 }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1d91b6c6049..f9d8d150e012 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -555,9 +555,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
     uint32_t old_mip;
 
     if (mask) {
-        qemu_mutex_lock_iothread();
         old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
-        qemu_mutex_unlock_iothread();
     } else {
         old_mip = atomic_read(&env->mip);
     }
-- 
2.21.0


