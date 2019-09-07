Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8459C433EF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDC21835
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AzHSg2te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDC21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6jPv-0007vA-KI
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 18:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM7-00040W-HL
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM6-0005di-4X
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM1-0005aj-Pc; Sat, 07 Sep 2019 18:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567895929; x=1599431929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nzgcP/IXDXWd7sGOatWYeHRKe9iS1Xze+OLw2406t6o=;
 b=AzHSg2tew60lE0ajGH0rpvwUa3MOfc0zLNA/L9v4IlcBz30dMfmAmFY+
 Arh/kwjSN9TrLJvUCfwJfVNf9IKD/u/LcBFpju4AGlWfqGdNEKD5KYcW7
 ZzPVG6PK9a/svDvdtBLlXngZU3Qv4VjIp41xlqs7IARfrY29UZT1pVDOc
 GQHAjCaQHoiWCNX64d6rpVS6iKrC4fCzyXaIJKcqMooM46by9z9CZ8mo1
 PpDHalut76YHXqh/Yk1dvXXgkKKns7y943aLKHHmHdaZbZYHg/6gUfnAm
 d9JoxDra1cpVXET2Rm5OjxlLituNE3NU+gi9TKUSszP+0h9S8Vrp7Wbu2 A==;
IronPort-SDR: PGNpeKMcOLuIFtZtad8U6CcOOXmbxuOJv3IIkGWdj+RJCYurhnO1tkMnh29/cz6xTVEnyvXBl1
 SqebIaOk8f4em28UWcsQjWD9XlLAIqkeTgcLXA/7t5pIYQVDItH58Cy9vH9prKm29eCY95XfwK
 K0n9cF3MIlkvn7Svafq9lzPEhcPhw1YiE6MlgUIi9r0ujcU7J18Abihf4/Ok78oYl+nkCeyS+1
 i5yDE8EeWjBnafZF1nBBzLR62UfYT9txOUXuU7WleVCcG0BdE2fADqOU3hxvhRwiyiplPjJH6t
 e40=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="224505947"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 06:38:44 +0800
IronPort-SDR: Qcawq3AMzSD7hQDM0b3fUXxBwC/5HNKmWj1mkRLyaS8ivElxTTkMAnl16G/N1ab5M2ShccfkzO
 fprCtHwMhAtOMk7n2R3zEHUKyh9yU4B5Kfb+9vkWvwh59wZZGSU/0gO0Xi+4aXa4X9OIk65gfj
 DFf7WxpU6W4zOuiV3kwts+oZxSjya11CjvbOdYPXHlZMuebLIlh7oNCPP0V9GrlpYR2PJ6S2Hc
 7RMuEzYuPEm1NMVPXahjWwLN5dntY+tgkaDe9L9NrJGZ6pIALaHEX1wLOKBk7vIW3I2XtAVr1a
 9htQ+cYPhyf7TQr/CH1CCtk4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2019 15:35:34 -0700
IronPort-SDR: W+3Jn06x/6nyx/2aVS2fzHbwsn5KXMsa0gMdOEu8e8INbm7U9nBbaJUolsI3zo7wiq16UWGYLk
 sVZfcKr+P6/4udGmoXERX5mhmafCpHtKXHBYEegFuiv3Xz/cx2P8bk6AL3UEWdnk2SwVbkPFAw
 4t22tKpsZNYI1WrgLlG9pfr/KKpNerYQH6WwWDUKrIHbCU15qm1xvB6vaKxivsSQBbQF8T+FLS
 iPCFAum7vFdWpUyEeeTBWlWyr7Y1ZG9PXwk/nXWt7rZVvW68I9pAcnG2WsZJk1l4sUV4RuKzAt
 VqQ=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2019 15:38:43 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Sat,  7 Sep 2019 18:38:38 -0400
Message-Id: <20190907223841.20210-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
References: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v7 1/4] block: Add zoned device model property
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds Zoned Device Model (as defined in T10 ZBC and
T13 ZAC standards) as a block driver property, along with some
useful access functions.

A new backend driver permission, BLK_PERM_SUPPORT_HM_ZONED, is also
introduced. Only the drivers having this permission will be allowed
to open host managed zoned block devices.

No code is added yet to initialize or check the value of this new
property, therefore this commit doesn't change any functionality.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c                   | 37 +++++++++++++++++++++++++++----------
 include/block/block.h     | 21 +++++++++++++++++++--
 include/block/block_int.h |  3 +++
 qapi/block-core.json      |  5 ++++-
 4 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 5944124845..f0390196f2 100644
--- a/block.c
+++ b/block.c
@@ -1968,11 +1968,12 @@ char *bdrv_perm_names(uint64_t perm)
         uint64_t perm;
         const char *name;
     } permissions[] = {
-        { BLK_PERM_CONSISTENT_READ, "consistent read" },
-        { BLK_PERM_WRITE,           "write" },
-        { BLK_PERM_WRITE_UNCHANGED, "write unchanged" },
-        { BLK_PERM_RESIZE,          "resize" },
-        { BLK_PERM_GRAPH_MOD,       "change children" },
+        { BLK_PERM_CONSISTENT_READ,  "consistent read" },
+        { BLK_PERM_WRITE,            "write" },
+        { BLK_PERM_WRITE_UNCHANGED,  "write unchanged" },
+        { BLK_PERM_RESIZE,           "resize" },
+        { BLK_PERM_GRAPH_MOD,        "change children" },
+        { BLK_PERM_SUPPORT_HM_ZONED, "attach hm-zoned" },
         { 0, NULL }
     };
 
@@ -4678,6 +4679,21 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
     *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
 }
 
+BdrvZonedModel bdrv_get_zoned_model(BlockDriverState *bs)
+{
+    return bs->bl.zoned_model;
+}
+
+bool bdrv_is_hm_zoned(BlockDriverState *bs)
+{
+    /*
+     * Host Aware zone devices are supposed to be able to work
+     * just like regular block devices. Thus, we only consider
+     * Host Managed devices to be zoned here.
+     */
+    return bdrv_get_zoned_model(bs) == BDRV_ZONED_MODEL_HM;
+}
+
 bool bdrv_is_sg(BlockDriverState *bs)
 {
     return bs->sg;
@@ -4871,11 +4887,12 @@ static void xdbg_graph_add_edge(XDbgBlockGraphConstructor *gr, void *parent,
     } PermissionMap;
 
     static const PermissionMap permissions[] = {
-        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
-        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
-        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
-        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
-        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
+        { BLK_PERM_CONSISTENT_READ,  BLOCK_PERMISSION_CONSISTENT_READ },
+        { BLK_PERM_WRITE,            BLOCK_PERMISSION_WRITE },
+        { BLK_PERM_WRITE_UNCHANGED,  BLOCK_PERMISSION_WRITE_UNCHANGED },
+        { BLK_PERM_RESIZE,           BLOCK_PERMISSION_RESIZE },
+        { BLK_PERM_GRAPH_MOD,        BLOCK_PERMISSION_GRAPH_MOD },
+        { BLK_PERM_SUPPORT_HM_ZONED, BLOCK_PERMISSION_SUPPORT_HM_ZONED },
         { 0, 0 }
     };
     const PermissionMap *p;
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..46cfa5bfa9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -271,18 +271,33 @@ enum {
      */
     BLK_PERM_GRAPH_MOD          = 0x10,
 
-    BLK_PERM_ALL                = 0x1f,
+    /**
+     * This permission is required to open host-managed zoned block devices.
+     */
+    BLK_PERM_SUPPORT_HM_ZONED   = 0x20,
+
+    BLK_PERM_ALL                = 0x3f,
 
     DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
                                  | BLK_PERM_WRITE
                                  | BLK_PERM_WRITE_UNCHANGED
-                                 | BLK_PERM_RESIZE,
+                                 | BLK_PERM_RESIZE
+                                 | BLK_PERM_SUPPORT_HM_ZONED,
 
     DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
 
+/*
+ * Known zoned device models.
+ */
+typedef enum {
+    BDRV_ZONED_MODEL_NONE, /* Regular block device */
+    BDRV_ZONED_MODEL_HA,   /* Host-aware zoned block device */
+    BDRV_ZONED_MODEL_HM,   /* Host-managed zoned block device */
+} BdrvZonedModel;
+
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
@@ -359,6 +374,8 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
                                BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
+BdrvZonedModel bdrv_get_zoned_model(BlockDriverState *bs);
+bool bdrv_is_hm_zoned(BlockDriverState *bs);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
 int bdrv_change_backing_file(BlockDriverState *bs,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..928cbae9a5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -635,6 +635,9 @@ typedef struct BlockLimits {
 
     /* maximum number of iovec elements */
     int max_iov;
+
+    /* Zoned device model. Zero value indicates a regular block device */
+    BdrvZonedModel zoned_model;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..860a8e16e5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1803,11 +1803,14 @@
 # @graph-mod: This permission is required to change the node that this
 #             BdrvChild points to.
 #
+# @support-hm-zoned: This permission is required to attach host-managed
+#                    zoned devices.
+#
 # Since: 4.0
 ##
   { 'enum': 'BlockPermission',
     'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
-              'graph-mod' ] }
+              'graph-mod', 'support-hm-zoned' ] }
 ##
 # @XDbgBlockGraphEdge:
 #
-- 
2.21.0


