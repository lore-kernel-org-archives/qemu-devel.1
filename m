Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F61C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E2F20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA6UNSqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E2F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhfZ-0007xV-7a
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQQ-0003HU-Oz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQO-0001Uz-2M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id l11so1833553wmh.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N+wPUKHp0dEGNvIdECz+pBa71rOenQ+nUmpc905Z6ig=;
 b=EA6UNSqwqzdZ8XAXQJtPXgUU8Y8culRpeF90oxEyZUAg0LvemWl7MaMJyntVEo8Yig
 bMJWDfvpoV0I7/7boN2FpYMiFuEmlin2WOl8ULLjhqkc9gKj/iXJEc/ICTsTyypxtu0o
 424dtWXBxbvp6ltBBJtTWutG/KJzNwtTbds2rbV/EvPmE0V2VQJSWJ3ZLC7ElwtrtNuv
 JKB+S51wtG7tRdEa/+8mrQFjEv+yC8KVCc3S88LM4vXmTdLlaO6eC1KktZLlSmKBSjIQ
 Sh09s55Xr6iA9amgXaVU9hEqOr2qzpfOzfnSQijwpv+S5q3iLEEvGPQ5gd4HyojHi3Re
 Wa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N+wPUKHp0dEGNvIdECz+pBa71rOenQ+nUmpc905Z6ig=;
 b=JeE/YIXUBXAP2owrG08K/QAF+Qji/r3/79ELcyDcw7oI/vEwYgfZ8T3aupCA3jjbO/
 TV7912LW3cOuIHvXQxyohTgwbrcMWa+AuS/hVu8G74CbSgomxbHNc91vrWyDwfzUgwlf
 gUVrCkHSP+Lsg6YNrS6KT4Xi+89t5c+vzZ/2AkFS4uSv1KU5s3ZDCT9kbWJF9giFMhFp
 8mczG1WLq5bflEmUDMQnuDHvFGa5LFyzveqIepVaYlBQnzinmgQ4PT/qk29CrcJgHAbk
 t1Wat874cB8YBSlCh1E54QlNpIPucIHgaWI/NVoOD0C+x0KJESm3/AwC9L9he0kGwHuN
 ulSQ==
X-Gm-Message-State: AOAM530lCPR5UATpdO1uy1dQQ0tTo1GF0JsOARVjjSeB9C0fm3xycClq
 86SJDz73INxMAoE62uhJmcrNB62TK8Q=
X-Google-Smtp-Source: ABdhPJysV8kKnHiG6dxYbw8Bj+YFw/UWSwRGZZBsld5YbpsU6GjrzCersYrSoFXV+hs5gSoVfa+cpQ==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr3107499wmj.136.1601969414316; 
 Tue, 06 Oct 2020 00:30:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] replay: implement replay-seek command
Date: Tue,  6 Oct 2020 09:29:41 +0200
Message-Id: <20201006072947.487729-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32c.google.com
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
the execution to the specified instruction count.
The command automatically loads nearest snapshot and replays the execution
to find the desired instruction count.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v4 changes:
 - fixed HMP command description indent
 - removed useless error_free call
Message-Id: <160174521180.12451.14033112911009278753.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands.hx           | 18 ++++++++
 include/monitor/hmp.h     |  1 +
 qapi/replay.json          | 20 +++++++++
 replay/replay-debugging.c | 87 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7680d0b380..e43ce600b8 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1836,6 +1836,24 @@ SRST
   The command is ignored when there are no replay breakpoints.
 ERST
 
+    {
+        .name       = "replay_seek",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "replay execution to the specified instruction count",
+        .cmd        = hmp_replay_seek,
+    },
+
+SRST
+``replay_seek`` *icount*
+  Automatically proceed to the instruction count *icount*, when
+  replaying the execution. The command automatically loads nearest
+  snapshot and replays the execution to find the desired instruction.
+  When there is no preceding snapshot or the execution is not replayed,
+  then the command fails.
+  *icount* for the reference may be observed with ``info replay`` command.
+ERST
+
     {
         .name       = "info",
         .args_type  = "item:s?",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 809ad638bb..ed2913fd18 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -132,5 +132,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_seek(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index 173ba76107..bfd83d7591 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -99,3 +99,23 @@
 #
 ##
 { 'command': 'replay-delete-break' }
+
+##
+# @replay-seek:
+#
+# Automatically proceed to the instruction count @icount, when
+# replaying the execution. The command automatically loads nearest
+# snapshot and replays the execution to find the desired instruction.
+# When there is no preceding snapshot or the execution is not replayed,
+# then the command fails.
+# icount for the reference may be obtained with @query-replay command.
+#
+# @icount: target instruction count
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
+##
+{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 3dc23b84fc..e1fe6b8661 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -19,6 +19,8 @@
 #include "qapi/qapi-commands-replay.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/timer.h"
+#include "block/snapshot.h"
+#include "migration/snapshot.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -125,3 +127,88 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+
+static char *replay_find_nearest_snapshot(int64_t icount,
+                                          int64_t *snapshot_icount)
+{
+    BlockDriverState *bs;
+    QEMUSnapshotInfo *sn_tab;
+    QEMUSnapshotInfo *nearest = NULL;
+    char *ret = NULL;
+    int nb_sns, i;
+    AioContext *aio_context;
+
+    *snapshot_icount = -1;
+
+    bs = bdrv_all_find_vmstate_bs();
+    if (!bs) {
+        goto fail;
+    }
+    aio_context = bdrv_get_aio_context(bs);
+
+    aio_context_acquire(aio_context);
+    nb_sns = bdrv_snapshot_list(bs, &sn_tab);
+    aio_context_release(aio_context);
+
+    for (i = 0; i < nb_sns; i++) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs) == 0) {
+            if (sn_tab[i].icount != -1ULL
+                && sn_tab[i].icount <= icount
+                && (!nearest || nearest->icount < sn_tab[i].icount)) {
+                nearest = &sn_tab[i];
+            }
+        }
+    }
+    if (nearest) {
+        ret = g_strdup(nearest->name);
+        *snapshot_icount = nearest->icount;
+    }
+    g_free(sn_tab);
+
+fail:
+    return ret;
+}
+
+static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
+{
+    char *snapshot = NULL;
+    int64_t snapshot_icount;
+
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        error_setg(errp, "replay must be enabled to seek");
+        return;
+    }
+
+    snapshot = replay_find_nearest_snapshot(icount, &snapshot_icount);
+    if (snapshot) {
+        if (icount < replay_get_current_icount()
+            || replay_get_current_icount() < snapshot_icount) {
+            vm_stop(RUN_STATE_RESTORE_VM);
+            load_snapshot(snapshot, errp);
+        }
+        g_free(snapshot);
+    }
+    if (replay_get_current_icount() <= icount) {
+        replay_break(icount, callback, NULL);
+        vm_start();
+    } else {
+        error_setg(errp, "cannot seek to the specified instruction count");
+    }
+}
+
+void qmp_replay_seek(int64_t icount, Error **errp)
+{
+    replay_seek(icount, replay_stop_vm, errp);
+}
+
+void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+{
+    int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_seek(icount, &err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+}
-- 
2.26.2



