Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5423C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0E32145D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LxF799K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0E32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrSY-00081I-8g
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSA-0006ot-2N
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS8-0006yk-SP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS8-0006xf-7q; Wed, 17 Jul 2019 17:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563398828; x=1594934828;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y/EIjQAMc7p+xmtVB2kq6kXWCPJCIc15sNxmhUJdXBw=;
 b=LxF799K2G9tX624OQHOZHRn6pP2MF/9CYJ05aYpAhzTLK6d/M7Bwp+Az
 B1/Jy9OhCi6EZcxIzlJ4QF5eQ/FFMkW0zjBzjre7OM7HB3aOjdX+iUJ95
 28VtHPWz9hmm7Skfv5lb8bg6E8f6C45SdMZMD/zsLs/DSwjQw+S/yNi5M
 tMl4QKvYvN8DacOqI5SwPSY85VYEuEc4X1T3UaF+CV3HqyWtlhlxG/3kM
 prAOqC6wZxeAYS5yGhdddW9iGU3PfZzz+wR+v38dAyKA2C18kRxcBt9nW
 yUKwTb4KUVvkyHBcS/OcLUmy+cx39LuC3rNY8LWPOV0ZgHWb7E5xWY+bC w==;
IronPort-SDR: CD1fLuV1OXkO2ePSTczag5ZnOeYuEfx0tOfXtwPwBmVIo5IOAgGEONPHBnEJ1IZM1GaaiK0wCI
 7NLVBgOmmLCb1XqdZI+hGkBftxGWdg7u7FWUjZn//KuXJnwds4UhNBrHjdIRi2Kcd4JLWgYxSo
 SuySKBxMj1ahP9FMzjDr9AjvNuMUj7ZpYx+kHa3P/8cI8SlWvpZc2+o4y+ThxSNS5PvzZVZxso
 bwTZ2gmG1kuFwmhE7eFbewBLPDIijImqQJmw4mnmyeDuof2Juu975oFhNTXeiPgzFxRhT/HdPd
 NK4=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; d="scan'208";a="113319440"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 05:27:05 +0800
IronPort-SDR: QEOXAHrAzymdaDBgTh5AnlejiZU0Q/6OR0kiCP1Y0KH2sO/0r5YRdQuqgQ4oQca4bkEOB6i7wb
 WjJ+ZN+Tzw1rLKsHLM72qypC2fISIF1iEr+UZoVbhMU7P569b9aV+DGUz3FIs3LPIP9tN8fENB
 XBascCoe9KrLfErdT0Y7WFoSumYlFpV+CmQETaOTxx8qM5kLcrig9FP63tqr2K4A/ABTKtlm7R
 vvcNmbP0Wirn0kcvcO/uX1ASxoGnQy7QQk0eN7GQcImI5Z6sv5rS6fal/tMfAelkEpI/coAI2k
 fjJHAEcTKSpNSzvjvUNtMG9q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jul 2019 14:25:32 -0700
IronPort-SDR: J8jzJWqiLDoYijTMj4gXGuPVu8UgDNT6SoXXzkMiskDqzG2MAu4deHRjmEJi0zq5PdyRdiHBjO
 SFO1H75bK93LKYqCM2/ZJUKghlw162QxMD7HTdp5+a+gOJXe3XOqCiOplsRRTZy3YWkTRR7IJS
 44GkmxG64Ke9F7L5L1LAFNi/jRKyx6EfDBSD4KdncgRXYybmOz2tnC9xoy2B1Ssa0TZ6XEkK5h
 G89iYUFIlaXkkci98N9+0zazWenDuwmnSPUL9zu1VKcM8T0BQkHvwiPuuYxlEb5Gox08bPsZ7Z
 4qs=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jul 2019 14:27:05 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Jul 2019 17:26:59 -0400
Message-Id: <20190717212703.10205-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 1/5] block: Add zoned device model property
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
index 29e931e217..cbdf044d43 100644
--- a/block.c
+++ b/block.c
@@ -4671,6 +4671,25 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
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
index 734c9d2f76..a465da31b8 100644
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
index 50902531b7..73fbccbe8a 100644
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


