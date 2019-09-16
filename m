Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085ECC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02122067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02122067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sf6-0002Qx-EN
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ru8-0002pf-83
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ru7-0000ar-66
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ru4-0000ZD-GT; Mon, 16 Sep 2019 10:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91B9D307D970;
 Mon, 16 Sep 2019 14:22:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDC32F6E4;
 Mon, 16 Sep 2019 14:22:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:32 +0200
Message-Id: <20190916142246.31474-3-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 16 Sep 2019 14:22:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/16] block: Remove unused masks
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

From: Nir Soffer <nirsof@gmail.com>

Replace confusing usage:

    ~BDRV_SECTOR_MASK

With more clear:

    (BDRV_SECTOR_SIZE - 1)

Remove BDRV_SECTOR_MASK and the unused BDRV_BLOCK_OFFSET_MASK which was
it's last user.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-id: 20190827185913.27427-3-nsoffer@redhat.com
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 2 --
 migration/block.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..37c9de7446 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -143,7 +143,6 @@ typedef struct HDGeometry {
=20
 #define BDRV_SECTOR_BITS   9
 #define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BITS)
-#define BDRV_SECTOR_MASK   ~(BDRV_SECTOR_SIZE - 1)
=20
 #define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
                                      INT_MAX >> BDRV_SECTOR_BITS)
@@ -195,7 +194,6 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
-#define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
=20
 typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReop=
enQueue;
=20
diff --git a/migration/block.c b/migration/block.c
index 0de9d84198..8e49382070 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -906,7 +906,7 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
     do {
         addr =3D qemu_get_be64(f);
=20
-        flags =3D addr & ~BDRV_SECTOR_MASK;
+        flags =3D addr & (BDRV_SECTOR_SIZE - 1);
         addr >>=3D BDRV_SECTOR_BITS;
=20
         if (flags & BLK_MIG_FLAG_DEVICE_BLOCK) {
--=20
2.21.0


