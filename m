Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6EC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675E1206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiD0qyl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675E1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8DQ-0005zP-DE
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT8CZ-0005XG-2x
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT8CX-0004OK-DU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:37:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT8CW-0004Mi-67
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:37:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w9so1180644wrr.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tb8H/njHRKD1HGh1N99F8PbJi1PHgBNlROdkNZttnd4=;
 b=KiD0qyl6JDyf7KBn3pyaNOWvbe7USW1rS7W8qVvdCEC+xbi2p72QzZ4YhaS3ylbGa6
 mHyWLVkyiZDcCrLQLIlwJ+E5J7YqhIx5y6uWa8E3ZZ6eOMMQyHm59S2vCGS6axCNFzPh
 mySLEIYFt4iJ20yoFyEPHXU1qDy03sHb1qlTR8tIKVkqwunRD+TI069TY+HynGxVmufa
 Khz7CoK404/nZ71B3VILhvx8o+aROv138N0Sr01Dadp4qYgYCMCLPLGtAAfCKbbsw40t
 sVZEc8GVow2XlqraYyeAgfBUTmEffB8PTMupbCDdSartrqoxvfmEGNb+UrvcLgFVi47C
 2mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tb8H/njHRKD1HGh1N99F8PbJi1PHgBNlROdkNZttnd4=;
 b=Gi8usxGUgFCmMzb6Oj1EjhUEAyM/Pu00OwJt2Sfp4Gyl+jfZmEEnlkPUSvcLzuKlOf
 Oms6zCC44cBiGgRxig8754TSVGO+1ueZ5Fok3IVeu8otRGObiZMFgcNmdFqkCaKDY9uY
 RDzFgIxjL9aBXR4JAV9plfBq5cYok7PJxHBrsu9tq0dXKxCsPrdTf02qsI3pePTsiUx+
 oM1O/1YRVKKK/fecUItt/UQ+PzSYOIJRruCz6/0Y9cpIBF1nf0sdIfMDRyxXkJAg92Dq
 AAN6DhbeKc3wuWcZEMhfuS4ONIc2tnWXdiUTQbV9GFUPuZa2+5GZXKg4D2AkfrLQyr2T
 +y0A==
X-Gm-Message-State: APjAAAVrYbanWHDv4TFgi5qobdIZIUS4hrI3YNWPAO4GPQrrjjaVz4pq
 VOERiDEwlCgK+flxNEM2dYUJ2HN+HKFYow==
X-Google-Smtp-Source: APXvYqww4jP8OUTv7R3iW8ac+G6KWgeQ0hvphMJdwyVA7Kkw1EIajOCYRzMprdARwt25KuY9hrJ01w==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr10263049wrm.279.1573234654558; 
 Fri, 08 Nov 2019 09:37:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a6sm5260305wmj.1.2019.11.08.09.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 09:37:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for-4.2] Remove unassigned_access CPU hook
Date: Fri,  8 Nov 2019 17:37:32 +0000
Message-Id: <20191108173732.11816-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All targets have now migrated away from the old unassigned_access
hook to the new do_transaction_failed hook. This means we can remove
the core-code infrastructure for that hook and the code that calls it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
Just rebased on current master to fix some minor textual
conflicts. I'd like to get this in 4.2 (even though strictly
it's not a bugfix) because then we won't risk having any
new code introduced which uses the old hook. (v1 was on
the list back in September, but we were waiting for the
last user of the old hook to get fixed.)

 include/hw/core/cpu.h | 24 ------------------------
 accel/tcg/cputlb.c    |  2 --
 memory.c              |  7 -------
 3 files changed, 33 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e1c383ba846..77c6f052990 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -72,10 +72,6 @@ typedef enum MMUAccessType {
 
 typedef struct CPUWatchpoint CPUWatchpoint;
 
-typedef void (*CPUUnassignedAccess)(CPUState *cpu, hwaddr addr,
-                                    bool is_write, bool is_exec, int opaque,
-                                    unsigned size);
-
 struct TranslationBlock;
 
 /**
@@ -87,8 +83,6 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
  * @do_interrupt: Callback for interrupt handling.
- * @do_unassigned_access: Callback for unassigned access handling.
- * (this is deprecated: new targets should use do_transaction_failed instead)
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
  * @do_transaction_failed: Callback for handling failed memory transactions
@@ -175,7 +169,6 @@ typedef struct CPUClass {
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
-    CPUUnassignedAccess do_unassigned_access;
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr);
@@ -415,12 +408,6 @@ struct CPUState {
      * we store some rarely used information in the CPU context.
      */
     uintptr_t mem_io_pc;
-    /*
-     * This is only needed for the legacy cpu_unassigned_access() hook;
-     * when all targets using it have been converted to use
-     * cpu_transaction_failed() instead it can be removed.
-     */
-    MMUAccessType mem_io_access_type;
 
     int kvm_fd;
     struct KVMState *kvm_state;
@@ -896,17 +883,6 @@ void cpu_interrupt(CPUState *cpu, int mask);
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
-static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                         bool is_write, bool is_exec,
-                                         int opaque, unsigned size)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->do_unassigned_access) {
-        cc->do_unassigned_access(cpu, addr, is_write, is_exec, opaque, size);
-    }
-}
-
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                         MMUAccessType access_type,
                                         int mmu_idx, uintptr_t retaddr)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 68487dceb54..98221948d63 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -931,8 +931,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         cpu_io_recompile(cpu, retaddr);
     }
 
-    cpu->mem_io_access_type = access_type;
-
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
diff --git a/memory.c b/memory.c
index c952eabb5d2..06484c2bff2 100644
--- a/memory.c
+++ b/memory.c
@@ -1257,10 +1257,6 @@ static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
 #endif
-    if (current_cpu != NULL) {
-        bool is_exec = current_cpu->mem_io_access_type == MMU_INST_FETCH;
-        cpu_unassigned_access(current_cpu, addr, false, is_exec, 0, size);
-    }
     return 0;
 }
 
@@ -1270,9 +1266,6 @@ static void unassigned_mem_write(void *opaque, hwaddr addr,
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem write " TARGET_FMT_plx " = 0x%"PRIx64"\n", addr, val);
 #endif
-    if (current_cpu != NULL) {
-        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
-    }
 }
 
 static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
-- 
2.20.1


