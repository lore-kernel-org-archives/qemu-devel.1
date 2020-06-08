Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E49B2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux+YWV24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E49B2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiN9b-0002b3-DZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiN8P-0001w8-2P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:08:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiN8K-0006uU-CP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591643311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/u8us0VlqZQNTOvw0CeO2ZZNWirMI7O38faQs3enp0o=;
 b=Ux+YWV24BxwNYjyImSgheb7R87d/78gtP8/EPi7t5dkUl9nPBn1BtzO1Up9FypFX2gx+Ns
 uCFnV7Hjbm3idPQa8CVVF/1MlNaIFCeBMpAwbc61OBs+dJ3Byuqj6Aod2trGIs7voHNVYT
 aJsc33st02IniDYljSqTWDZNTR4lu/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Z4CKihK4PlS0DILgfuCtgg-1; Mon, 08 Jun 2020 15:08:29 -0400
X-MC-Unique: Z4CKihK4PlS0DILgfuCtgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BC518B6389;
 Mon,  8 Jun 2020 19:08:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E150E5D9F7;
 Mon,  8 Jun 2020 19:08:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Tweak comments on
 qcow2_get_persistent_dirty_bitmap_size
Date: Mon,  8 Jun 2020 14:08:21 -0500
Message-Id: <20200608190821.3293867-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, we don't have persistent bitmaps in any other formats, but
that might not be true in the future.  Make it obvious that our
incoming parameter is not necessarily a qcow2 image, and therefore is
limited to just the bdrv_dirty_bitmap_* API calls (rather than probing
into qcow2 internals).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 7bf12502da8c..1f38806ca6ea 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1757,19 +1757,20 @@ bool qcow2_supports_persistent_dirty_bitmap(BlockDriverState *bs)
 }

 /*
- * Compute the space required for bitmaps in @bs.
+ * Compute the space required to copy bitmaps from @in_bs.
  *
  * The computation is based as if copying to a new image with the
- * given @cluster_size, which may differ from the cluster size in @bs.
+ * given @cluster_size, which may differ from the cluster size in
+ * @in_bs; in fact, @in_bs might be something other than qcow2.
  */
-uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *bs,
+uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *in_bs,
                                                 uint32_t cluster_size)
 {
     uint64_t bitmaps_size = 0;
     BdrvDirtyBitmap *bm;
     size_t bitmap_dir_size = 0;

-    FOR_EACH_DIRTY_BITMAP(bs, bm) {
+    FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
         if (bdrv_dirty_bitmap_get_persistence(bm)) {
             const char *name = bdrv_dirty_bitmap_name(bm);
             uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
-- 
2.27.0


