Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0158AC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA39206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 05:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNb353sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA39206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsKp1-0000iq-2r
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 01:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hsKoa-0000Jx-2r
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hsKoY-0007Ck-V6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:36:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hsKoY-0007CT-P0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 01:36:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id i2so28443658plt.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 22:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=O+EIdoIntj3n5hnxy+xKUQkRRVsC3Mw51/au0nSQ6tk=;
 b=HNb353sLKIfbIXBTctYFSSNHUcWymHGZ5IqZB//PRQgaBLkDRBULOJ6O9amSwR0MWs
 IbEadsTCHsUceDlXbLX2L5yHrUgvnmGJmJkprzjOyUpqHT6C1OGALqUtv4l0b1i4AlJq
 nPaThRTkkJ8Ma2zEcaAuauRnD7kKUZipx+7CW/i+aqRmeiIB3eLNcsWEKlefeRlXGMwF
 2dcznoLbQrEYj6wKLMVrKYyN+nJpRMLBHfxgIfzAijunCo8Vlqx0nx81S6GBEB0MXFoW
 DwIQ924SzXuH9wsLffct99vWdTk6PcH4VjEALz359WMnzm5JOOYGq4s7QpoSlJ31nCIS
 AVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=O+EIdoIntj3n5hnxy+xKUQkRRVsC3Mw51/au0nSQ6tk=;
 b=ubzcNKEV1d3d1HWo4jMJYzGnPMwMqhaBchKPkI33VVqEyB14PxbZF4RofI0Em4016B
 /ryZ19XIh5FetiGLtSanKdAvFI4MCwljdMQtXc0Tz4fRNtepg+LQEiSJOD35cbvQd7HT
 QVW0daaxe46b00uHHNmKRCmyG0/Y/ocur/Ta/WORetokrFLMbOn6obskth+lPkFbkuwR
 XO7sQmvZcaAsArGdIPcf9YvZyQIQo6b00Ti/pdTbA1zT776U3g7Vr6kWXf8vO2wqdNiU
 9MUuhH7+0NQy9qAdpHn5mESDkYhlJOyBjlx9kc9SFuMO93sob4ArHYEs0m0RwE/I0zzy
 joaw==
X-Gm-Message-State: APjAAAXlvkk2fO3PY9YRfJyadrCp4/kUj3dPRqiv4rWspdD9/GgyCDwn
 ygqGe2pBiAz10ATehYmgKP4=
X-Google-Smtp-Source: APXvYqyBhsWKxo8CQevm16ikf/eFsLRWWVvqTUftWtWZ26pjFysqOnoNxPZ18RTQDCg00QuMcBS/QA==
X-Received: by 2002:a17:902:2b8a:: with SMTP id
 l10mr113325725plb.283.1564465005729; 
 Mon, 29 Jul 2019 22:36:45 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id o14sm52075285pjp.19.2019.07.29.22.36.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 22:36:45 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 30 Jul 2019 13:36:32 +0800
Message-Id: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH] migration: always initial ram_counters for a
 new migration
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

This patch fix a multifd migration bug in migration speed calculation, this
problem can be reproduced as follows:
1. start a vm and give a heavy memory write stress to prevent the vm be
   successfully migrated to destination
2. begin a migration with multifd
3. migrate for a long time [actually, this can be measured by transferred bytes]
4. migrate cancel
5. begin a new migration with multifd, the migration will directly run into
   migration_completion phase

Reason as follows:

Migration update bandwidth and s->threshold_size in function
migration_update_counters after BUFFER_DELAY time:

    current_bytes = migration_total_bytes(s);
    transferred = current_bytes - s->iteration_initial_bytes;
    time_spent = current_time - s->iteration_start_time;
    bandwidth = (double)transferred / time_spent;
    s->threshold_size = bandwidth * s->parameters.downtime_limit;

In multifd migration, migration_total_bytes function return
qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
s->iteration_initial_bytes will be initialized to 0 at every new migration,
but ram_counters is a global variable, and history migration data will be
accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
pending_size >= s->threshold_size become false in migration_iteration_run
after the first migration_update_counters.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/migration.c | 15 ++++++++++++++-
 migration/savevm.c    |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..d35a6ae6f9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1908,6 +1908,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     migrate_init(s);
+    /*
+     * set ram_counters memory to zero for a
+     * new migration
+     */
+    memset(&ram_counters, 0, sizeof(ram_counters));
 
     return true;
 }
@@ -3187,6 +3192,10 @@ static void *migration_thread(void *opaque)
 
     object_ref(OBJECT(s));
     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    /*
+     * Update s->iteration_initial_bytes to match s->iteration_start_time.
+     */
+    s->iteration_initial_bytes = migration_total_bytes(s);
 
     qemu_savevm_state_header(s->to_dst_file);
 
@@ -3252,7 +3261,11 @@ static void *migration_thread(void *opaque)
              * breaking transferred_bytes and bandwidth calculation
              */
             s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-            s->iteration_initial_bytes = 0;
+            /*
+             * Update s->iteration_initial_bytes to current size to
+             * avoid historical data lead wrong bandwidth.
+             */
+            s->iteration_initial_bytes = migration_total_bytes(s);
         }
 
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..480c511b19 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1424,6 +1424,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     migrate_init(ms);
+    memset(&ram_counters, 0, sizeof(ram_counters));
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.17.2 (Apple Git-113)


