Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EAC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0B3206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="1z3/Pq0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0B3206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=etsukata.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJgf-0007i2-SE
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devel@etsukata.com>) id 1ijJg4-0007IS-7J
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devel@etsukata.com>) id 1ijJg3-00080n-2h
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:07:00 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devel@etsukata.com>) id 1ijJg2-0007sO-KE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:06:58 -0500
Received: by mail-pg1-x543.google.com with SMTP id l24so8502404pgk.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etsukata-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LxG3wd+JkDnvw8rUQlHr+glYrc/y7je8jBeo318Kmpw=;
 b=1z3/Pq0jhs/0Gm59/Bl4pvknRJfRKkoMWr787pFN1u+/459OgyJs4lWFoOHn16+NCr
 P+RjaaB7X1XXAuPNeZVUegOCjIQ4gwYR0gM9QcDtBiqycVV9ZZbGT5oCGNMuWc+EJ0hv
 O/S7PwRrAumkC6wDnmBFpmTPsmvisSMchpVSzwMXhKO9xqJCsWx7an6TX311n91b3Mk5
 xY8DtMtS1nKMYUnkUJvrx7XP9k1PR99GWlKkwUJjIXXGXs03e2NWfK4HKVOnIPBbz2kd
 Lq5qQRXtUctkPAToZxQdzCVz2QqDD+CerUYD7b8kJBc3SMNKmt8KoRj9XwTKTxk++XZK
 Fl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LxG3wd+JkDnvw8rUQlHr+glYrc/y7je8jBeo318Kmpw=;
 b=W+l00tOtn9ph8soJarhpPwoF/n+zPVjcDI/veudQK1pcQDaGRj+mbLgmqJfmJYmYEn
 tLdIuGhbAC76TUBByFJ/qeVEw6eOAlYnCYFW4GxKZ9dZGxxXOF3Y3zgPNZkshOOaMoWg
 v8sxdUXKXtZnvmFDf8cTgG0qA5KhCuTTGwahvUdmnUpYB3raIphmlAwhc2RndESgTwTp
 YPyJMnYw0xeGCUsSGM80RIhELnWpKaT84Doi3PtSwTrQAkY40eFuUFBHuCzXDWBvcyd7
 aEtZUWIKcg5Ns/eOvQcksg2yv7sBlwj9jxdUeGpx5CUH6/B9FRnoxSgjuA2LcIL8BxcV
 owWg==
X-Gm-Message-State: APjAAAUNpHGURV9Ko7gujs2idbUbJogYsyrv3w2V7t1UK0RW6svl+dYo
 hLdEjh773zoO7437v9gR7fB8Ew==
X-Google-Smtp-Source: APXvYqyOZJ/C4M39HQ8Rps4SWb2kPASSnO+XeiyHJFC6iYI2DiRuzTwaEaXSDB413qwUMCuNG4JdpQ==
X-Received: by 2002:a63:89c2:: with SMTP id
 v185mr29525920pgd.135.1577092017039; 
 Mon, 23 Dec 2019 01:06:57 -0800 (PST)
Received: from localhost.localdomain
 (p5307023-ipngn11902marunouchi.tokyo.ocn.ne.jp. [114.166.45.23])
 by smtp.gmail.com with ESMTPSA id r1sm19466242pjp.29.2019.12.23.01.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 01:06:56 -0800 (PST)
From: Eiichi Tsukata <devel@etsukata.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, vsementsov@virtuozzo.com
Subject: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
Date: Mon, 23 Dec 2019 18:06:32 +0900
Message-Id: <20191223090632.30653-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Eiichi Tsukata <devel@etsukata.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_open_driver() allocates bs->opaque according to drv->instance_size.
There is no need to allocate it and overwrite opaque in
bdrv_backup_top_append().

Reproducer:

  $ QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 valgrind -q --leak-check=full tests/test-replication -p /replication/secondary/start
  ==29792== 24 bytes in 1 blocks are definitely lost in loss record 52 of 226
  ==29792==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
  ==29792==    by 0x4B07CE0: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.6000.7)
  ==29792==    by 0x12BAB9: bdrv_open_driver (block.c:1289)
  ==29792==    by 0x12BEA9: bdrv_new_open_driver (block.c:1359)
  ==29792==    by 0x1D15CB: bdrv_backup_top_append (backup-top.c:190)
  ==29792==    by 0x1CC11A: backup_job_create (backup.c:439)
  ==29792==    by 0x1CD542: replication_start (replication.c:544)
  ==29792==    by 0x1401B9: replication_start_all (replication.c:52)
  ==29792==    by 0x128B50: test_secondary_start (test-replication.c:427)
  ...

Fixes: 7df7868b9640 ("block: introduce backup-top filter driver")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 block/backup-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 7cdb1f8eba..617217374d 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -196,7 +196,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
     }
 
     top->total_sectors = source->total_sectors;
-    top->opaque = state = g_new0(BDRVBackupTopState, 1);
+    state = top->opaque;
 
     bdrv_ref(target);
     state->target = bdrv_attach_child(top, target, "target", &child_file, errp);
-- 
2.21.0


