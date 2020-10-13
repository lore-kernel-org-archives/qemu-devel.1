Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA72DC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480D4208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480D4208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPuN-0002PV-CJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSPri-0007OF-O5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:21:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSPrU-0008F6-Fw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:21:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DC345B236;
 Tue, 13 Oct 2020 19:21:26 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 3/3] replay: do not build if TCG is not available
Date: Tue, 13 Oct 2020 21:21:23 +0200
Message-Id: <20201013192123.22632-4-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013192123.22632-1-cfontana@suse.de>
References: <20201013192123.22632-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this fixes non-TCG builds broken recently by replay reverse debugging.

stub the needed functions in stub/, including errors for hmp and qmp.
This includes duplicating some code in replay/, and puts the logic
for non-replay related events in the replay/ module (+ the stubs),
so this should be revisited in the future.

Surprisingly, only _one_ qtest was affected by this, ide-test.c, which
resulted in a buzz as the bh events were never delivered, and the bh
never executed.

Many other subsystems _should_ have been affected.

This fixes the immediate issue, however a better way to group replay
functionality to TCG-only code could be developed in the long term.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 block/meson.build          |  3 +-
 migration/savevm.c         | 11 +++--
 net/meson.build            |  3 +-
 replay/meson.build         |  2 +-
 replay/replay-input.c      |  4 +-
 stubs/meson.build          |  1 -
 stubs/replay-user.c        |  9 ----
 stubs/replay.c             | 98 ++++++++++++++++++++++++++++++++++++++
 tests/ptimer-test-stubs.c  |  5 --
 tests/qtest/qmp-cmd-test.c |  3 ++
 ui/input.c                 | 12 ++++-
 11 files changed, 125 insertions(+), 26 deletions(-)
 delete mode 100644 stubs/replay-user.c

diff --git a/block/meson.build b/block/meson.build
index 78e8b25232..01fe6f84d2 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -7,7 +7,6 @@ block_ss.add(files(
   'backup-top.c',
   'blkdebug.c',
   'blklogwrites.c',
-  'blkreplay.c',
   'blkverify.c',
   'block-backend.c',
   'block-copy.c',
@@ -42,6 +41,8 @@ block_ss.add(files(
   'write-threshold.c',
 ), zstd, zlib)
 
+block_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
+
 block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
 block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
 block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
diff --git a/migration/savevm.c b/migration/savevm.c
index d2e141f7b1..d9181ca520 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "sysemu/tcg.h"
 
 const unsigned int postcopy_ram_discard_version = 0;
 
@@ -2674,10 +2675,12 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!replay_can_snapshot()) {
-        error_setg(errp, "Record/replay does not allow making snapshot "
-                   "right now. Try once more later.");
-        return ret;
+    if (tcg_enabled()) {
+        if (!replay_can_snapshot()) {
+            error_setg(errp, "Record/replay does not allow making snapshot "
+                       "right now. Try once more later.");
+            return ret;
+        }
     }
 
     if (!bdrv_all_can_snapshot(&bs)) {
diff --git a/net/meson.build b/net/meson.build
index 1c7e3a3cb9..1076b0a7ab 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -7,7 +7,6 @@ softmmu_ss.add(files(
   'eth.c',
   'filter-buffer.c',
   'filter-mirror.c',
-  'filter-replay.c',
   'filter-rewriter.c',
   'filter.c',
   'hub.c',
@@ -17,6 +16,8 @@ softmmu_ss.add(files(
   'util.c',
 ))
 
+softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('filter-replay.c'))
+
 softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
 softmmu_ss.add(when: slirp, if_true: files('slirp.c'))
 softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
diff --git a/replay/meson.build b/replay/meson.build
index f91163fb1e..cb3207740a 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -1,4 +1,4 @@
-softmmu_ss.add(files(
+softmmu_ss.add(when: 'CONFIG_TCG', if_true: files(
   'replay.c',
   'replay-internal.c',
   'replay-events.c',
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 1147e3d34e..5d1fd92e79 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -124,7 +124,7 @@ void replay_input_event(QemuConsole *src, InputEvent *evt)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         replay_add_input_event(QAPI_CLONE(InputEvent, evt));
     } else {
-        qemu_input_event_send_impl(src, evt);
+        g_assert_not_reached();
     }
 }
 
@@ -135,6 +135,6 @@ void replay_input_sync_event(void)
     } else if (replay_mode == REPLAY_MODE_RECORD) {
         replay_add_input_sync_event();
     } else {
-        qemu_input_event_sync_impl();
+        g_assert_not_reached();
     }
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index 67f2a8c069..bbd2230d69 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -32,7 +32,6 @@ stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
 stub_ss.add(files('ramfb.c'))
 stub_ss.add(files('replay.c'))
-stub_ss.add(files('replay-user.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('set-fd-handler.c'))
 stub_ss.add(files('sysbus.c'))
diff --git a/stubs/replay-user.c b/stubs/replay-user.c
deleted file mode 100644
index 2ad9e27203..0000000000
--- a/stubs/replay-user.c
+++ /dev/null
@@ -1,9 +0,0 @@
-#include "qemu/osdep.h"
-#include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
-
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
-    QEMUBHFunc *cb, void *opaque)
-{
-    aio_bh_schedule_oneshot(ctx, cb, opaque);
-}
diff --git a/stubs/replay.c b/stubs/replay.c
index 45ebe77fb9..34b7975b2d 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -103,3 +103,101 @@ bool replay_reverse_continue(void)
 {
     return false;
 }
+
+void replay_input_event(QemuConsole *src, InputEvent *evt)
+{
+}
+void replay_input_sync_event(void)
+{
+}
+void replay_bh_schedule_event(QEMUBH *bh)
+{
+    qemu_bh_schedule(bh);
+}
+void replay_bh_schedule_oneshot_event(AioContext *ctx,
+     QEMUBHFunc *cb, void *opaque)
+{
+    aio_bh_schedule_oneshot(ctx, cb, opaque);
+}
+void replay_add_blocker(Error *reason)
+{
+}
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
+{
+}
+void replay_audio_out(size_t *played)
+{
+}
+void replay_breakpoint(void)
+{
+}
+bool replay_can_snapshot(void)
+{
+    return false;
+}
+void replay_configure(struct QemuOpts *opts)
+{
+}
+void replay_flush_events(void)
+{
+}
+void replay_gdb_attached(void)
+{
+}
+bool replay_running_debug(void)
+{
+    return false;
+}
+void replay_shutdown_request(ShutdownCause cause)
+{
+}
+void replay_start(void)
+{
+}
+void replay_vmstate_init(void)
+{
+}
+
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+#include "qapi/qapi-commands-replay.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available");
+}
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+    return NULL;
+}
+void qmp_replay_break(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
+void qmp_replay_delete_break(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
+void qmp_replay_seek(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+              "replay support not available");
+}
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index e935a1395e..7f801a4d09 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -122,8 +122,3 @@ void qemu_bh_delete(QEMUBH *bh)
 {
     g_free(bh);
 }
-
-void replay_bh_schedule_event(QEMUBH *bh)
-{
-    bh->cb(bh->opaque);
-}
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 8a4c570e83..1c7186e53c 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -31,6 +31,9 @@ static int query_error_class(const char *cmd)
 #ifndef CONFIG_SPICE
         { "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND },
 #endif
+#ifndef CONFIG_TCG
+        { "query-replay", ERROR_CLASS_COMMAND_NOT_FOUND },
+#endif
 #ifndef CONFIG_VNC
         { "query-vnc", ERROR_CLASS_GENERIC_ERROR },
         { "query-vnc-servers", ERROR_CLASS_GENERIC_ERROR },
diff --git a/ui/input.c b/ui/input.c
index 4791b089c7..8675e8ad09 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -375,7 +375,11 @@ void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
         return;
     }
 
-    replay_input_event(src, evt);
+    if (replay_events_enabled()) {
+        replay_input_event(src, evt);
+    } else {
+        qemu_input_event_send_impl(src, evt);
+    }
 }
 
 void qemu_input_event_sync_impl(void)
@@ -401,7 +405,11 @@ void qemu_input_event_sync(void)
         return;
     }
 
-    replay_input_sync_event();
+    if (replay_events_enabled()) {
+        replay_input_sync_event();
+    } else {
+        qemu_input_event_sync_impl();
+    }
 }
 
 static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
-- 
2.26.2


