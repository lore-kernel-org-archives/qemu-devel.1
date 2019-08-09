Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C3C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78FC20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78FC20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7lC-0001jJ-2p
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7YB-0003up-20
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Y9-0004dD-P7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Y7-0004bc-DP; Fri, 09 Aug 2019 12:15:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA08665F7B;
 Fri,  9 Aug 2019 16:15:26 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 472CA5C8BA;
 Fri,  9 Aug 2019 16:15:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:57 +0200
Message-Id: <20190809161407.11920-33-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 09 Aug 2019 16:15:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 32/42] block: Make
 bdrv_get_cumulative_perm() public
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful in other files like blockdev.c to determine for example
whether a node can be written to or not.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 3 +++
 block.c                   | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 786801c32f..c17df3808a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1205,6 +1205,9 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t =
perm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error *=
*errp);
=20
+void bdrv_get_cumulative_perm(BlockDriverState *bs,
+                              uint64_t *perm, uint64_t *shared_perm);
+
 /* Default implementation for BlockDriver.bdrv_child_perm() that can be =
used by
  * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RE=
SIZE to
  * all children */
diff --git a/block.c b/block.c
index 6e1ddab056..915b80153c 100644
--- a/block.c
+++ b/block.c
@@ -1713,8 +1713,6 @@ static int bdrv_child_check_perm(BdrvChild *c, Bloc=
kReopenQueue *q,
                                  bool *tighten_restrictions, Error **err=
p);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t sh=
ared);
-static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *per=
m,
-                                     uint64_t *shared_perm);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -1938,8 +1936,8 @@ static void bdrv_set_perm(BlockDriverState *bs, uin=
t64_t cumulative_perms,
     }
 }
=20
-static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *per=
m,
-                                     uint64_t *shared_perm)
+void bdrv_get_cumulative_perm(BlockDriverState *bs,
+                              uint64_t *perm, uint64_t *shared_perm)
 {
     BdrvChild *c;
     uint64_t cumulative_perms =3D 0;
--=20
2.21.0


