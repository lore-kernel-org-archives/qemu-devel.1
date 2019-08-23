Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C941021874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SSk87Ni7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C941021874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FGH-0005pl-8e
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F7V-0005ly-3V
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F7T-0003QA-Mv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:21:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F7Q-0003Ie-B0; Fri, 23 Aug 2019 15:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566588065; x=1598124065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WrGHKVduBl42d9CD8UFRTIZ6FP7W7UcEwBBJuvUCUsc=;
 b=SSk87Ni7Wkv9PnaWC44SGc/7oNxI6HmTeAA0O+xlp62lypnS7IQPnnIA
 LK6qTvyL/1LMsVMRmpL2UmB8JPRHzCwh8lQiK4zOo7RGqJagqoddCbaM4
 nRlUnjy7vrBWbyAMaG1q6yX48dWY9sgXGBqC1HqwZ4lEqXNRAxLmvfH48
 Wsjy9/Pem64hegVltkKcFZx6NOvbsbSHy/4q4jogaBthCkf3m1oWHqY+t
 lQxQhgUntAEE+Bc/vioaZQxFnIrA92MUW1Vl0zs2iaAJq5OVC+Aeyj1WX
 IM/H7b3cTct3gt1AL1oh9tiZwNdP5t/K6STBMQLOhq+2iYbj82cf89gRT A==;
IronPort-SDR: 7TDxJkkY80ftGRUZDVWUKGrMO1rB06Ma78l8uZ/JVQ19vlAEW442gb9VbRk8JQ7xu/nDvUyJ1s
 8ANHb4Dh8uhxyXWhbrxG54VTsKtQdI9SAJNP1KCzTeysZkNO4TMPMhQc6Yd6cQAuXrLBLwwUqR
 geG6TbBvk9vdc+DHH8YQWcpkK0laivfwdD8QeEZTh1CvzHd69RAYkhi+VDE/U53VLvBGyuv/eg
 cG7pWtbGh0Sd8b9Q0XlnmMtheDza6szikPurkTvlhen5kJ3LV+iIz/zl5sCjHOcGL37WSg1/qA
 9JA=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117476227"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:21:00 +0800
IronPort-SDR: IRIgi8xKDjfNlG7G6m9TnMNSStlPVwRkuxAyo4Nb1Ot/8Wm3deTvvFf1x6/Q9qLMwywaXKwPPK
 r17eym4OUj/TwsSuUARXCXZnhHtZnqd5/g8p+5BPpXNehq/ZwNRqJ4VJi1WUbUbJxeQqcYtxT1
 JfvydMzBu2wyTC+lQjss8P7pKGCOxJ+DwzcfmoMpjPo+CWs/KDenYnMI4Q4cgiOOJMeQhmem4F
 eHjles3kvYdeEjlbTxn/X0oQci7PWdGkDxh3nU8sTEXMJlAHqWCpEFSWVmMD4D7g9W67dzo6hu
 KIYYqHO2aifc8vZsDEN2dGMk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:18:16 -0700
IronPort-SDR: jur9OoZSeAp8O+ImqrN5n2zeyG8Dxi7NXzjrwIxQxrND6ITGuwYW5bHr3LRk2m4w7fBcwBKAGO
 +ZumTmoJMd8SFCPXAIY7m1jfO8iOs9o2oM8gjR/vGfw8zEM6NU5bOnnF+pbICvP5XDpCUPrb4X
 7h0PIOMSt97hlI4nc55VScJUF75CxUtGkOI2FsfmTn5dRIQn8PfwTqqrPQ6C73wglrljxh3ohN
 I91O54xbo4sJ8FDpQ+tWZBfgZvbCmunn/O+D3WqdvYAAmQm5VJO0fRPFbNaAohCuv07i4Vdr8a
 /eo=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 12:20:58 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:20:54 -0400
Message-Id: <20190823192056.21091-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823192056.21091-1-dmitry.fomichev@wdc.com>
References: <20190823192056.21091-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v4 2/4] raw: Recognize zoned backing devices
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

The purpose of this patch is to recognize a zoned block device (ZBD)
when it is opened as a raw file. The new code initializes the zoned
model propery introduced by the previous commit.

This commit is Linux-specific as it gets the Zoned Block Device Model
value (none/host-managed/host-aware) from sysfs on the host.

In order to avoid code duplication in file-posix.c, a common helper
function is added to read values of sysfs entries under
/sys/block/<dev>/queue. This way, the existing function that reads
the value of "max_segments" entry and the the new function that reads
"zoned" value both share the same helper code.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 74 ++++++++++++++++++++++++++++++++++++++--------
 block/raw-format.c |  8 +++++
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..d9f2fc5e46 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1067,15 +1067,13 @@ static int sg_get_max_transfer_length(int fd)
 #endif
 }
 
-static int sg_get_max_segments(int fd)
+static int hdev_read_blk_queue_entry(int fd, const char *key,
+    char *buf, int buf_len)
 {
 #ifdef CONFIG_LINUX
-    char buf[32];
-    const char *end;
     char *sysfspath = NULL;
     int ret;
     int sysfd = -1;
-    long max_segments;
     struct stat st;
 
     if (fstat(fd, &st)) {
@@ -1083,23 +1081,45 @@ static int sg_get_max_segments(int fd)
         goto out;
     }
 
-    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
-                                major(st.st_rdev), minor(st.st_rdev));
+    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
+                                major(st.st_rdev), minor(st.st_rdev), key);
     sysfd = open(sysfspath, O_RDONLY);
     if (sysfd == -1) {
         ret = -errno;
         goto out;
     }
     do {
-        ret = read(sysfd, buf, sizeof(buf) - 1);
+        ret = read(sysfd, buf, buf_len - 1);
     } while (ret == -1 && errno == EINTR);
     if (ret < 0) {
         ret = -errno;
-        goto out;
     } else if (ret == 0) {
         ret = -EIO;
+    }
+out:
+    if (sysfd != -1) {
+        close(sysfd);
+    }
+    g_free(sysfspath);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int sg_get_max_segments(int fd)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    const char *end;
+    int ret;
+    long max_segments;
+
+    ret = hdev_read_blk_queue_entry(fd, "max_segments", buf, sizeof(buf));
+    if (ret < 0) {
         goto out;
     }
+
     buf[ret] = 0;
     /* The file is ended with '\n', pass 'end' to accept that. */
     ret = qemu_strtol(buf, &end, 10, &max_segments);
@@ -1108,10 +1128,33 @@ static int sg_get_max_segments(int fd)
     }
 
 out:
-    if (sysfd != -1) {
-        close(sysfd);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int hdev_get_zoned_model(int fd)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    int ret;
+
+    ret = hdev_read_blk_queue_entry(fd, "zoned", buf, sizeof(buf));
+    if (ret < 0) {
+        ret = BLK_ZONED_MODEL_NONE;
+        goto out;
     }
-    g_free(sysfspath);
+
+    buf[ret - 1] = 0;
+    ret = BLK_ZONED_MODEL_NONE;
+    if (strcmp(buf, "host-managed") == 0) {
+        ret = BLK_ZONED_MODEL_HM;
+    } else if (strcmp(buf, "host-aware") == 0) {
+        ret = BLK_ZONED_MODEL_HA;
+    }
+
+out:
     return ret;
 #else
     return -ENOTSUP;
@@ -1121,9 +1164,10 @@ out:
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
     if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+        ret = sg_get_max_transfer_length(s->fd);
 
         if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
             bs->bl.max_transfer = pow2floor(ret);
@@ -1133,6 +1177,12 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
         if (ret > 0) {
             bs->bl.max_transfer = MIN(bs->bl.max_transfer, ret * getpagesize());
         }
+
+    }
+
+    ret = hdev_get_zoned_model(s->fd);
+    if (ret >= 0) {
+        bs->bl.zoned_model = ret;
     }
 
     raw_probe_alignment(bs, s->fd, errp);
diff --git a/block/raw-format.c b/block/raw-format.c
index 42c28cc29a..a606e4a7fe 100644
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
@@ -578,6 +585,7 @@ BlockDriver bdrv_raw = {
     .create_opts          = &raw_create_opts,
     .bdrv_has_zero_init   = &raw_has_zero_init,
     .bdrv_has_zero_init_truncate = &raw_has_zero_init_truncate,
+    .bdrv_get_zoned_info  = &raw_get_zoned_info,
     .strong_runtime_opts  = raw_strong_runtime_opts,
     .mutable_opts         = mutable_opts,
 };
-- 
2.21.0


