Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05311C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C965721926
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="okhlSLJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C965721926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq39B-0001kq-UL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38P-0007PP-L9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001Ci-8Q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38N-0001Bd-Ib; Tue, 23 Jul 2019 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563920388; x=1595456388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wHUoBrvdnxfgY6XIw8VsCJ56j8G8QwCLTjvAkjw0wis=;
 b=okhlSLJodN+eIlbYAw3GIItLKPH+hzkxfDFpDE94vEC74woIGCAAEARX
 LvHIAsf1z1V9iNgOuMsHdhoEGWfSDnxXHYdirQar76IKOMruCViVnpuAY
 DwlCrihT7ouEzkHQwqpzUQbj/eiQtH42bJiPKTv9PuKdHufBHAvK60oIH
 WzmgFAM+q/WE1ERmfH9Ohva6k9Xsx4zlLPC1TejGLKaIukTfBmA0yKaIN
 cR08O9faYIf2GnaP34TxB5L+k9/RJxph/YoZa2seZmoTpwh5wZo15W6z5
 unw1z6ke/r2h/U+nSoeiTw1CNDhtapBH0ipVZ4Idq6Jd4/hkKBksbHnIW A==;
IronPort-SDR: YwqsYGvLmB/BZEoooCWbikWPdECbobHFWWV7+VEU5cYZ3E/UzVsnZJA3f9Dmfj3QD0loN3sxL1
 HknX4zSOCDS9p/tvhbwIowGONGItzZsMVIuQaV0qAC+4cpEF1m5VaC+31Wb03jrpenyi3y0yCA
 TPoEa8ftQMAoK04SN/TKcIA3EoboWbhkP5kk4rwjI7C2pSJk9qSM5JnZ3Qz/YU0keNmDYgIh66
 1RMuyDyEf+2EYoLBj+n6V7d4REB7jsDm8cJeZh0FBvgkfBVKtH811KREA8iB/fEZfqBVyeihLU
 eZA=
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; d="scan'208";a="113843255"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2019 06:19:43 +0800
IronPort-SDR: XhHC08IZnBrGCmUJVy6u4Sonb/lzfwXVDuzsDyP8Az832eoIrU3k9P7WlPs2+B+yKgKcwoaRV3
 d9eHDfXuy539BlpBiKIOrDjVFt8YGtE9QMpo796PMyeb+PWnW7Oml1kOze1/45t54qQgHUxr20
 W8qyJyPnGH3WcDgWJDUbUWcGrcm0axmdLsMceoG8fGuklCZVoN3jjVNF3SYDuR/dmWwn72rw/K
 xvzzXSsx6BIMz3XxPfnpoPgmwv54mUX+ey6G9NRceLAgBqRc/aLbrvxkh2skaYvZencGR7RBk8
 8ad98UsOJ5UQ944OfkZStyfI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 15:17:56 -0700
IronPort-SDR: z7HNxL1F2oXVhQAwvhjD5BRW28X9VX0PF9MHG/Mwyj3L0Bu4ktuHDYotoFhQqFxH2DIwDQUUK7
 7WSJuj9JwPw6pO765cUg+aoa4A2nk1ExbdnSySGr2cghQkUoY20yW4YqaibRB6kIcmNpabK518
 EvqOb90a2GdcSNhBxa0qSWbwTar/eDEQ9bc5bo03Z3NxW4dA5YVoEKH8kL1ydhQyWcqwTwTXY6
 +S43m5M7dh15BDFiZ8ydOllmlRHqLERmGEDtTDv9CSsFTos1gTBYBIyeuRsSCEF9nH0Wfi2pXP
 nos=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 15:19:42 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Jul 2019 18:19:37 -0400
Message-Id: <20190723221940.25585-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
References: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v3 1/4] block: Add zoned device model property
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds Zoned Device Model (as defined in T10 ZBC and
T13 ZAC standards) as a block driver property, along with some
useful access functions.

A new backend driver permission, BLK_PERM_SUPPORT_ZONED, is also
introduced. Only the drivers having this permission will be allowed
to open zoned block devices.

No code is added yet to initialize or check the value of this new
property, therefore this commit doesn't change any functionality.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block.c                   | 19 +++++++++++++++++++
 include/block/block.h     | 21 ++++++++++++++++++++-
 include/block/block_int.h |  4 ++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..c717c4d6f5 100644
--- a/block.c
+++ b/block.c
@@ -4667,6 +4667,25 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
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
+    /*
+     * Host Aware zone devices are supposed to be able to work
+     * just like regular block devices. Thus, we only consider
+     * Host Managed devices to be zoned here.
+     */
+    return bdrv_get_zoned_model(bs) == BLK_ZONED_MODEL_HM;
+}
+
 bool bdrv_is_sg(BlockDriverState *bs)
 {
     return bs->sg;
diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..bd98933f67 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -266,18 +266,35 @@ enum {
      */
     BLK_PERM_GRAPH_MOD          = 0x10,
 
+    /** This permission is required to open zoned block devices. */
+    BLK_PERM_SUPPORT_ZONED      = 0x20,
+
     BLK_PERM_ALL                = 0x1f,
 
     DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
                                  | BLK_PERM_WRITE
                                  | BLK_PERM_WRITE_UNCHANGED
-                                 | BLK_PERM_RESIZE,
+                                 | BLK_PERM_RESIZE
+                                 | BLK_PERM_SUPPORT_ZONED,
 
     DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
 
+/*
+ * Known zoned device models.
+ *
+ * TODO For a Linux host, it could be preferrable to include
+ * /usr/include/linux/blkzoned.h instead of defining ZBD-specific
+ * values here.
+ */
+enum blk_zoned_model {
+    BLK_ZONED_MODEL_NONE, /* Regular block device */
+    BLK_ZONED_MODEL_HA,   /* Host-aware zoned block device */
+    BLK_ZONED_MODEL_HM,   /* Host-managed zoned block device */
+};
+
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
@@ -354,6 +371,8 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
                                BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
+uint8_t bdrv_get_zoned_model(BlockDriverState *bs);
+uint8_t bdrv_is_zoned(BlockDriverState *bs);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
 int bdrv_change_backing_file(BlockDriverState *bs,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..52c5758a9d 100644
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
-- 
2.21.0


