Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C952C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435372080F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435372080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2yG-0007Mq-Bz
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2x0-0006rO-Lm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2wy-0007Do-7y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:26:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:54182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2ww-0007AR-Ev
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:26:06 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2wo-00047e-68; Wed, 27 Nov 2019 22:25:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6] block/snapshot: rename Error ** parameter to more common
 errp
Date: Wed, 27 Nov 2019 22:25:58 +0300
Message-Id: <20191127192558.22013-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

v6: merge corresponding header change here, so, v6 is merge of
  [RFC v5 011/126] block/snapshot: rename Error ** parameter to more common errp
  and
  [RFC v5 019/126] include/block/snapshot.h: rename Error ** parameter to more common errp
  both has Eric's r-b, so I keep Eric's r-b for the merge

 include/block/snapshot.h | 2 +-
 block/snapshot.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index b5d5084a12..2bfcd57578 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -78,7 +78,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
 
 bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
-                             Error **err);
+                             Error **errp);
 int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
                            Error **errp);
 int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs);
diff --git a/block/snapshot.c b/block/snapshot.c
index 8081616ae9..bd9fb01817 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -426,7 +426,7 @@ fail:
 }
 
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                             Error **err)
+                             Error **errp)
 {
     int ret = 0;
     BlockDriverState *bs;
@@ -441,7 +441,7 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
             bdrv_snapshot_find(bs, snapshot, name) >= 0)
         {
             ret = bdrv_snapshot_delete(bs, snapshot->id_str,
-                                       snapshot->name, err);
+                                       snapshot->name, errp);
         }
         aio_context_release(ctx);
         if (ret < 0) {
-- 
2.21.0


