Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4719C20820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AKe/Oq4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4719C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dUI-000258-DB
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOy-0006Jh-EH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOt-0007bC-0Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOp-0007X8-EZ; Wed, 04 Sep 2019 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567630867; x=1599166867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LPK5dv7NDBXIbuHf7ST8MYcA/NaQLO9UasvmcvccZu0=;
 b=AKe/Oq4A8aSkJR/PD5brS3TKiL5bkbRrPPWTlKkhEr5SMLYJrZODy1pq
 2kwPLhw5oFxwNdTUYFGYu1bIeFKY4xNLlt3ecid9EXKFL03Om+I+RjlBQ
 7A5FM6AyKrKlPWsy3zDJFCMeHukk2/Mja/oqcpbUTPYeKqEdLJlPgfeGT
 Cf/ETlNX4DRVms2GNVGRXAnLUnmjwHfZImY7hveH06Oztf6zqJ4eANzld
 fOiOo4tnA5G8eX529cCxuRuT/LgP5ztDqO0Fkrwte1vsJyre6qaHmpyW8
 SmSq6nZsDpimjZt+s8gapbGfoagMAzTGdNTOF8bXiGIyW78lEP2A5mUb7 Q==;
IronPort-SDR: 2R7GuYyY6Tuj6dacHV55eIMJnzBgsRLxpq+zyprLLsrBpe5NcaRPhnSKc8MH+4/QFALI9x5hhR
 lDzDPtb/oLY0B545h0eYf+ir4/A6RAtP9dtO+FG/eeR4WEXCmJ9j0Yxjq1XCjt7Qc8CwUuEp0V
 OicX4bUnxVxEejKN42JUlB8kK6RpQBObTQZMMcLIfdtc0BcYUNt1/nFPjPOhDLIwGzQqrY5QMG
 4YWfp/Asl0GC79phfw8ZuBAoxFhn6OH8g2Erh5g9mo7pQwhhsjDqiOomO5bcRahK4Dz2Lah8u4
 RSs=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117451661"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:01:04 +0800
IronPort-SDR: HVnHIv23UbwaJZt+pgfCJYhBmf30iHrQXV+/sbFdXHzPue5hG2monWpgJIVXJyFC3DrattTv3s
 PNa+xOwHqL64IqPVTvKfL7sSViOroQyxOhUisWYNjiP/sbW2tJYfuHAGeX2llmNPW8piR1yeZP
 5veBR6KLBZgyH5a+oE9AFUHqRM0ACJG0p78Bzi1kd9Oope9vPofomZvIQeVeWJb6g8FR5V93IK
 jJb+7VBJ3WF/52vw2HYWZVdF6GODE617g89mUV0up2uSdbA6CxgGno/hojmHl34CjdZZ4faEhd
 +nIutWjbpX5Zb8DRm3sGvyZY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:58:01 -0700
IronPort-SDR: y9e8+neQLroy0eQNSwHL/xZOw84PdorXa1Ip0129/hx1itYP55WMHycJhhPVwHB2cbD9fQCaMt
 Agkz8DmK7wCVqN8uO3SM9xd7cSU6Um1y1EhAD4Exl1n8be9JKHeItOJSy5CzTAMg/SO02L+7fw
 zJlfzwjccnkEH2EbzJae4Ly1RDIwEiO1sFKCl6O5h/Cb9zhn0whylWTbQkenlXP+I4yt49rMIH
 VmowHurfx+qhVG0khK0vuhdUpR4l6Y2HseifEXNve437cnMYCuxuViHgJDc0ni/iH2kKs26Faa
 OU4=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2019 14:01:03 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Wed,  4 Sep 2019 17:00:58 -0400
Message-Id: <20190904210100.10501-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v6 2/4] raw: Recognize zoned backing devices
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
 block/file-posix.c | 75 ++++++++++++++++++++++++++++++++++++++--------
 block/io.c         |  5 ++++
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..c7e1aff6eb 100644
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
@@ -1108,22 +1128,45 @@ static int sg_get_max_segments(int fd)
     }
 
 out:
-    if (sysfd != -1) {
-        close(sysfd);
-    }
-    g_free(sysfspath);
     return ret;
 #else
     return -ENOTSUP;
 #endif
 }
 
+static BdrvZonedModel hdev_get_zoned_model(int fd)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    BdrvZonedModel zm = BDRV_ZONED_MODEL_NONE;
+    int ret;
+
+    ret = hdev_read_blk_queue_entry(fd, "zoned", buf, sizeof(buf));
+    if (ret < 0) {
+        goto out;
+    }
+
+    buf[ret - 1] = '\0'; /* replace the newline character with NULL */
+    if (strcmp(buf, "host-managed") == 0) {
+        zm = BDRV_ZONED_MODEL_HM;
+    } else if (strcmp(buf, "host-aware") == 0) {
+        zm = BDRV_ZONED_MODEL_HA;
+    }
+
+out:
+    return zm;
+#else
+    return BDRV_ZONED_MODEL_NONE;
+#endif
+}
+
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
     if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+        ret = sg_get_max_transfer_length(s->fd);
 
         if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
             bs->bl.max_transfer = pow2floor(ret);
@@ -1133,6 +1176,12 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
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
diff --git a/block/io.c b/block/io.c
index 0fa10831ed..147c320061 100644
--- a/block/io.c
+++ b/block/io.c
@@ -157,6 +157,11 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
             return;
         }
         bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
+
+        /* Propagate zoned model */
+        if (!bs->probed) {
+            bs->bl.zoned_model = bs->file->bs->bl.zoned_model;
+        }
     } else {
         bs->bl.min_mem_alignment = 512;
         bs->bl.opt_mem_alignment = getpagesize();
-- 
2.21.0


