Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CCC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC4920760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTPkd86p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC4920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhTz-0007Q0-8F
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ0-0002HY-AF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhPy-0001My-3U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id h7so8606507wre.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idFqZXx36LnOimhunbyC+weOV1rVwXuc0b22FJ7H8UY=;
 b=KTPkd86pruptfR1CUIdVJWEp20YqJNAJOLwaMC3EsUHO4QTFGLjtO6jyvG9paHy3A8
 GXeFnmvSvgdt6mOhN4cR3PjqX+iW0in3y3J+cy//NUaRN4LzcwxX7p50SFFeh5a0LCoG
 LAWS5ixlLKWJiiCEQG1vt7zbJsdTdDicZ3SbuRYlSYLUSQRowpt/YAYEZEbjtZdPLTHb
 hcR950CU8qmATaD/BCUcti1DVh11Lk34IeDTP3FDA8k+9f0+xZmqf688HPb22tpprgdv
 r0X7l4IKcLQmhKbRkc0cBP9AY0VNFj9+9azZkdW8GkYZfHF52cjrkr5I8O10qrtuHjPz
 VT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=idFqZXx36LnOimhunbyC+weOV1rVwXuc0b22FJ7H8UY=;
 b=kdmCDgAVmYmAoxYt9iUxQOjEIq/U4K03REhChHU5TLBPGv+tXMVlx00g43fFC/O+U4
 bmwDK9mfAgAjZyGdusktT3Rfnhn8L1YAsBblBt48znYux0jTJPPo9bjW0dNMiOiP8Cz3
 t2ROUsdT1LkvymvDvp4++9vtuZc95sinxo8TdJXWnYV2RILEolu0KRGfQL3QmOXMz1Jy
 bZJXbSkrBb/GNGkJsUc77I3yPvA3KTB7rvi8WJVQExqMXeW6FpO7UY6MHUZALcnStOxy
 9YoC3GCFX6LRAjfD243j3Qvq6mpoUqo+XVc/Pizk5w2v6jItO5o3vSWgT97fYi/O3xli
 kKOw==
X-Gm-Message-State: AOAM533JdLqaddGx5MAvV/eyqNaGD/MujiJ3OlJpEcVgIS1cXSVB9CEr
 LVOWg9QD3yNiIZsYKY1vzHeGrQ7MKiM=
X-Google-Smtp-Source: ABdhPJwLXVQzHZ2gsMcmPfkvDTeQxwap2DpwsWLXvmbz59XpZXamShQLyRAHOjxMgxBkJMj6cchQ7w==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr3275346wrs.218.1601969387867; 
 Tue, 06 Oct 2020 00:29:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/37] icount: rename functions to be consistent with the
 module name
Date: Tue,  6 Oct 2020 09:29:12 +0200
Message-Id: <20201006072947.487729-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c        |  6 +++---
 docs/replay.txt             |  6 +++---
 include/sysemu/cpu-timers.h | 16 +++++++-------
 include/sysemu/replay.h     |  4 ++--
 replay/replay.c             |  2 +-
 softmmu/cpu-timers.c        |  6 +++---
 softmmu/cpus.c              |  6 +++---
 softmmu/icount.c            | 42 ++++++++++++++++++-------------------
 softmmu/vl.c                |  2 +-
 stubs/icount.c              | 16 +++++++-------
 target/arm/helper.c         |  4 ++--
 target/riscv/csr.c          |  4 ++--
 util/main-loop.c            |  2 +-
 util/qemu-timer.c           |  4 ++--
 14 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 35bfe2ca92..0dbe67acf5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -71,7 +71,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
     }
 
     cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
-    sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
+    sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
     if (sc->diff_clk > VM_CLOCK_ADVANCE) {
@@ -665,7 +665,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     assert(icount_enabled());
 #ifndef CONFIG_USER_ONLY
     /* Ensure global icount has gone forward */
-    cpu_update_icount(cpu);
+    icount_update(cpu);
     /* Refill decrementer and continue execution.  */
     insns_left = MIN(0xffff, cpu->icount_budget);
     cpu_neg(cpu)->icount_decr.u16.low = insns_left;
@@ -775,7 +775,7 @@ void dump_drift_info(void)
     }
 
     qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
-                (cpu_get_clock() - cpu_get_icount()) / SCALE_MS);
+                (cpu_get_clock() - icount_get()) / SCALE_MS);
     if (icount_align_option) {
         qemu_printf("Max guest delay     %"PRIi64" ms\n",
                     -max_delay / SCALE_MS);
diff --git a/docs/replay.txt b/docs/replay.txt
index 70c27edb36..8952e6d852 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -184,11 +184,11 @@ is then incremented (which is called "warping" the virtual clock) as
 soon as the timer fires or the CPUs need to go out of the idle state.
 Two functions are used for this purpose; because these actions change
 virtual machine state and must be deterministic, each of them creates a
-checkpoint.  qemu_start_warp_timer checks if the CPUs are idle and if so
-starts accounting real time to virtual clock.  qemu_account_warp_timer
+checkpoint.  icount_start_warp_timer checks if the CPUs are idle and if so
+starts accounting real time to virtual clock.  icount_account_warp_timer
 is called when the CPUs get an interrupt or when the warp timer fires,
 and it warps the virtual clock by the amount of real time that has passed
-since qemu_start_warp_timer.
+since icount_start_warp_timer.
 
 Bottom halves
 -------------
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index 4b621fea51..7726e005cd 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -35,30 +35,30 @@ extern int use_icount;
  * Update the icount with the executed instructions. Called by
  * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
  */
-void cpu_update_icount(CPUState *cpu);
+void icount_update(CPUState *cpu);
 
 /* get raw icount value */
-int64_t cpu_get_icount_raw(void);
+int64_t icount_get_raw(void);
 
 /* return the virtual CPU time in ns, based on the instruction counter. */
-int64_t cpu_get_icount(void);
+int64_t icount_get(void);
 /*
  * convert an instruction counter value to ns, based on the icount shift.
  * This shift is set as a fixed value with the icount "shift" option
  * (precise mode), or it is constantly approximated and corrected at
  * runtime in adaptive mode.
  */
-int64_t cpu_icount_to_ns(int64_t icount);
+int64_t icount_to_ns(int64_t icount);
 
 /* configure the icount options, including "shift" */
-void configure_icount(QemuOpts *opts, Error **errp);
+void icount_configure(QemuOpts *opts, Error **errp);
 
 /* used by tcg vcpu thread to calc icount budget */
-int64_t qemu_icount_round(int64_t count);
+int64_t icount_round(int64_t count);
 
 /* if the CPUs are idle, start accounting real time to virtual clock. */
-void qemu_start_warp_timer(void);
-void qemu_account_warp_timer(void);
+void icount_start_warp_timer(void);
+void icount_account_warp_timer(void);
 
 /*
  * CPU Ticks and Clock
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 5471bb514d..a140d69a73 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -109,12 +109,12 @@ int64_t replay_read_clock(ReplayClockKind kind);
 #define REPLAY_CLOCK(clock, value)                                      \
     (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
         : replay_mode == REPLAY_MODE_RECORD                             \
-            ? replay_save_clock((clock), (value), cpu_get_icount_raw()) \
+            ? replay_save_clock((clock), (value), icount_get_raw()) \
         : (value))
 #define REPLAY_CLOCK_LOCKED(clock, value)                               \
     (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
         : replay_mode == REPLAY_MODE_RECORD                             \
-            ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
+            ? replay_save_clock((clock), (value), icount_get_raw_locked()) \
         : (value))
 
 /* Processing data from random generators */
diff --git a/replay/replay.c b/replay/replay.c
index 7e4a1ba78e..4c1457b07e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -64,7 +64,7 @@ bool replay_next_event_is(int event)
 
 uint64_t replay_get_current_icount(void)
 {
-    return cpu_get_icount_raw();
+    return icount_get_raw();
 }
 
 int replay_get_instructions(void)
diff --git a/softmmu/cpu-timers.c b/softmmu/cpu-timers.c
index 6c6c56090f..7efec17fea 100644
--- a/softmmu/cpu-timers.c
+++ b/softmmu/cpu-timers.c
@@ -70,7 +70,7 @@ int64_t cpu_get_ticks(void)
     int64_t ticks;
 
     if (icount_enabled()) {
-        return cpu_get_icount();
+        return icount_get();
     }
 
     qemu_spin_lock(&timers_state.vm_clock_lock);
@@ -160,7 +160,7 @@ static bool adjust_timers_state_needed(void *opaque)
     return s->icount_rt_timer != NULL;
 }
 
-static bool shift_state_needed(void *opaque)
+static bool icount_shift_state_needed(void *opaque)
 {
     return icount_enabled() == 2;
 }
@@ -196,7 +196,7 @@ static const VMStateDescription icount_vmstate_shift = {
     .name = "timer/icount/shift",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = shift_state_needed,
+    .needed = icount_shift_state_needed,
     .fields = (VMStateField[]) {
         VMSTATE_INT16(icount_time_shift, TimersState),
         VMSTATE_END_OF_LIST()
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 4f2777a738..eeea495763 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -560,7 +560,7 @@ static int64_t tcg_get_icount_limit(void)
             deadline = INT32_MAX;
         }
 
-        return qemu_icount_round(deadline);
+        return icount_round(deadline);
     } else {
         return replay_get_instructions();
     }
@@ -615,7 +615,7 @@ static void process_icount_data(CPUState *cpu)
 {
     if (icount_enabled()) {
         /* Account for executed instructions */
-        cpu_update_icount(cpu);
+        icount_update(cpu);
 
         /* Reset the counters */
         cpu_neg(cpu)->icount_decr.u16.low = 0;
@@ -716,7 +716,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
         replay_mutex_lock();
         qemu_mutex_lock_iothread();
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
-        qemu_account_warp_timer();
+        icount_account_warp_timer();
 
         /* Run the timers here.  This is much more efficient than
          * waking up the I/O thread and waiting for completion.
diff --git a/softmmu/icount.c b/softmmu/icount.c
index 0b815fe88f..020a201a01 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -73,7 +73,7 @@ static void icount_enable_adaptive(void)
  * originally budgeted minus the current state of the decrementing
  * icount counters in extra/u16.low.
  */
-static int64_t cpu_get_icount_executed(CPUState *cpu)
+static int64_t icount_get_executed(CPUState *cpu)
 {
     return (cpu->icount_budget -
             (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
@@ -84,9 +84,9 @@ static int64_t cpu_get_icount_executed(CPUState *cpu)
  * account executed instructions. This is done by the TCG vCPU
  * thread so the main-loop can see time has moved forward.
  */
-static void cpu_update_icount_locked(CPUState *cpu)
+static void icount_update_locked(CPUState *cpu)
 {
-    int64_t executed = cpu_get_icount_executed(cpu);
+    int64_t executed = icount_get_executed(cpu);
     cpu->icount_budget -= executed;
 
     qatomic_set_i64(&timers_state.qemu_icount,
@@ -98,16 +98,16 @@ static void cpu_update_icount_locked(CPUState *cpu)
  * account executed instructions. This is done by the TCG vCPU
  * thread so the main-loop can see time has moved forward.
  */
-void cpu_update_icount(CPUState *cpu)
+void icount_update(CPUState *cpu)
 {
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
-    cpu_update_icount_locked(cpu);
+    icount_update_locked(cpu);
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                          &timers_state.vm_clock_lock);
 }
 
-static int64_t cpu_get_icount_raw_locked(void)
+static int64_t icount_get_raw_locked(void)
 {
     CPUState *cpu = current_cpu;
 
@@ -117,47 +117,47 @@ static int64_t cpu_get_icount_raw_locked(void)
             exit(1);
         }
         /* Take into account what has run */
-        cpu_update_icount_locked(cpu);
+        icount_update_locked(cpu);
     }
     /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
     return qatomic_read_i64(&timers_state.qemu_icount);
 }
 
-static int64_t cpu_get_icount_locked(void)
+static int64_t icount_get_locked(void)
 {
-    int64_t icount = cpu_get_icount_raw_locked();
+    int64_t icount = icount_get_raw_locked();
     return qatomic_read_i64(&timers_state.qemu_icount_bias) +
-        cpu_icount_to_ns(icount);
+        icount_to_ns(icount);
 }
 
-int64_t cpu_get_icount_raw(void)
+int64_t icount_get_raw(void)
 {
     int64_t icount;
     unsigned start;
 
     do {
         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = cpu_get_icount_raw_locked();
+        icount = icount_get_raw_locked();
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
 
     return icount;
 }
 
 /* Return the virtual CPU time, based on the instruction counter.  */
-int64_t cpu_get_icount(void)
+int64_t icount_get(void)
 {
     int64_t icount;
     unsigned start;
 
     do {
         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = cpu_get_icount_locked();
+        icount = icount_get_locked();
     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
 
     return icount;
 }
 
-int64_t cpu_icount_to_ns(int64_t icount)
+int64_t icount_to_ns(int64_t icount)
 {
     return icount << qatomic_read(&timers_state.icount_time_shift);
 }
@@ -188,7 +188,7 @@ static void icount_adjust(void)
                        &timers_state.vm_clock_lock);
     cur_time = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
                                    cpu_get_clock_locked());
-    cur_icount = cpu_get_icount_locked();
+    cur_icount = icount_get_locked();
 
     delta = cur_icount - cur_time;
     /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
@@ -229,7 +229,7 @@ static void icount_adjust_vm(void *opaque)
     icount_adjust();
 }
 
-int64_t qemu_icount_round(int64_t count)
+int64_t icount_round(int64_t count)
 {
     int shift = qatomic_read(&timers_state.icount_time_shift);
     return (count + (1 << shift) - 1) >> shift;
@@ -266,7 +266,7 @@ static void icount_warp_rt(void)
              * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
              * far ahead of real time.
              */
-            int64_t cur_icount = cpu_get_icount_locked();
+            int64_t cur_icount = icount_get_locked();
             int64_t delta = clock - cur_icount;
             warp_delta = MIN(warp_delta, delta);
         }
@@ -291,7 +291,7 @@ static void icount_timer_cb(void *opaque)
     icount_warp_rt();
 }
 
-void qemu_start_warp_timer(void)
+void icount_start_warp_timer(void)
 {
     int64_t clock;
     int64_t deadline;
@@ -394,7 +394,7 @@ void qemu_start_warp_timer(void)
     }
 }
 
-void qemu_account_warp_timer(void)
+void icount_account_warp_timer(void)
 {
     if (!icount_enabled() || !icount_sleep) {
         return;
@@ -417,7 +417,7 @@ void qemu_account_warp_timer(void)
     icount_warp_rt();
 }
 
-void configure_icount(QemuOpts *opts, Error **errp)
+void icount_configure(QemuOpts *opts, Error **errp)
 {
     const char *option = qemu_opt_get(opts, "shift");
     bool sleep = qemu_opt_get_bool(opts, "sleep", true);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6a1ee531db..5a11a62f78 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2695,7 +2695,7 @@ static void user_register_global_props(void)
 
 static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 {
-    configure_icount(opts, errp);
+    icount_configure(opts, errp);
     return 0;
 }
 
diff --git a/stubs/icount.c b/stubs/icount.c
index 61e28cbaf9..f13c43568b 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -6,40 +6,40 @@
 
 int use_icount;
 
-void cpu_update_icount(CPUState *cpu)
+void icount_update(CPUState *cpu)
 {
     abort();
 }
-void configure_icount(QemuOpts *opts, Error **errp)
+void icount_configure(QemuOpts *opts, Error **errp)
 {
     /* signal error */
     error_setg(errp, "cannot configure icount, TCG support not available");
 }
-int64_t cpu_get_icount_raw(void)
+int64_t icount_get_raw(void)
 {
     abort();
     return 0;
 }
-int64_t cpu_get_icount(void)
+int64_t icount_get(void)
 {
     abort();
     return 0;
 }
-int64_t cpu_icount_to_ns(int64_t icount)
+int64_t icount_to_ns(int64_t icount)
 {
     abort();
     return 0;
 }
-int64_t qemu_icount_round(int64_t count)
+int64_t icount_round(int64_t count)
 {
     abort();
     return 0;
 }
-void qemu_start_warp_timer(void)
+void icount_start_warp_timer(void)
 {
     abort();
 }
-void qemu_account_warp_timer(void)
+void icount_account_warp_timer(void)
 {
     abort();
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b0bc4aa534..cd0779ff5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1212,12 +1212,12 @@ static bool instructions_supported(CPUARMState *env)
 
 static uint64_t instructions_get_count(CPUARMState *env)
 {
-    return (uint64_t)cpu_get_icount_raw();
+    return (uint64_t)icount_get_raw();
 }
 
 static int64_t instructions_ns_per(uint64_t icount)
 {
-    return cpu_icount_to_ns((int64_t)icount);
+    return icount_to_ns((int64_t)icount);
 }
 #endif
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e51ed7b9ca..aaef6c6f20 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -300,7 +300,7 @@ static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (icount_enabled()) {
-        *val = cpu_get_icount();
+        *val = icount_get();
     } else {
         *val = cpu_get_host_ticks();
     }
@@ -315,7 +315,7 @@ static int read_instreth(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (icount_enabled()) {
-        *val = cpu_get_icount() >> 32;
+        *val = icount_get() >> 32;
     } else {
         *val = cpu_get_host_ticks() >> 32;
     }
diff --git a/util/main-loop.c b/util/main-loop.c
index 0c5fe0107e..6470f8eae3 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -526,7 +526,7 @@ void main_loop_wait(int nonblocking)
          * CPU thread can infinitely wait for event after
          * missing the warp
          */
-        qemu_start_warp_timer();
+        icount_start_warp_timer();
     }
     qemu_clock_run_all_timers();
 }
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 0674046b09..b69c6bb27b 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -419,7 +419,7 @@ static void timerlist_rearm(QEMUTimerList *timer_list)
 {
     /* Interrupt execution to force deadline recalculation.  */
     if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
-        qemu_start_warp_timer();
+        icount_start_warp_timer();
     }
     timerlist_notify(timer_list);
 }
@@ -636,7 +636,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     default:
     case QEMU_CLOCK_VIRTUAL:
         if (icount_enabled()) {
-            return cpu_get_icount();
+            return icount_get();
         } else if (qtest_enabled()) { /* for qtest_clock_warp */
             return qtest_get_virtual_clock();
         } else {
-- 
2.26.2



