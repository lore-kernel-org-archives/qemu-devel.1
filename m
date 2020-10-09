Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278BD22261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278BD22261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuEy-0008EE-9U
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQuCu-0006wf-5n
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:21:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQuCm-0004hk-Lx
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:21:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2E8CAB24C;
 Fri,  9 Oct 2020 15:21:11 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v1 4/4] replay: do not build if TCG is not available
Date: Fri,  9 Oct 2020 17:21:08 +0200
Message-Id: <20201009152108.16120-5-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009152108.16120-1-cfontana@suse.de>
References: <20201009152108.16120-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 23:20:51
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

replay requires icount, which needs TCG.

stub the needed functions in stub/,
including errors for hmp and qmp commands.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 migration/savevm.c         | 11 +++--
 replay/meson.build         |  2 +-
 stubs/replay.c             | 99 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |  3 ++
 4 files changed, 110 insertions(+), 5 deletions(-)

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
diff --git a/stubs/replay.c b/stubs/replay.c
index 45ebe77fb9..ff35daf198 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -103,3 +103,102 @@ bool replay_reverse_continue(void)
 {
     return false;
 }
+
+void replay_add_blocker(Error *reason)
+{
+}
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
+{
+}
+void replay_audio_out(size_t *played)
+{
+}
+void replay_bh_schedule_event(QEMUBH *bh)
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
+void replay_input_event(QemuConsole *src, InputEvent *evt)
+{
+}
+void replay_input_sync_event(void)
+{
+}
+void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
+                             const struct iovec *iov, int iovcnt)
+{
+}
+ReplayNetState *replay_register_net(NetFilterState *nfs)
+{
+    return NULL;
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
+void replay_unregister_net(ReplayNetState *rns)
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
+    error_report("replay support not available\n");
+}
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available\n");
+}
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available\n");
+}
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    error_report("replay support not available\n");
+}
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
+    return NULL;
+}
+void qmp_replay_break(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
+}
+void qmp_replay_delete_break(Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
+}
+void qmp_replay_seek(int64_t icount, Error **errp)
+{
+    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
+}
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
-- 
2.26.2


