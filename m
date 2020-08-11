Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2BDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8B4206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b8IMHkfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8B4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5d8W-0003M8-AW
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7I-0001xD-S7; Tue, 11 Aug 2020 18:51:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7G-0004NG-F6; Tue, 11 Aug 2020 18:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597186294; x=1628722294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2W3FRATOlz7ZU5eCO7umucqwcVhGX67USiGo9cGzhHg=;
 b=b8IMHkfYfUao9BdAsTGbTWC59qg3zyWIQfk97sHyvZ7RckQfwE99cLbH
 HCdAR2IfxVoeHpmig5+KZ0g141XV+IamTrU8Lj2NMdxEdFHMX/wfwjYDY
 yDyfETplAILBNvsPJ+8IbEUhFi1yDxtJyCqPT0sCYoMYsSRGDQvpOScLR
 1aJlnsdXxo3RvDdWlWsgXvbZMicmm2RWbIxszv+9TSP3p/jOtHeTHjnx6
 2KRVc4RpNQUkFBFmZk4DC2Thj3UQ4sIM1kPRCy8HUscTodkv/vOHxogNv
 azIo8WWT0niPJTzrmUZ8+fMI7hnfJKRGDuZLlNZUtJBD/8WIc0GnyHZ9y Q==;
IronPort-SDR: PzPjjWy0KkBvUg7Z0ALcYXjRsJkoEW6KnEQ8l51abMRh9BHCyCqgddbmWsCmU+Yu2b3pxwR+9+
 +v64SqnsTTQLV/BTIAhCiZ3R/X2PYdNZ5okR2DGnx8Y0E81U5Qg7bGA7b3t5RaKYr9LyZFnOa4
 GEDpAW18yRpRLW7T5A6UmoswlNh+Pr8KFDPCEuibmrW8DSaMI8WG4jRt/JpufxNuZHRsGk27C/
 znrFDlw85mfZDvqncItSw0Vobv8ckHU69bQyg9eIL59d8tFefvFbFDDbmX4n8B+yIuo2uezOOU
 W8w=
X-IronPort-AV: E=Sophos;i="5.76,302,1592841600"; d="scan'208";a="144706609"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2020 06:51:31 +0800
IronPort-SDR: yDIVFSOWRTtQkEHkzmuWw57WTRAmrwOAwjrB3VtUTk2dM4SO3+KUUagpiotrhgUNtcTIBCxBFa
 +2qy39/cC5Tw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 15:38:41 -0700
IronPort-SDR: N8N0KnRAvyiDG5tTeQRckcWx2WEav6ah2uPp5BTPZMNrNAvel9QoMx1r+vTP0EYv0rMh9wnLkG
 mVxMggf0vIGQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2020 15:51:29 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
Date: Wed, 12 Aug 2020 07:51:21 +0900
Message-Id: <20200811225122.17342-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=485daf1e4=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 18:51:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If scsi-generic driver is in use, an SG node can be specified in
the command line in place of a regular SCSI device. In this case,
sg_get_max_segments() fails to open max_segments entry in sysfs
because /dev/sgX is a character device. As the result, the maximum
transfer size for the device may be calculated incorrectly, causing
I/O errors if the maximum transfer size at the guest ends up to be
larger compared to the host.

Check system device type in sg_get_max_segments() and read the
max_segments value differently if it is a character device.

Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Fixes: 9103f1ceb46614b150bcbc3c9a4fbc72b47fedcc
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 55 +++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 094e3b0212..f9e2424e8f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1108,6 +1108,7 @@ static int sg_get_max_segments(int fd)
     int ret;
     int sysfd = -1;
     long max_segments;
+    unsigned int max_segs;
     struct stat st;
 
     if (fstat(fd, &st)) {
@@ -1115,30 +1116,38 @@ static int sg_get_max_segments(int fd)
         goto out;
     }
 
-    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
-                                major(st.st_rdev), minor(st.st_rdev));
-    sysfd = open(sysfspath, O_RDONLY);
-    if (sysfd == -1) {
-        ret = -errno;
-        goto out;
+    if (S_ISBLK(st.st_mode)) {
+        sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
+                                    major(st.st_rdev), minor(st.st_rdev));
+        sysfd = open(sysfspath, O_RDONLY);
+        if (sysfd == -1) {
+            ret = -errno;
+            goto out;
+        }
+        do {
+            ret = read(sysfd, buf, sizeof(buf) - 1);
+        } while (ret == -1 && errno == EINTR);
+        if (ret < 0) {
+            ret = -errno;
+            goto out;
+        } else if (ret == 0) {
+            ret = -EIO;
+            goto out;
+        }
+        buf[ret] = 0;
+        /* The file is ended with '\n', pass 'end' to accept that. */
+        ret = qemu_strtol(buf, &end, 10, &max_segments);
+        if (ret == 0 && end && *end == '\n') {
+            ret = max_segments;
+        }
+    } else {
+	ret = ioctl(fd, SG_GET_SG_TABLESIZE, &max_segs);
+        if (ret != 0) {
+            ret = -errno;
+            goto out;
+        }
+        ret = max_segs;
     }
-    do {
-        ret = read(sysfd, buf, sizeof(buf) - 1);
-    } while (ret == -1 && errno == EINTR);
-    if (ret < 0) {
-        ret = -errno;
-        goto out;
-    } else if (ret == 0) {
-        ret = -EIO;
-        goto out;
-    }
-    buf[ret] = 0;
-    /* The file is ended with '\n', pass 'end' to accept that. */
-    ret = qemu_strtol(buf, &end, 10, &max_segments);
-    if (ret == 0 && end && *end == '\n') {
-        ret = max_segments;
-    }
-
 out:
     if (sysfd != -1) {
         close(sysfd);
-- 
2.21.0


