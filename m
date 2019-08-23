Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F14C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F32B21874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lA8F8llc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F32B21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FD5-0002tO-LQ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F97-0007eV-O4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F96-0004Lk-5O
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F92-0004HC-SZ; Fri, 23 Aug 2019 15:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566588165; x=1598124165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WrGHKVduBl42d9CD8UFRTIZ6FP7W7UcEwBBJuvUCUsc=;
 b=lA8F8llcTXjF4JXwDt+cPEmfcHWRY1sWu0W4Aa9hva0rqHx6n994SxFC
 ISGhKUjwSkuh4QwFs3i3JFhw49PkMkkHIlkmsJEv5ZcI2VUBWoZEeDXM0
 kQgsDsUSS4NMnYqjY2zjafIS4I8bLTL0RnWsCDE0vgRY7YNWhs/9WHVQ+
 wuG1BGUzfWopBsJtDjyUw8YV+oTmn1PWLfCFRAFW9le0phNOUDl2Kua4y
 dnrUQUGihBjo6rJytJOdPR8BFVHVtLRt+0D8Z/ZvrcQ/5PBsO9e+x4MX4
 QcKYNgljOGJPhPs7SEphetBxTMH43cjUwoybfXXkto8IR9E407WXCpePl Q==;
IronPort-SDR: XASYu8BXypx/rDPfhAB4LoNZhGoyCSzvlO7N40V281ATjQ7FTcy8GTx9GxYYM6HSlbRc9FgZSD
 6LHidfH0c09bHEkjloBEJjihtJDfed3RbQ741dsZlzcywm6Fe7LUhpUNAS9Sk8rMcAKAlFvb46
 gfLNNif3CSlDKnNcQrqRxAVtJ4Hdq12GFiADGxKiGpEBlnS1dH8djQlQp62yV7IT16xue4lTXv
 Tk7puQ1IqJDBxoPzXC7qKnpA/JGrlRYdJZYtY0HabRHh6EAB80JRuysHnmd8gm+rCiG47lm897
 FwY=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117476289"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:22:31 +0800
IronPort-SDR: RBqpa2s6pCFL8WXrHSv16561IepU9cCbUl1PLdofNbtYc9jCmeMzgwlIEQWKSmAfuTr8lehQ9Y
 7u6NCLOa9zACVu9HfCZyI5hWrSeQq0qijYCQ0vwIiL7n+N1XA28nrv3aKslXkWWyL2tT6D4S0I
 IKtIcBwjC5gULRT0SxC/k4WI4iirsQv6yb2vGVFgtwLh9ymzEyHi+NE7kEhfGUvA1Y/LbyO3Wi
 HxKh82bcrEEO45QFKEwNoZBAnRPpccSWqrRXLO/3O1V9+8iAbOHHgZytr3kUFAw6LN4HSwLT4U
 SXbLJ2NRf73gf9+N0PAn9yLo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:19:48 -0700
IronPort-SDR: L5FGHEN/iSt34WooI23cmjDB9NQ8pdQg2y33QUtOeVbz1qlZFdM3DrUUwZjjAoOKZhsxWMjdSA
 CFRHFMNVZKgu8eYFe+WL3ZuqmTDOAQKnxwA9s7pFSIp0XDfMA0MTdEQAgoI4mQsTRkKyMuhfdn
 fmE8pc94IRWOcUbRnRyyfF0BzQ8LjRNwjaTNVx0IydupYR8STEo1dBdlAhFPkZwVOL7RwAfkyo
 RHyRBgzOlPSLftrOZBc5E56eLt5nprus6YGXv8QdebL7QwTBLDqwkQq+4AJELZSYM7GPnLhioE
 zH0=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 12:22:30 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:22:24 -0400
Message-Id: <20190823192226.21154-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
References: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
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


