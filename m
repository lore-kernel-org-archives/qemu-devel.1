Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD2EC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA952073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QaF7MxlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA952073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwzv-0002KE-Ha
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwt5-0005sM-DC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwt0-00011C-4a
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwst-0000jE-Js; Tue, 09 Jul 2019 16:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562704733; x=1594240733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sv7iJyU3lEXrOaUa/SEaaTKyC8QKbb+Dk4Hz74sYrj0=;
 b=QaF7MxlHUzNUvglh13GuAAU9zXWPgJg1JMBzZ1oWAPOSQORUQGuFxaAt
 QoZ5RGYU1Rp4RAsHexBgubz6z4dYa4uEbCK7naxyQFkD8p4txzqz0fONP
 FWFnsKSmnTvlaO2ydREatD7Yh0FyjdCn4GFso8PNIikj0OnOGBpYncxQm
 8kjtJhenu2foGCH1W+cAHNygWEQ/Gg3i5aBrB16HEXb6FFkNWJklsyp1K
 q0V9UHa4LKVx40sZAD73NYjYcN58+hYPKcCbOKilWExYr8sFeLFDtQVYy
 sVM/qTPOuVcaBzJG4UPMKtJHSdPIJqLPmXTi79Gseh9DZ/CahAitqgy/k w==;
IronPort-SDR: 8xJcHaT2LDwxyzKgViPzhBMjN4RuX5Bn8PPPMkp18q+XhBoeL3EQVaIHg+SmvL7FisM21kWy3i
 lzBd0OiTkVphCr3ZKznmx7Q67h1Bf3sws6JTPB8mHe2rdVF1F2DN5Er8ckg++FI7p38eGef11A
 miWfhoBGsu1cxW6Lq/gEnnFn7L6rfJo4Cf0nYEs8lUQeuhUVs4Xgci38nDfP/oRn7FfRLE2Ppn
 k9eFGV/lSTOvoG+3jsDwVfieN/lej3VbOZYIxCbyUGul7pAzHsfHk1XXbhVnP0hHHok4ShTitB
 ZNk=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; d="scan'208";a="212488453"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 04:38:49 +0800
IronPort-SDR: yVf5SLn/mnWibPCPDzNEv+FmjiAY6c9ylzBYfxU3xGM/XN1h/ZdrcZ7D1/Pj3UApD88+O5Ocg7
 Y4AF8rWVRY2p9pf/nk8JsPeNhsyCicG80EZmgWHs2G6T9QgRNUe3qS/rrydWFWXUeLK45dsZUn
 ZKBvRCUe1k405eKh1dYq11iA1KHNPTfsSQ0kwfZcKRCXEsKdTca1U9y66duK4ocQGvRhsDBUd3
 i7pLTghzVN/IMaAGugEzlhySOuisCW71Yogz6PZ5+2ZyMOOgfUhPx3oVpflDLHBnBqmP7GNLnm
 sifJhsZ/Q1UG6KNLgJw1PPOz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 13:37:28 -0700
IronPort-SDR: It3eFzaf/J8QLJI+9AnCsDyc95s8jHkk0MSBB0hxOBLF6wkN/xiIJUueYojGYXmjEnebfsWPOn
 pNzYUgtqsk1vz+LECY+DZR7JlJkp4yb7/g2qH8WT6XmLbGqWRDqzNGoNttoRT2kcgKq77Z207p
 ALtI7jZt4j9BiucXeIzsU5q2KhdqWxSq9FQy4Qpx/44TU6Cg0x7DHSuOC49R1HBd/W6WRwE3B4
 YkUWNxF1gpH2omyT4qtvKWxCRi0d4OeUb+aedNznfHRxVHiARyJxk2JmB5zFExOxEXUCwb6y2H
 aNk=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 13:38:41 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:38:04 -0400
Message-Id: <20190709203806.17550-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH 2/4] raw: Recognize zoned backing devices
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

The purpose of this patch is to recognize a zoned block device (ZBD)
when it is opened as a raw file. The new code initializes the zoned
model propery introduced by the previous commit.

This commit is Linux-specific and in essence it checks the Zoned
Block Device Model (None/Host-managed/Host-aware) value in sysfs on
the host.

In order to avoid code duplication in file-posix.c, a common helper
function is added to read value of a sysfs entry under
/sys/block/<dev>/queue. Now, the existing function that reads the
"max_segments" value and the the new function that reads "zoned"
value share the same helper code.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 69 ++++++++++++++++++++++++++++++++++++++--------
 block/raw-format.c |  8 ++++++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab05b51a66..dd81dc3301 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1055,33 +1055,53 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
 #endif
 }
 
-static int hdev_get_max_segments(const struct stat *st)
+static int hdev_read_blk_queue_entry(const struct stat *st, const char *key,
+    char *buf, int buf_len)
 {
 #ifdef CONFIG_LINUX
-    char buf[32];
-    const char *end;
     char *sysfspath;
     int ret;
     int fd = -1;
-    long max_segments;
 
-    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
-                                major(st->st_rdev), minor(st->st_rdev));
+    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
+                                major(st->st_rdev), minor(st->st_rdev), key);
     fd = open(sysfspath, O_RDONLY);
     if (fd == -1) {
         ret = -errno;
         goto out;
     }
     do {
-        ret = read(fd, buf, sizeof(buf) - 1);
+        ret = read(fd, buf, buf_len - 1);
     } while (ret == -1 && errno == EINTR);
     if (ret < 0) {
         ret = -errno;
-        goto out;
     } else if (ret == 0) {
         ret = -EIO;
+    }
+out:
+    if (fd != -1) {
+        close(fd);
+    }
+    g_free(sysfspath);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int hdev_get_max_segments(const struct stat *st)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    const char *end;
+    int ret;
+    long max_segments;
+
+    ret = hdev_read_blk_queue_entry(st, "max_segments", buf, sizeof(buf));
+    if (ret < 0) {
         goto out;
     }
+
     buf[ret] = 0;
     /* The file is ended with '\n', pass 'end' to accept that. */
     ret = qemu_strtol(buf, &end, 10, &max_segments);
@@ -1090,10 +1110,33 @@ static int hdev_get_max_segments(const struct stat *st)
     }
 
 out:
-    if (fd != -1) {
-        close(fd);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int hdev_get_zoned_model(const struct stat *st)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    int ret;
+
+    ret = hdev_read_blk_queue_entry(st, "zoned", buf, sizeof(buf));
+    if (ret < 0) {
+        ret = BLK_ZONED_NONE;
+        goto out;
     }
-    g_free(sysfspath);
+
+    buf[ret - 1] = 0;
+    ret = BLK_ZONED_NONE;
+    if (strcmp(buf, "host-managed") == 0) {
+        ret = BLK_ZONED_HM;
+    } else if (strcmp(buf, "host-aware") == 0) {
+        ret = BLK_ZONED_HA;
+    }
+
+out:
     return ret;
 #else
     return -ENOTSUP;
@@ -1116,6 +1159,10 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
                 bs->bl.max_transfer = MIN(bs->bl.max_transfer,
                                           ret * getpagesize());
             }
+            ret = hdev_get_zoned_model(&st);
+            if (ret >= 0) {
+                bs->bl.zoned_model = ret;
+            }
         }
     }
 
diff --git a/block/raw-format.c b/block/raw-format.c
index bffd424dd0..12c2a3f95d 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -369,6 +369,13 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
+static void raw_get_zoned_info(BlockDriverState *bs)
+{
+    if (!bs->probed) {
+        bs->bl.zoned_model = bs->file->bs->bl.zoned_model;
+    }
+}
+
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
                                         PreallocMode prealloc, Error **errp)
 {
@@ -572,6 +579,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_ioctl        = &raw_co_ioctl,
     .create_opts          = &raw_create_opts,
     .bdrv_has_zero_init   = &raw_has_zero_init,
+    .bdrv_get_zoned_info  = &raw_get_zoned_info,
     .strong_runtime_opts  = raw_strong_runtime_opts,
     .mutable_opts         = mutable_opts,
 };
-- 
2.21.0


