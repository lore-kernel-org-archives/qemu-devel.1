Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36313C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF1521E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF1521E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMh8-0001mm-Bb
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007lo-5X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg6-0003K5-RL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:40618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003Cu-2b; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg0-0005oH-15; Wed, 07 Aug 2019 17:12:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:22 +0300
Message-Id: <20190807141226.193501-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 06/10] block/qcow2-bitmap: drop
 qcow2_reopen_bitmaps_rw_hint()
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function is unused, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  2 --
 block/qcow2-bitmap.c | 15 +--------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fc1b0d3c1e..a5b24f4eec 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -736,8 +736,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                                 Error **errp);
-int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
-                                 Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 60b79f1dac..fbeee37243 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1102,8 +1102,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
     return list;
 }
 
-int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
-                                 Error **errp)
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
@@ -1111,10 +1110,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
     GSList *ro_dirty_bitmaps = NULL;
     int ret = 0;
 
-    if (header_updated != NULL) {
-        *header_updated = false;
-    }
-
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
         return 0;
@@ -1156,9 +1151,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
             error_setg_errno(errp, -ret, "Can't update bitmap directory");
             goto out;
         }
-        if (header_updated != NULL) {
-            *header_updated = true;
-        }
         g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
 
@@ -1169,11 +1161,6 @@ out:
     return ret;
 }
 
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
-{
-    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
-}
-
 /* Checks to see if it's safe to resize bitmaps */
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp)
 {
-- 
2.18.0


