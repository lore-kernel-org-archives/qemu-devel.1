Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B7C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7233D22387
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i3fFuUlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7233D22387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq399-0001af-Fv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44411)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38Q-0007PQ-0W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001DN-PE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001Bd-HQ; Tue, 23 Jul 2019 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563920389; x=1595456389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7tzlz4nS/NDt/He6kF5q4UiaEdfHTksSd4cZbWW1HH0=;
 b=i3fFuUlz1zTN8wWkfaem2V2LJ+U+15M4fd4u+D8RfjFXR0G26pa++n9f
 AGzM4yA76VWjBUvdKZExi8fE8K+4tRW3IFW0BEvqBIXLHEjBwCduGHhDs
 P2kUoUVmx+pXOGzIkHdVVFQg0nHiV+N0/eUC5fMxn0Eu+IlnFb8wDxP89
 p7AqcDbeBNYUJ1L6ZAhZ3dsJnAuMi7l1QqcBozHlI5xhnLrEVKTuErEbf
 9076cHHQtNExJZxtbqVWLJTO5z0oT1AMDzwv/TtFM25oi48XqEBGPsv9k
 MgTL6sDdaPvRw5VBCtaYmadDwRquvkd77jcaacpH940xlCO1YIu/pDTTr g==;
IronPort-SDR: k9/wLCFVBpJTfl9Eks+CWkdLYj7jBU0xMcjMZsz6Xsz0JURzK+VtBHdx31EsMdukOJyWEwfDja
 BmjfXqY5m+YLvGbxZznbOQNzVyMAPJxgg2ALMmfkLaqjOTi5ElC2Jaz9DD2LHrewviUtwW89p2
 dfROq1Y1eOSqngwkyryfxJUZOzMfuQDewyZZmLbgCkEBjw/0AyDuIKRdOoV+7/3zOnEF1/iYo9
 XB2Vr7MSieoxsyR2m3MQankYRxlnxLwpc2KzhoZEW0OJKH2Y2Avm4CJbMTYoTdpw1i7HWAJKCo
 rlg=
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; d="scan'208";a="113843257"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2019 06:19:43 +0800
IronPort-SDR: guTssZCIutR7dLUQEYg5O9kggP9e5rz0nym/Okw2EzOz1ITBHArD7mEiqIIkLDcSuJsDVQEvvM
 2PVPIFRIU0V/AIHTGsNXX8ZxyNpmpnvi1DTQeADADyhbFFt0465ZnOn5pp8FXBILkgkwbOvLDw
 Wnty+aKgNUpfz3Qy+91M74NVVNb/02HiG9nGQnQHD0YmirjZ5KGtQxTCt6zd5r5/1vJGsQnnk4
 U3SL2QYyNQTkTeR8d5AM8zBkX5c+guhJRhN+8xJ8yBRd2uOkCkbNTQ1ex1Sv/zLTftOzvVbHI2
 nu1vUz+tcbLF8xd9OWqveFom
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 15:17:57 -0700
IronPort-SDR: 0dE3py2Mv2Uv4cO2LZaPSlYX2bzrbdf31e2hiqVyb0R+fKqLu2dRG9+vhJ0dxcap9ArzY8IBCs
 uOpiUWdXZbGPKxWw272WDkmIMjQJ608IVvZPByQJXjCOwbm/KQ3Y3skA0DERqVcmoXcZty8YO/
 je6fT/9cllXOIG4UnA1ZpYM6YsymzMJKvhy8qZ0rA4FAqJKh7EUo3Xnf3SYh5LAfyI6ezA26Ph
 OYkakKmYgnbYEHhWuuYJ3DWHyd/p7QgTWbsLLJZrHBoTTsMBq/lOIPLTcQD46khQ66+/tnrNo5
 VPw=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 15:19:43 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Jul 2019 18:19:38 -0400
Message-Id: <20190723221940.25585-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
References: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v3 2/4] raw: Recognize zoned backing devices
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
index 4479cc7ab4..e307cab7a4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1053,15 +1053,13 @@ static int sg_get_max_transfer_length(int fd)
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
@@ -1069,23 +1067,45 @@ static int sg_get_max_segments(int fd)
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
@@ -1094,10 +1114,33 @@ static int sg_get_max_segments(int fd)
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
@@ -1107,9 +1150,10 @@ out:
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
     if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+        ret = sg_get_max_transfer_length(s->fd);
 
         if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
             bs->bl.max_transfer = pow2floor(ret);
@@ -1119,6 +1163,12 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
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


