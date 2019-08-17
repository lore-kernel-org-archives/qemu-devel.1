Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47721C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 21:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D55421019
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 21:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfMEiH+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D55421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz6AR-0001lQ-Oi
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 17:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1hz68o-0000iZ-Vi
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 17:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1hz68m-0005va-Ly
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 17:21:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1hz68f-0005qf-4T; Sat, 17 Aug 2019 17:21:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id u16so4887736wrr.0;
 Sat, 17 Aug 2019 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+wSVH5McUUvVIG1OHesxwhqyk7C1/TTDGaomgkwHm4U=;
 b=VfMEiH+UcVq8GdXDRrw8N+ZSy7WFPvqO/QrXjiUcvIFXKQWDxFc1GxtU1+qSokBxAv
 rvzXXaAIwbmZUZs9hP0qDqKiTtvahtghL9U94JTh4H+hb1yRq3BsOUqFpM8Pv3RJ1CJ4
 fdEe6bweopEuq6rQ1G/8CD6wN3UPGcVCX15B3GUWdNV4Z/n3GQI9HPXweWiHUJplivO6
 IwRFXZElEBrwGMUCmitC4qtYJ2z0bqDfeTdC1QXi0XgFI1u/WOnEWTBl8CRBp44g+YB8
 HfaoFf1A+gp9bZgRHdjc3F4KH8TgiXh1/m3NDfFtqPAgtXTR56x9ttqr28kUUYUy4305
 kb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+wSVH5McUUvVIG1OHesxwhqyk7C1/TTDGaomgkwHm4U=;
 b=DUJs9O5zSabMkGLzcywsEz8UHrLAvAP45Dyh1THGRKNLcGDCzrZTsFeBfia742wtnQ
 plCayg/ApXyD1UQD2xcxszUakMTlQUoKt57HVr16wF4DNmpAnQ/wVl1mVpjjaiBdpljR
 02vSjBWDxMMyXhCecCXyqcIr1+ojXbLl3wLSxmIJCYhC0VgIpF7ORrImLfVEGw3V4S4J
 6tofBe/BJ/ZD7bEny+Hnt5bVkmmIGHjsVKXie1KFxoie5a/261KCKvgq66Wj268UIwsc
 VpDUqM1HZC13iIZPAfx9sruOa30i5Cb1ITPPk62/uzw10iuHm7ud3F/tun3UIbC68cJF
 PAUw==
X-Gm-Message-State: APjAAAUnX1PzgOtTiqLzh0uWMETBn9P9XFv3zE2Dk4XIsxMOSHkYLvlo
 0cIGizEnl9jV5fxR/+KGEx7Hq4reZ1BIsA==
X-Google-Smtp-Source: APXvYqxwFOMlTEyXPiRHB7nDh+ZJkQXSIQbJg/E2ajkCBP7P+sykUUR8x3DjrWxSdleLuT6tFUOPEg==
X-Received: by 2002:adf:d1b4:: with SMTP id w20mr17862110wrc.301.1566076886637; 
 Sat, 17 Aug 2019 14:21:26 -0700 (PDT)
Received: from sparse-local.redhat.com (93-173-46-43.bb.netvision.net.il.
 [93.173.46.43])
 by smtp.gmail.com with ESMTPSA id z6sm31043535wre.76.2019.08.17.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 14:21:26 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Date: Sun, 18 Aug 2019 00:21:11 +0300
Message-Id: <20190817212111.13265-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] block: gluster: Probe alignment limits
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement alignment probing similar to file-posix, by reading from the
first 4k of the image.

Before this change, provisioning a VM on storage with sector size of
4096 bytes would fail when the installer try to create filesystems. Here
is an example command that reproduces this issue:

    $ qemu-system-x86_64 -accel kvm -m 2048 -smp 2 \
        -drive file=gluster://gluster1/gv0/fedora29.raw,format=raw,cache=none \
        -cdrom Fedora-Server-dvd-x86_64-29-1.2.iso

The installer fails in few seconds when trying to create filesystem on
/dev/mapper/fedora-root. In error report we can see that it failed with
EINVAL (I could not extract the error from guest).

Copying disk fails with EINVAL:

    $ qemu-img convert -p -f raw -O raw -t none -T none \
        gluster://gluster1/gv0/fedora29.raw \
        gluster://gluster1/gv0/fedora29-clone.raw
    qemu-img: error while writing sector 4190208: Invalid argument

This is a fix to same issue fixed in commit a6b257a08e3d (file-posix:
Handle undetectable alignment) for gluster:// images.

This fix has the same limit, that the first block of the image should be
allocated, otherwise we cannot detect the alignment and fallback to a
safe value (4096) even when using storage with sector size of 512 bytes.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/gluster.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/block/gluster.c b/block/gluster.c
index f64dc5b01e..d936240b72 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -52,6 +52,9 @@
 
 #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
 
+/* The value is known only on the server side. */
+#define MAX_ALIGN 4096
+
 typedef struct GlusterAIOCB {
     int64_t size;
     int ret;
@@ -902,8 +905,52 @@ out:
     return ret;
 }
 
+/*
+ * Check if read is allowed with given memory buffer and length.
+ *
+ * This function is used to check O_DIRECT request alignment.
+ */
+static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf, size_t len)
+{
+    ssize_t ret = glfs_pread(fd, buf, len, 0, 0, NULL);
+    return ret >= 0 || errno != EINVAL;
+}
+
+static void gluster_probe_alignment(BlockDriverState *bs, struct glfs_fd *fd,
+                                    Error **errp)
+{
+    char *buf;
+    size_t alignments[] = {1, 512, 1024, 2048, 4096};
+    size_t align;
+    int i;
+
+    buf = qemu_memalign(MAX_ALIGN, MAX_ALIGN);
+
+    for (i = 0; i < ARRAY_SIZE(alignments); i++) {
+        align = alignments[i];
+        if (gluster_is_io_aligned(fd, buf, align)) {
+            /* Fallback to safe value. */
+            bs->bl.request_alignment = (align != 1) ? align : MAX_ALIGN;
+            break;
+        }
+    }
+
+    qemu_vfree(buf);
+
+    if (!bs->bl.request_alignment) {
+        error_setg(errp, "Could not find working O_DIRECT alignment");
+        error_append_hint(errp, "Try cache.direct=off\n");
+    }
+}
+
 static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error **errp)
 {
+    BDRVGlusterState *s = bs->opaque;
+
+    gluster_probe_alignment(bs, s->fd, errp);
+
+    bs->bl.min_mem_alignment = bs->bl.request_alignment;
+    bs->bl.opt_mem_alignment = MAX(bs->bl.request_alignment, MAX_ALIGN);
     bs->bl.max_transfer = GLUSTER_MAX_TRANSFER;
 }
 
-- 
2.20.1


