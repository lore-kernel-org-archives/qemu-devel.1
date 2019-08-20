Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D91C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827A82082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827A82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyV5-0001QN-O4
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8t-0005wa-Va
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8j-0003bK-Jn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8f-0003W0-SA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B5E8195DB80;
 Tue, 20 Aug 2019 07:01:03 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D28C60F88;
 Tue, 20 Aug 2019 07:01:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:45 +0200
Message-Id: <1566284395-30287-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 20 Aug 2019 07:01:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 26/36] replay: rename step-related variables and
 functions
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch renames replay_get_current_step() and related variables
to make these names consistent with existing 'icount' command line
option and future record/replay hmp/qmp commands.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <156404428377.18669.15476429889039912070.stgit@pasha-Precision-3630-Tower>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/replay.h  |  2 +-
 replay/replay-events.c   |  2 +-
 replay/replay-internal.c | 10 +++++-----
 replay/replay-internal.h | 10 +++++-----
 replay/replay-snapshot.c |  6 +++---
 replay/replay-time.c     |  2 +-
 replay/replay.c          | 22 +++++++++++-----------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e..28ce19e 100644
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
index 60d17f6..008e80f 100644
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
index 979f3a0..ac6c901 100644
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
index af6f4d5..afba9a3 100644
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
index 3a58734..041f5af 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -39,7 +39,7 @@ static int replay_post_load(void *opaque, int version_id)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         /* This is only useful for loading the initial state.
            Therefore reset all the counters. */
-        state->instructions_count = 0;
+        state->instruction_count = 0;
         state->block_request_id = 0;
     }
 
@@ -54,8 +54,8 @@ static const VMStateDescription vmstate_replay = {
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
index 49c9e5d..43357c9 100644
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
index 8d77a4c..6a62ec3 100644
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
-- 
1.8.3.1



