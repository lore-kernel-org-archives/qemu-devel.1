Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E630120882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKu2-0003vD-Uz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpa-0000dK-O9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpY-0004N3-GC
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpU-0004KG-0Q; Fri, 20 Sep 2019 11:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4D4C8665D;
 Fri, 20 Sep 2019 15:28:13 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F66060167;
 Fri, 20 Sep 2019 15:28:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 03/22] block: Drop bdrv_is_first_non_filter()
Date: Fri, 20 Sep 2019 17:27:45 +0200
Message-Id: <20190920152804.12875-4-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 20 Sep 2019 15:28:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is unused now.  (And it was ugly because it needed to explore all BDS
chains from the top.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 37c9de7446..d3ccab4722 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -403,7 +403,6 @@ int bdrv_amend_options(BlockDriverState *bs_new, Qemu=
Opts *opts,
 /* external snapshots */
 bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
                                       BlockDriverState *candidate);
-bool bdrv_is_first_non_filter(BlockDriverState *candidate);
=20
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
diff --git a/block.c b/block.c
index 1c7c199849..7d99ca692c 100644
--- a/block.c
+++ b/block.c
@@ -6206,32 +6206,6 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverS=
tate *bs,
     return false;
 }
=20
-/* This function checks if the candidate is the first non filter bs down=
 it's
- * bs chain. Since we don't have pointers to parents it explore all bs c=
hains
- * from the top. Some filters can choose not to pass down the recursion.
- */
-bool bdrv_is_first_non_filter(BlockDriverState *candidate)
-{
-    BlockDriverState *bs;
-    BdrvNextIterator it;
-
-    /* walk down the bs forest recursively */
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        bool perm;
-
-        /* try to recurse in this top level bs */
-        perm =3D bdrv_recurse_is_first_non_filter(bs, candidate);
-
-        /* candidate is the first non filter */
-        if (perm) {
-            bdrv_next_cleanup(&it);
-            return true;
-        }
-    }
-
-    return false;
-}
-
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **e=
rrp)
 {
--=20
2.21.0


