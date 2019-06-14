Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF515C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879D320866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879D320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbn9N-00081L-Rf
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmSu-000283-Rb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmSt-0006f6-1Y
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmSg-0006FI-WD; Fri, 14 Jun 2019 09:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E494FC058CC0;
 Fri, 14 Jun 2019 13:41:12 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2725D9C3;
 Fri, 14 Jun 2019 13:41:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:19 +0200
Message-Id: <20190614134021.32486-19-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 13:41:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/20] blkdebug: Inject errors on
 .bdrv_co_block_status()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190507203508.18026-6-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 block/blkdebug.c     | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 60f903afa3..61124431d8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3281,10 +3281,13 @@
 #
 # @flush: .bdrv_co_flush_to_disk()
 #
+# @block-status: .bdrv_co_block_status()
+#
 # Since: 4.1
 ##
 { 'enum': 'BlkdebugIOType', 'prefix': 'BLKDEBUG_IO_TYPE',
-  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush' ] }
+  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush',
+            'block-status' ] }
=20
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 1663ed25af..5ae96c52b0 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -670,7 +670,15 @@ static int coroutine_fn blkdebug_co_block_status(Blo=
ckDriverState *bs,
                                                  int64_t *map,
                                                  BlockDriverState **file=
)
 {
+    int err;
+
     assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+
+    err =3D rule_check(bs, offset, bytes, BLKDEBUG_IO_TYPE_BLOCK_STATUS)=
;
+    if (err) {
+        return err;
+    }
+
     return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
                                           pnum, map, file);
 }
--=20
2.21.0


