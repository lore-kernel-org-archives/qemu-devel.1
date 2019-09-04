Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A53920828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mik7EO0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A53920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dCw-0003X6-9l
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOy-0006Jj-E8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOt-0007bI-1e
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOp-0007Wm-Hf; Wed, 04 Sep 2019 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567630868; x=1599166868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NLbSy76QN5WmjCTE4UUALAVdKCC0nk7AnaWJw993qa0=;
 b=Mik7EO0F5CBFzOfC+bo+dQeRaO49vLLSeOlVu1jMunND9TbBGJOY3Ta/
 4PPlO4NoX8IeBWo3s6yhvFotzPh/d7GmIQzQ5XlZGKbOdrMeGAcmMiayt
 rylZ2N3CfS2og9qVhfup6+hDGA+W7GLRnwB58Z9t7p5VI+kUzGe0QTy8v
 SdVso8lnctNyNlbesen0Rf/CWPRhas8IMbe12jyvJ4V8AwPSukkf6hu4Y
 hz5VRsPRa57/w/jogbSsi58J52eO6yRzCXIqQgAAOpnWS3B7W47B9Nc8i
 CJR50zxpF+D3LV9SRBCmCmYsZs5Jj3zq16uNbKw2YBQ9WPi64qyaFvu+W w==;
IronPort-SDR: oaVdDQfaYevYGrA5uKZKXSb8dEPaCbvwPkvIOdsBkDE0eE/ZxJZ1cydqHyl/hA0H//up4qNWB+
 Sabzg4nWwYGaWUjnD+byv2BgjoD+RTD2+vMVpH2WQ4FR8AnJFyUcK/I60knlIfWD2riJFOT2LJ
 YrkPG5a+jBhNbAQXmp27jy5f6bQ0evPO1PyujLyXs29dvYGszW5Bk/6unL7Z1etlwaw/6lbt0s
 aPwBcfl9ITamBx3TiZuiiSIliAPhXCVogO8uOr0WSib9YWfWZHp0GYKFbklqSmPEJSe2f27o2i
 CgI=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117451660"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:01:03 +0800
IronPort-SDR: rJvOILvfiz/apJKTGKEwxa/KctgWXLyXTnTZFtimTCFpgOyBBKgtvT4wl9Q1n6XkB7WeMDvgHk
 eCHPhnkjTLgecUdkrvCD4DSYI1Pn/o+vZOyLsv8Wuo/IBQhVuDOPhl0k7KIPc9e2shhUFs0v9O
 MTd2DsAEuYmjM87LpY9rzxaEdxBBw4PWf51N79OYqYL7kjr383SFXU9OdH2tdZzfX2GS+TfAjB
 EyCuhZtfS/ZJLk4325byURDrXXSZxyQjegKF2Qqgl+yjndr+ljghkKylBVnfeMQHhVInHEgJUm
 8Six/4xLZWG5QpiQi7ERXvmR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:58:00 -0700
IronPort-SDR: IbDXOoxcT3kKpx+XY8g/ZupGR7ax4CoqzReY9KPDfwQ6w94lL6D6mfGeTxOr2ibsXnjNBGWg5b
 YN3zFixs4gAy/Qmog9dgOjY60cpqbeV3z7U9e39GIf7Zg85jR+YY8rl32cxb6WjPLjSx/xyNe+
 HBVBJ9l5QjeQFU3xLUx/+bK7WwcofdMarux/WNC2quf/nV0YVfrIlL5NxcJunmquQaDdJ9uN0C
 0KL/rGvBdNgcfBFCg8Ye5N3oJB2Zy54DrGq7XlsTWx+5gX6sMPFd0C87no5jqaLJDZoWSZF+7i
 BXA=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2019 14:01:02 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Wed,  4 Sep 2019 17:00:57 -0400
Message-Id: <20190904210100.10501-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model property
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
---
 block.c                   | 15 +++++++++++++++
 include/block/block.h     | 19 ++++++++++++++++++-
 include/block/block_int.h |  3 +++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 874a29a983..69f565e1e9 100644
--- a/block.c
+++ b/block.c
@@ -4679,6 +4679,21 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
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
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..28d065ed80 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -271,18 +271,33 @@ enum {
      */
     BLK_PERM_GRAPH_MOD          = 0x10,
 
+    /**
+     * This permission is required to open host-managed zoned block devices.
+     */
+    BLK_PERM_SUPPORT_HM_ZONED   = 0x20,
+
     BLK_PERM_ALL                = 0x1f,
 
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
-- 
2.21.0


