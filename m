Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A486BC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700792073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E2NZkPhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700792073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwwQ-00089A-Mq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsw-0005lx-Gv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwst-0000nX-Or
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsp-0000VW-K3; Tue, 09 Jul 2019 16:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562704726; x=1594240726;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OQdCBt+oA9bpkFs+6bpKPS8S4KbIBEsavxEYZU5NgdY=;
 b=E2NZkPhDFYtlRQL7knaEwh1jGyx4+WDPKWGXI8PHu+2Vgf8a+Du3xcgd
 s5L+ZqU4zeLG3F3wt9hoeBs7GrFohOqjKEtZB8EKQnHUrTwj70BV/RqwV
 GWX1DAT9h6oxvq799QXIeEMkkG8stniKyUe1KH+QFuMEFU70xOcTs6nJH
 dnwYcaLVLA7yRvRBZqLksIAuK2j+gV9LquiT2thzYCYKsyvrdbi4QS91Q
 IV4U8SIN3/P0zxtRdMwadvRsozISNr5m/IVWQYqm8uOQxjP+Y3orNJ9lv
 Xfk7NwYvLW5HIaNh+m6XxvwZEgaNie/lu2cQioAU2ygsJqGlHm6a6TT+x A==;
IronPort-SDR: BzOSSjqzzS3xWdYrGhKz19H/KwtGMUABwTg+ZQvlAwQ6i3SiS9T4YZfmCUXZDmZhJl1utkvr2U
 3Ogm3vxL+YXH/kLqQyfK5G2vfGh7Ce4FAg5hFJeWLo/YVgiMoYbq63dVOHohfpWmIO7+YMqxc3
 me4nufH3CrehYRMgZpaUcBpk7ZeMMAAkc0tMIJFPBxaMG8RSC5f2bTk/kwbfU089X0kHc838GJ
 xGztUr64AfKZqFCMIDZzznvsvlgi5bdQBd6f2ABqcbS0CSWeHR9PbBCyFDFxD/TtMt2O6w1wtZ
 Hb4=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; d="scan'208";a="212488450"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 04:38:45 +0800
IronPort-SDR: VGaYahW8cBiZdtEJDkdMbP5szS7zktbAJdARmI/UOOE1vVVqHkqdAc86CJQJOB8QDq02CVZMj7
 2hvEZ9hY9dIObBLkFDr8ymvqTKneI2P+A7wF/Pa1OWkzOgYzW1OjgFdr86R6mAvD5AWvC2zlrr
 0RYKS5JXdUA1O/Exd13gUQib1+N2SYAGg1IoSKECRivOFOxWCjdDtTu98kFl3zRbkT0QumAmoB
 s6acVgZWhzm0XCkfLNCXa7/SMypEI0aemjUEdLJAZFRd7GEcb4w5ZcAnwM9DCyHeYavTD1TnA6
 LuDkoGerHkYvYNTXwXVlypcS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 13:37:26 -0700
IronPort-SDR: NlFTDb4uxrdZbasZNestABKfjsXpdGgznQufMMkh4HuNmWJNEqa7TuaRU0Hsfeg1aFr3EFtTTh
 smErExmW+D1R1EMHASG8+HWe3rdvKeO4wJFpE5M9l+xvvg6XDVjzWis4VmcbNZ8NNKzSZ0VBF4
 l76VqsOcfr8Cl33CF6FJARYnUuWTE4CN0oj78SnIkIrcjXAia15YrSAsC4b7h/PtXuCIRIavoR
 ph5JWffD9H+/9NJY5pB29c6BXA/R6xWUm6eBosiOiQ4R4UyoccpAh5e6yruN0RKxkynfvtgbRu
 Hqk=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 13:38:39 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:38:03 -0400
Message-Id: <20190709203806.17550-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH 1/4] block: Add zoned device model property
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds Zoned Device Model as defined in T10 ZBC and
T13 ZAC standards, along with some useful accessor functions.

Since the default value of zero in the zoned model field corresponds
to a regular (non-zoned) block device, there is no functionality
change with this commit.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block.c                        | 14 ++++++++++++++
 block/block-backend.c          | 20 ++++++++++++++++++++
 include/block/block.h          |  9 +++++++++
 include/block/block_int.h      |  4 ++++
 include/sysemu/block-backend.h |  2 ++
 5 files changed, 49 insertions(+)

diff --git a/block.c b/block.c
index c139540f2b..396d999f00 100644
--- a/block.c
+++ b/block.c
@@ -4649,6 +4649,20 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
     *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
 }
 
+uint8_t bdrv_get_zoned_model(BlockDriverState *bs)
+{
+    if (bs->drv->bdrv_get_zoned_info) {
+        bs->drv->bdrv_get_zoned_info(bs);
+    }
+
+    return bs->bl.zoned_model;
+}
+
+uint8_t bdrv_is_zoned(BlockDriverState *bs)
+{
+    return bdrv_get_zoned_model(bs) != BLK_ZONED_NONE;
+}
+
 bool bdrv_is_sg(BlockDriverState *bs)
 {
     return bs->sg;
diff --git a/block/block-backend.c b/block/block-backend.c
index a8d160fd5d..34723f3655 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1438,6 +1438,15 @@ int64_t blk_nb_sectors(BlockBackend *blk)
     return bdrv_nb_sectors(blk_bs(blk));
 }
 
+uint8_t blk_get_zoned_model(BlockBackend *blk)
+{
+    if (!blk_is_available(blk)) {
+        return BLK_ZONED_NONE;
+    }
+
+    return bdrv_get_zoned_model(blk_bs(blk));
+}
+
 BlockAIOCB *blk_aio_preadv(BlockBackend *blk, int64_t offset,
                            QEMUIOVector *qiov, BdrvRequestFlags flags,
                            BlockCompletionFunc *cb, void *opaque)
@@ -1705,6 +1714,17 @@ bool blk_is_sg(BlockBackend *blk)
     return bdrv_is_sg(bs);
 }
 
+bool blk_is_zoned(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (!bs) {
+        return false;
+    }
+
+    return bdrv_is_zoned(bs);
+}
+
 bool blk_enable_write_cache(BlockBackend *blk)
 {
     return blk->enable_write_cache;
diff --git a/include/block/block.h b/include/block/block.h
index 734c9d2f76..7aa096afcc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -278,6 +278,13 @@ enum {
 
 char *bdrv_perm_names(uint64_t perm);
 
+/* Known zoned device models */
+enum blk_zoned_model {
+    BLK_ZONED_NONE, /* Regular block device */
+    BLK_ZONED_HA,   /* Host-aware zoned block device */
+    BLK_ZONED_HM,   /* Host-managed zoned block device */
+};
+
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
@@ -354,6 +361,8 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
                                BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
+uint8_t bdrv_get_zoned_model(BlockDriverState *bs);
+uint8_t bdrv_is_zoned(BlockDriverState *bs);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
 int bdrv_change_backing_file(BlockDriverState *bs,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d6415b53c1..8f35591803 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -416,6 +416,7 @@ struct BlockDriver {
     bool (*bdrv_debug_is_suspended)(BlockDriverState *bs, const char *tag);
 
     void (*bdrv_refresh_limits)(BlockDriverState *bs, Error **errp);
+    void (*bdrv_get_zoned_info)(BlockDriverState *bs);
 
     /*
      * Returns 1 if newly created images are guaranteed to contain only
@@ -614,6 +615,9 @@ typedef struct BlockLimits {
 
     /* maximum number of iovec elements */
     int max_iov;
+
+    /* Zoned device model. Zero value indicates a regular block device */
+    uint8_t zoned_model;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 733c4957eb..65b6341218 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -156,6 +156,7 @@ int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
 int64_t blk_getlength(BlockBackend *blk);
 void blk_get_geometry(BlockBackend *blk, uint64_t *nb_sectors_ptr);
 int64_t blk_nb_sectors(BlockBackend *blk);
+uint8_t blk_get_zoned_model(BlockBackend *blk);
 BlockAIOCB *blk_aio_preadv(BlockBackend *blk, int64_t offset,
                            QEMUIOVector *qiov, BdrvRequestFlags flags,
                            BlockCompletionFunc *cb, void *opaque);
@@ -189,6 +190,7 @@ void blk_error_action(BlockBackend *blk, BlockErrorAction action,
                       bool is_read, int error);
 bool blk_is_read_only(BlockBackend *blk);
 bool blk_is_sg(BlockBackend *blk);
+bool blk_is_zoned(BlockBackend *blk);
 bool blk_enable_write_cache(BlockBackend *blk);
 void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
 void blk_invalidate_cache(BlockBackend *blk, Error **errp);
-- 
2.21.0


