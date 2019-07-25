Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF3C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809352238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809352238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZOC-00065G-Lz
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMl-0000Mi-1R
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMj-0000AR-8l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:46 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57046)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMi-0000A6-SS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:45 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id F128754006A;
 Thu, 25 Jul 2019 11:44:43 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:44:43 +0300
Message-ID: <156404428377.18669.15476429889039912070.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH v2 6/8] replay: rename step-related
 variables and functions
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch renames replay_get_current_step() and related variables
to make these names consistent with existing 'icount' command line
option and future record/replay hmp/qmp commands.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/sysemu/replay.h  |    2 +-
 replay/replay-events.c   |    2 +-
 replay/replay-internal.c |   10 +++++-----
 replay/replay-internal.h |   10 +++++-----
 replay/replay-snapshot.c |    6 +++---
 replay/replay-time.c     |    2 +-
 replay/replay.c          |   22 +++++++++++-----------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e423..28ce19e919 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -75,7 +75,7 @@ void replay_add_blocker(Error *reason);
 /* Processing the instructions */
 
 /*! Returns number of executed instructions. */
-uint64_t replay_get_current_step(void);
+uint64_t replay_get_current_icount(void);
 /*! Returns number of instructions to execute in replay mode. */
 int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 60d17f6edb..008e80f636 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -124,7 +124,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 void replay_bh_schedule_event(QEMUBH *bh)
 {
     if (events_enabled) {
-        uint64_t id = replay_get_current_step();
+        uint64_t id = replay_get_current_icount();
         replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
     } else {
         qemu_bh_schedule(bh);
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 979f3a0b39..ac6c9017fc 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -172,7 +172,7 @@ void replay_fetch_data_kind(void)
         if (!replay_state.has_unread_data) {
             replay_state.data_kind = replay_get_byte();
             if (replay_state.data_kind == EVENT_INSTRUCTION) {
-                replay_state.instructions_count = replay_get_dword();
+                replay_state.instruction_count = replay_get_dword();
             }
             replay_check_error();
             replay_state.has_unread_data = 1;
@@ -226,9 +226,9 @@ void replay_mutex_unlock(void)
     }
 }
 
-void replay_advance_current_step(uint64_t current_step)
+void replay_advance_current_icount(uint64_t current_icount)
 {
-    int diff = (int)(current_step - replay_state.current_step);
+    int diff = (int)(current_icount - replay_state.current_icount);
 
     /* Time can only go forward */
     assert(diff >= 0);
@@ -236,7 +236,7 @@ void replay_advance_current_step(uint64_t current_step)
     if (diff > 0) {
         replay_put_event(EVENT_INSTRUCTION);
         replay_put_dword(diff);
-        replay_state.current_step += diff;
+        replay_state.current_icount += diff;
     }
 }
 
@@ -245,6 +245,6 @@ void replay_save_instructions(void)
 {
     if (replay_file && replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
-        replay_advance_current_step(replay_get_current_step());
+        replay_advance_current_icount(replay_get_current_icount());
     }
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index af6f4d55d4..afba9a3e0c 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -64,10 +64,10 @@ typedef enum ReplayAsyncEventKind ReplayAsyncEventKind;
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
@@ -122,8 +122,8 @@ void replay_finish_event(void);
     data_kind variable. */
 void replay_fetch_data_kind(void);
 
-/*! Advance replay_state.current_step to the specified value. */
-void replay_advance_current_step(uint64_t current_step);
+/*! Advance replay_state.current_icount to the specified value. */
+void replay_advance_current_icount(uint64_t current_icount);
 /*! Saves queued events (like instructions and sound). */
 void replay_save_instructions(void);
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 756f48bc02..97d026af30 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -41,7 +41,7 @@ static int replay_post_load(void *opaque, int version_id)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         /* This is only useful for loading the initial state.
            Therefore reset all the counters. */
-        state->instructions_count = 0;
+        state->instruction_count = 0;
         state->block_request_id = 0;
     }
 
@@ -56,8 +56,8 @@ static const VMStateDescription vmstate_replay = {
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
index 49c9e5d8b2..43357c9f24 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -24,7 +24,7 @@ int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
      * Due to the caller's locking requirements we get the icount from it
      * instead of using replay_save_instructions().
      */
-    replay_advance_current_step(raw_icount);
+    replay_advance_current_icount(raw_icount);
     replay_put_event(EVENT_CLOCK + kind);
     replay_put_qword(clock);
 
diff --git a/replay/replay.c b/replay/replay.c
index 8d77a4ca4c..6a62ec3811 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -39,7 +39,7 @@ bool replay_next_event_is(int event)
     bool res = false;
 
     /* nothing to skip - not all instructions used */
-    if (replay_state.instructions_count != 0) {
+    if (replay_state.instruction_count != 0) {
         assert(replay_state.data_kind == EVENT_INSTRUCTION);
         return event == EVENT_INSTRUCTION;
     }
@@ -62,7 +62,7 @@ bool replay_next_event_is(int event)
     return res;
 }
 
-uint64_t replay_get_current_step(void)
+uint64_t replay_get_current_icount(void)
 {
     return cpu_get_icount_raw();
 }
@@ -72,7 +72,7 @@ int replay_get_instructions(void)
     int res = 0;
     replay_mutex_lock();
     if (replay_next_event_is(EVENT_INSTRUCTION)) {
-        res = replay_state.instructions_count;
+        res = replay_state.instruction_count;
     }
     replay_mutex_unlock();
     return res;
@@ -82,16 +82,16 @@ void replay_account_executed_instructions(void)
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
@@ -273,8 +273,8 @@ static void replay_enable(const char *fname, int mode)
     replay_mutex_init();
 
     replay_state.data_kind = -1;
-    replay_state.instructions_count = 0;
-    replay_state.current_step = 0;
+    replay_state.instruction_count = 0;
+    replay_state.current_icount = 0;
     replay_state.has_unread_data = 0;
 
     /* skip file header for RECORD and check it for PLAY */


