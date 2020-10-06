Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBDC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEF620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6gz9/ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEF620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhcy-0004av-Ej
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQM-00038M-QZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQK-0001Ta-Ez
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id n18so4415784wrs.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vqm6/4FMvwrI7h0blvL6bknr7fh+GWarVad7IzR7GgY=;
 b=b6gz9/aykmhl5qKu60HMo4KR9iFUxOoeYE8B0MrBS2lSDn05UTwU2D30m4UAPpBcf1
 uGp6+5PVAlaBr/yI2JwXdSM4yJa5bumRu1A6I49OiVPgEKBEwOctnrTSZmOzcPEhnDGF
 oLEU08WJOtPcd6Ph4lFgRXBBsXqzcVqWl4nYDSuhpkEM+iQWe/YkdzDLDmOJsTMRl6oD
 5jlF8be2lmf0MdedPrSztPpC9+7HFLMjfyUmujjOosVqmsr1tLZuRNwQyTE9NNe3/1+Q
 9WVHvZzoz+M+ijfSEAS/frj9aTqqqD5fsAOgWEtru4ikR+zuDgvG5ggG2aUbFKxubMl7
 ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vqm6/4FMvwrI7h0blvL6bknr7fh+GWarVad7IzR7GgY=;
 b=FN8YP4EBrjQcKY0fzMpwrX/9Cg6ERsC3cFBINGp6OIbCfNAUJLqzkptQ0CXeCqx380
 1bIzIY6PggwuMUDMhjUilfZ88+X5TRZYggCcS/H7t18Ntq0uHLstFxJDFuPFA2wEVf3U
 v+LyuKTqKGCotHDmmlJfcFwZi5unexi52yDkJLS6mjTRhcn6VwRDZeYRokjQHD38CwnO
 /f/kj5kbW6DpXiKJIbL+9K18G98pDkH4K6itRYpgIpnp0sNLJbKNXJscpLcuuYwwz1NI
 JIt/3572WrA8ilk5t9Ug7GsUWZnhColWmmgkb+a9G3Li6M9w4TiVu684ipzGpnUBqGbv
 hFAg==
X-Gm-Message-State: AOAM532eE6VbVXvWnuZBu+cqlMZHu9WYp4CkqHXHIuQX06rANjhhjh9x
 8AbahKVuSOqZRqKLGFbP4HCRa8bwvp0=
X-Google-Smtp-Source: ABdhPJyzJ8Z8DQrny924FudeajllNsT7I66BeWLFSGSsQTT3oCqalUCzfsxzN6aoA96HLwWbgrFfVQ==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr3185026wrm.375.1601969410615; 
 Tue, 06 Oct 2020 00:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] migration: introduce icount field for snapshots
Date: Tue,  6 Oct 2020 09:29:37 +0200
Message-Id: <20201006072947.487729-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

Saving icount as a parameters of the snapshot allows navigation between
them in the execution replay scenario.
This information can be used for finding a specific snapshot for proceeding
the recorded execution to the specific moment of the time.
E.g., 'reverse step' action (introduced in one of the following patches)
needs to load the nearest snapshot which is prior to the current moment
of time.
This patch also updates snapshot test which verifies qemu monitor output.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>

--

v4 changes:
 - squashed format update with test output update
v7 changes:
 - introduced the spaces between the fields in snapshot info output
 - updated the test to match new field widths
Message-Id: <160174518865.12451.14327573383978752463.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qapi.c               | 18 ++++++++++----
 block/qcow2-snapshot.c     |  2 ++
 blockdev.c                 | 10 ++++++++
 include/block/snapshot.h   |  1 +
 migration/savevm.c         |  5 ++++
 qapi/block-core.json       | 10 ++++++--
 stubs/replay.c             |  5 ++++
 tests/qemu-iotests/261     |  4 ++--
 tests/qemu-iotests/267.out | 48 +++++++++++++++++++-------------------
 9 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index f423ece98c..036da085ee 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -230,6 +230,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
         info->date_nsec     = sn_tab[i].date_nsec;
         info->vm_clock_sec  = sn_tab[i].vm_clock_nsec / 1000000000;
         info->vm_clock_nsec = sn_tab[i].vm_clock_nsec % 1000000000;
+        info->icount        = sn_tab[i].icount;
+        info->has_icount    = sn_tab[i].icount != -1ULL;
 
         info_list = g_new0(SnapshotInfoList, 1);
         info_list->value = info;
@@ -694,14 +696,15 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
 {
     char date_buf[128], clock_buf[128];
+    char icount_buf[128] = {0};
     struct tm tm;
     time_t ti;
     int64_t secs;
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-20s%11s%20s%15s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
+        qemu_printf("%-10s%-18s%7s%20s%13s%11s",
+                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
     } else {
         ti = sn->date_sec;
         localtime_r(&ti, &tm);
@@ -715,11 +718,16 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
         sizing = size_to_str(sn->vm_state_size);
-        qemu_printf("%-10s%-20s%11s%20s%15s",
+        if (sn->icount != -1ULL) {
+            snprintf(icount_buf, sizeof(icount_buf),
+                "%"PRId64, sn->icount);
+        }
+        qemu_printf("%-9s %-17s %7s%20s%13s%11s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
-                    clock_buf);
+                    clock_buf,
+                    icount_buf);
     }
     g_free(sizing);
 }
@@ -881,6 +889,8 @@ void bdrv_image_info_dump(ImageInfo *info)
                 .date_nsec = elem->value->date_nsec,
                 .vm_clock_nsec = elem->value->vm_clock_sec * 1000000000ULL +
                                  elem->value->vm_clock_nsec,
+                .icount = elem->value->has_icount ?
+                          elem->value->icount : -1ULL,
             };
 
             pstrcpy(sn.id_str, sizeof(sn.id_str), elem->value->id);
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index d68b25e0c5..2e98c7f4b6 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -663,6 +663,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     sn->date_sec = sn_info->date_sec;
     sn->date_nsec = sn_info->date_nsec;
     sn->vm_clock_nsec = sn_info->vm_clock_nsec;
+    sn->icount = sn_info->icount;
     sn->extra_data_size = sizeof(QCowSnapshotExtraData);
 
     /* Allocate the L1 table of the snapshot and copy the current one there. */
@@ -1007,6 +1008,7 @@ int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         sn_info->date_sec = sn->date_sec;
         sn_info->date_nsec = sn->date_nsec;
         sn_info->vm_clock_nsec = sn->vm_clock_nsec;
+        sn_info->icount = sn->icount;
     }
     *psn_tab = sn_tab;
     return s->nb_snapshots;
diff --git a/blockdev.c b/blockdev.c
index bebd3ba1c3..a6ae475dac 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -59,6 +59,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
+#include "sysemu/replay.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/main-loop.h"
@@ -1190,6 +1191,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_state_size = sn.vm_state_size;
     info->vm_clock_nsec = sn.vm_clock_nsec % 1000000000;
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
+    if (sn.icount != -1ULL) {
+        info->icount = sn.icount;
+        info->has_icount = true;
+    }
 
     return info;
 
@@ -1350,6 +1355,11 @@ static void internal_snapshot_prepare(BlkActionState *common,
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_icount();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     ret1 = bdrv_snapshot_create(bs, sn);
     if (ret1 < 0) {
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 2bfcd57578..b0fe42993d 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -42,6 +42,7 @@ typedef struct QEMUSnapshotInfo {
     uint32_t date_sec; /* UTC date of the snapshot */
     uint32_t date_nsec;
     uint64_t vm_clock_nsec; /* VM clock relative to boot */
+    uint64_t icount; /* record/replay step */
 } QEMUSnapshotInfo;
 
 int bdrv_snapshot_find(BlockDriverState *bs, QEMUSnapshotInfo *sn_info,
diff --git a/migration/savevm.c b/migration/savevm.c
index 34e4b71052..0e8dc78684 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2723,6 +2723,11 @@ int save_snapshot(const char *name, Error **errp)
     sn->date_sec = tv.tv_sec;
     sn->date_nsec = tv.tv_usec * 1000;
     sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    if (replay_mode != REPLAY_MODE_NONE) {
+        sn->icount = replay_get_current_icount();
+    } else {
+        sn->icount = -1ULL;
+    }
 
     if (name) {
         ret = bdrv_snapshot_find(bs, old_sn, name);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 12a24772b5..fdc2e5cb28 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -27,13 +27,18 @@
 #
 # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
 #
+# @icount: Current instruction count. Appears when execution record/replay
+#          is enabled. Used for "time-traveling" to match the moment
+#          in the recorded execution with the snapshots. (since 5.2)
+#
 # Since: 1.3
 #
 ##
 { 'struct': 'SnapshotInfo',
   'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
             'date-sec': 'int', 'date-nsec': 'int',
-            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
+            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
+            '*icount': 'int' } }
 
 ##
 # @ImageInfoSpecificQCow2EncryptionBase:
@@ -5363,7 +5368,8 @@
 #                    "date-sec": 1000012,
 #                    "date-nsec": 10,
 #                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20
+#                    "vm-clock-nsec": 20,
+#                    "icount": 220414
 #      }
 #    }
 #
diff --git a/stubs/replay.c b/stubs/replay.c
index 5974ec1f50..eacb366aa8 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -88,3 +88,8 @@ int replay_read_random(void *buf, size_t len)
 {
     return 0;
 }
+
+uint64_t replay_get_current_icount(void)
+{
+    return 0;
+}
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index 848ffa760d..847b4c6a37 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -392,7 +392,7 @@ _check_test_img -r all
 
 echo
 echo "$((sn_count - 1)) snapshots should remain:"
-echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapshots"
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{32\}') snapshots"
 echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
 
 echo
@@ -519,7 +519,7 @@ _check_test_img -r all
 
 echo
 echo '65536 snapshots should remain:'
-echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapshots"
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{32\}') snapshots"
 echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
 
 # success, all done
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 215902b3ad..27471ffae8 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
 *** done
-- 
2.26.2



