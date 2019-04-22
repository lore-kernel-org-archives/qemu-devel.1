Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C52C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8C82075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8C82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIXGM-0006ey-IF
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:37:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1F-0001Ji-Io
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1D-0002bT-BG
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47384)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1C-0002b4-Ql
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:51 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id E1F145400A9;
	Mon, 22 Apr 2019 14:21:49 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:21:49 +0300
Message-ID:
 <155593210972.21079.916318189717487042.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 23/24] replay: rename step-related
 variables and functions
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com,
	mreitz@redhat.com, alex.bennee@linaro.org,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	boost.lists@gmail.com, thomas.dullien@googlemail.com,
	dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422112149.8r6ZKXu27Biqd1yIoWT1uTDZIGUIuSxpe3d2-5QoJXE@z>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch renames replay_get_current_step() and related variables
to make these names consistent with hmp/qmp commands.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 blockdev.c                |    2 +-
 include/sysemu/replay.h   |    2 +-
 migration/savevm.c        |    2 +-
 replay/replay-debugging.c |   30 ++++++++++++++++--------------
 replay/replay-events.c    |    4 ++--
 replay/replay-internal.c  |   10 +++++-----
 replay/replay-internal.h  |   10 +++++-----
 replay/replay-snapshot.c  |    6 +++---
 replay/replay-time.c      |    2 +-
 replay/replay.c           |   26 +++++++++++++-------------
 10 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 7265ef0525..7c870142bd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1454,7 +1454,7 @@ static void internal_snapshot_prepare(BlkActionState *common,
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (replay_mode != REPLAY_MODE_NONE) {
-        sn->icount = replay_get_current_step();
+        sn->icount = replay_get_current_icount();
     } else {
         sn->icount = -1ULL;
     }
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index b7394a1f5c..057a458463 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -96,7 +96,7 @@ void replay_breakpoint(void);
 /* Processing the instructions */
 
 /*! Returns number of executed instructions. */
-uint64_t replay_get_current_step(void);
+uint64_t replay_get_current_icount(void);
 /*! Returns number of instructions to execute in replay mode. */
 int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
diff --git a/migration/savevm.c b/migration/savevm.c
index 2198d61b81..3cfdfe5ea1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2597,7 +2597,7 @@ int save_snapshot(const char *name, Error **errp)
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (replay_mode != REPLAY_MODE_NONE) {
-        sn->icount = replay_get_current_step();
+        sn->icount = replay_get_current_icount();
     } else {
         sn->icount = -1ULL;
     }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index abb5fe687f..b2275612c7 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -38,7 +38,7 @@ void hmp_info_replay(Monitor *mon, const QDict *qdict)
         monitor_printf(mon,
             "%s execution '%s': instruction count = %"PRId64"\n",
             replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
-            replay_get_filename(), replay_get_current_step());
+            replay_get_filename(), replay_get_current_icount());
     }
 }
 
@@ -51,7 +51,7 @@ ReplayInfo *qmp_query_replay(Error **errp)
         retval->filename = g_strdup(replay_get_filename());
         retval->has_filename = true;
     }
-    retval->icount = replay_get_current_step();
+    retval->icount = replay_get_current_icount();
     return retval;
 }
 
@@ -59,7 +59,7 @@ static void replay_break(uint64_t icount, QEMUTimerCB callback, void *opaque)
 {
     assert(replay_mode == REPLAY_MODE_PLAY);
     assert(replay_mutex_locked());
-    assert(replay_break_icount >= replay_get_current_step());
+    assert(replay_break_icount >= replay_get_current_icount());
     assert(callback);
 
     replay_break_icount = icount;
@@ -94,7 +94,7 @@ static void replay_stop_vm(void *opaque)
 void qmp_replay_break(int64_t icount, Error **errp)
 {
     if (replay_mode == REPLAY_MODE_PLAY) {
-        if (icount >= replay_get_current_step()) {
+        if (icount >= replay_get_current_icount()) {
             replay_break(icount, replay_stop_vm, NULL);
         } else {
             error_setg(errp,
@@ -196,14 +196,14 @@ static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
 
     snapshot = replay_find_nearest_snapshot(icount, &snapshot_icount);
     if (snapshot) {
-        if (icount < replay_get_current_step()
-            || replay_get_current_step() < snapshot_icount) {
+        if (icount < replay_get_current_icount()
+            || replay_get_current_icount() < snapshot_icount) {
             vm_stop(RUN_STATE_RESTORE_VM);
             load_snapshot(snapshot, errp);
         }
         g_free(snapshot);
     }
-    if (replay_get_current_step() <= icount) {
+    if (replay_get_current_icount() <= icount) {
         replay_break(icount, callback, NULL);
         vm_start();
     } else {
@@ -242,8 +242,9 @@ bool replay_reverse_step(void)
 
     assert(replay_mode == REPLAY_MODE_PLAY);
 
-    if (replay_get_current_step() != 0) {
-        replay_seek(replay_get_current_step() - 1, replay_stop_vm_debug, &err);
+    if (replay_get_current_icount() != 0) {
+        replay_seek(replay_get_current_icount() - 1,
+                    replay_stop_vm_debug, &err);
         if (err) {
             error_free(err);
             return false;
@@ -283,7 +284,7 @@ static void replay_continue_stop(void *opaque)
             error_free(err);
             replay_continue_end();
         }
-        replay_last_snapshot = replay_get_current_step();
+        replay_last_snapshot = replay_get_current_icount();
         return;
     } else {
         /* Seek to the very first step */
@@ -303,15 +304,16 @@ bool replay_reverse_continue(void)
 
     assert(replay_mode == REPLAY_MODE_PLAY);
 
-    if (replay_get_current_step() != 0) {
-        replay_seek(replay_get_current_step() - 1, replay_continue_stop, &err);
+    if (replay_get_current_icount() != 0) {
+        replay_seek(replay_get_current_icount() - 1,
+                    replay_continue_stop, &err);
         if (err) {
             error_free(err);
             return false;
         }
         replay_last_breakpoint = -1LL;
         replay_is_debugging = true;
-        replay_last_snapshot = replay_get_current_step();
+        replay_last_snapshot = replay_get_current_icount();
         return true;
     }
 
@@ -321,5 +323,5 @@ bool replay_reverse_continue(void)
 void replay_breakpoint(void)
 {
     assert(replay_mode == REPLAY_MODE_PLAY);
-    replay_last_breakpoint = replay_get_current_step();
+    replay_last_breakpoint = replay_get_current_icount();
 }
diff --git a/replay/replay-events.c b/replay/replay-events.c
index fc9b08225d..4778eb0ede 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -128,7 +128,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 void replay_bh_schedule_event(QEMUBH *bh)
 {
     if (events_enabled) {
-        uint64_t id = replay_get_current_step();
+        uint64_t id = replay_get_current_icount();
         replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
     } else {
         qemu_bh_schedule(bh);
@@ -139,7 +139,7 @@ void replay_bh_schedule_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque)
 {
     if (events_enabled) {
-        uint64_t id = replay_get_current_step();
+        uint64_t id = replay_get_current_icount();
         replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
     } else {
         aio_bh_schedule_oneshot(ctx, cb, opaque);
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 7e6de03182..b45725dbb1 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -173,7 +173,7 @@ void replay_fetch_data_kind(void)
         if (!replay_state.has_unread_data) {
             replay_state.data_kind = replay_get_byte();
             if (replay_state.data_kind == EVENT_INSTRUCTION) {
-                replay_state.instructions_count = replay_get_dword();
+                replay_state.instruction_count = replay_get_dword();
             }
             replay_check_error();
             replay_state.has_unread_data = 1;
@@ -227,9 +227,9 @@ void replay_mutex_unlock(void)
     }
 }
 
-void replay_advance_current_step(uint64_t current_step)
+void replay_advance_current_icount(uint64_t current_icount)
 {
-    int diff = (int)(current_step - replay_state.current_step);
+    int diff = (int)(current_icount - replay_state.current_icount);
 
     /* Time can only go forward */
     assert(diff >= 0);
@@ -237,7 +237,7 @@ void replay_advance_current_step(uint64_t current_step)
     if (diff > 0) {
         replay_put_event(EVENT_INSTRUCTION);
         replay_put_dword(diff);
-        replay_state.current_step += diff;
+        replay_state.current_icount += diff;
     }
 }
 
@@ -246,6 +246,6 @@ void replay_save_instructions(void)
 {
     if (replay_file && replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
-        replay_advance_current_step(replay_get_current_step());
+        replay_advance_current_icount(replay_get_current_icount());
     }
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index e9786b2377..ba9f374374 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -65,10 +65,10 @@ typedef enum ReplayAsyncEventKind ReplayAsyncEventKind;
 typedef struct ReplayState {
     /*! Cached clock values. */
     int64_t cached_clock[REPLAY_CLOCK_COUNT];
-    /*! Current step - number of processed instructions and timer events. */
-    uint64_t current_step;
+    /*! Current icount - number of processed instructions. */
+    uint64_t current_icount;
     /*! Number of instructions to be executed before other events happen. */
-    int instructions_count;
+    int instruction_count;
     /*! Type of the currently executed event. */
     unsigned int data_kind;
     /*! Flag which indicates that event is not processed yet. */
@@ -127,8 +127,8 @@ void replay_finish_event(void);
     data_kind variable. */
 void replay_fetch_data_kind(void);
 
-/*! Advance replay_state.current_step to the specified value. */
-void replay_advance_current_step(uint64_t current_step);
+/*! Advance replay_state.current_icount to the specified value. */
+void replay_advance_current_icount(uint64_t current_icount);
 /*! Saves queued events (like instructions and sound). */
 void replay_save_instructions(void);
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 16bacc98bc..7619f9b276 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -42,7 +42,7 @@ static int replay_post_load(void *opaque, int version_id)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         /* This is only useful for loading the initial state.
            Therefore reset all the counters. */
-        state->instructions_count = 0;
+        state->instruction_count = 0;
         state->block_request_id = 0;
     }
 
@@ -57,8 +57,8 @@ static const VMStateDescription vmstate_replay = {
     .post_load = replay_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_INT64_ARRAY(cached_clock, ReplayState, REPLAY_CLOCK_COUNT),
-        VMSTATE_UINT64(current_step, ReplayState),
-        VMSTATE_INT32(instructions_count, ReplayState),
+        VMSTATE_UINT64(current_icount, ReplayState),
+        VMSTATE_INT32(instruction_count, ReplayState),
         VMSTATE_UINT32(data_kind, ReplayState),
         VMSTATE_UINT32(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
diff --git a/replay/replay-time.c b/replay/replay-time.c
index 60f47b73a7..2260b1d00e 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -25,7 +25,7 @@ int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
      * Due to the caller's locking requirements we get the icount from it
      * instead of using replay_save_instructions().
      */
-    replay_advance_current_step(raw_icount);
+    replay_advance_current_icount(raw_icount);
     replay_put_event(EVENT_CLOCK + kind);
     replay_put_qword(clock);
 
diff --git a/replay/replay.c b/replay/replay.c
index 8f2e17c8cb..11b9c12eb6 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -43,7 +43,7 @@ bool replay_next_event_is(int event)
     bool res = false;
 
     /* nothing to skip - not all instructions used */
-    if (replay_state.instructions_count != 0) {
+    if (replay_state.instruction_count != 0) {
         assert(replay_state.data_kind == EVENT_INSTRUCTION);
         return event == EVENT_INSTRUCTION;
     }
@@ -66,7 +66,7 @@ bool replay_next_event_is(int event)
     return res;
 }
 
-uint64_t replay_get_current_step(void)
+uint64_t replay_get_current_icount(void)
 {
     return cpu_get_icount_raw();
 }
@@ -76,9 +76,9 @@ int replay_get_instructions(void)
     int res = 0;
     replay_mutex_lock();
     if (replay_next_event_is(EVENT_INSTRUCTION)) {
-        res = replay_state.instructions_count;
+        res = replay_state.instruction_count;
         if (replay_break_icount != -1LL) {
-            uint64_t current = replay_get_current_step();
+            uint64_t current = replay_get_current_icount();
             assert(replay_break_icount >= current);
             if (current + res > replay_break_icount) {
                 res = replay_break_icount - current;
@@ -93,16 +93,16 @@ void replay_account_executed_instructions(void)
 {
     if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
-        if (replay_state.instructions_count > 0) {
-            int count = (int)(replay_get_current_step()
-                              - replay_state.current_step);
+        if (replay_state.instruction_count > 0) {
+            int count = (int)(replay_get_current_icount()
+                              - replay_state.current_icount);
 
             /* Time can only go forward */
             assert(count >= 0);
 
-            replay_state.instructions_count -= count;
-            replay_state.current_step += count;
-            if (replay_state.instructions_count == 0) {
+            replay_state.instruction_count -= count;
+            replay_state.current_icount += count;
+            if (replay_state.instruction_count == 0) {
                 assert(replay_state.data_kind == EVENT_INSTRUCTION);
                 replay_finish_event();
                 /* Wake up iothread. This is required because
@@ -111,7 +111,7 @@ void replay_account_executed_instructions(void)
                 qemu_notify_event();
             }
             /* Execution reached the break step */
-            if (replay_break_icount == replay_state.current_step) {
+            if (replay_break_icount == replay_state.current_icount) {
                 /* Cannot make callback directly from the vCPU thread */
                 timer_mod_ns(replay_break_timer,
                     qemu_clock_get_ns(QEMU_CLOCK_REALTIME));
@@ -290,8 +290,8 @@ static void replay_enable(const char *fname, int mode)
     replay_mutex_init();
 
     replay_state.data_kind = -1;
-    replay_state.instructions_count = 0;
-    replay_state.current_step = 0;
+    replay_state.instruction_count = 0;
+    replay_state.current_icount = 0;
     replay_state.has_unread_data = 0;
 
     /* skip file header for RECORD and check it for PLAY */


