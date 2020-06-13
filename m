Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A88C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 17:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CE220789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfISI6HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CE220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk9ek-0003DY-UI
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 13:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jk9e9-0002jD-1R; Sat, 13 Jun 2020 13:08:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44164)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jk9e7-00067g-EU; Sat, 13 Jun 2020 13:08:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id y17so12924089wrn.11;
 Sat, 13 Jun 2020 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SG++uslznfXy99uBvdaKG+V9ElifBR7IePN6lVFVf+I=;
 b=JfISI6HSXlxERtSsyxVVpkxYuhQcM8YPJ3nnkh9ujrLHieCMQrPqO7IgoZeeGs0QEN
 IyvHekl9CZecN+j6NTyP85fK4Yh5hdGx9dNLTuCnPLYW6IanrPgK6NM8uZ14iswoA0KN
 NZfh6q6DHnENkbeThmAdft75Dx+9VZENKLOKwdrjEsHFfJZYipb/U9iRPxyc16le+URE
 r64lgqw/FQPzep9lv/XVfy+AvXUhp/PnagxLpMwWkbMow4xLyBlrBBUoh5yGdRnDnhyC
 mwIDQx7BigXZOgmSPrvkKL6kkR8aXMVz0pB35RJtiqa7SsrN1xKSmHuuJKQU2ab3W3nv
 R4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SG++uslznfXy99uBvdaKG+V9ElifBR7IePN6lVFVf+I=;
 b=NAjnSQckxtPsX9PtbfhOSWmibnKPIBYega0uNynvfpplayqIjkgZ0P33GSTcfFTNeS
 AYi1dHOFD2krfY3R2PwfeqZ+Yk8RKarFvtexE5yQjwK4Iakvx2kIcO/jzOSCjezR56I/
 99aJnBFvU3p3xtbeB2Avp6ysFuRt050fTJLGiJ2+NjzJZvKRxFwa/ie2JVxb33458eAI
 y7tkOJ7xBZxp0B7kk1loRTQmSinL4Ib8l+dX0rvwWSvTWWz3R+UhRsF/Ft3Cnzsq44WM
 VqJ4mytQxcaOS2HAlsG1gG+uFkz7IfGVCr+4IYbXDm2ALdyxYGFnph/wu4mlZf8wCfJl
 pS2g==
X-Gm-Message-State: AOAM530vDB9PVfCeDEFk1jb4zkfUDHBJShxWSZaWrylRzTgMVF521ERE
 XFkkxHlcVPFc2cpYS3Ol9wFHujRha/E=
X-Google-Smtp-Source: ABdhPJxM15yp5nII159qaWT5DEF1g5STvlwSQYp+XcBs1l/yszs817vx0BJevipodCp3I5KKGLZUAg==
X-Received: by 2002:a5d:5601:: with SMTP id l1mr21941168wrv.254.1592068109666; 
 Sat, 13 Jun 2020 10:08:29 -0700 (PDT)
Received: from localhost.localdomain (89-138-226-152.bb.netvision.net.il.
 [89.138.226.152])
 by smtp.gmail.com with ESMTPSA id d18sm15352555wrn.34.2020.06.13.10.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 10:08:28 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] block: file-posix: Fail unmap with NO_FALLBACK on block device
Date: Sat, 13 Jun 2020 20:08:26 +0300
Message-Id: <20200613170826.354270-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Punching holes on block device uses blkdev_issue_zeroout() with
BLKDEV_ZERO_NOFALLBACK but there is no guarantee that this is fast
enough for pre-zeroing an entire device.

Zeroing block device can be slow as writing zeroes or 100 times faster,
depending on the storage. There is no way to tell if zeroing it fast
enough.  The kernel BLKDEV_ZERO_NOFALLBACK flag does not mean that the
operation is fast; it just means that the kernel will not fall back to
manual zeroing.

Here is an example converting 10g image with 8g of data to block device:

$ ./qemu-img info test.img
image: test.img
file format: raw
virtual size: 10 GiB (10737418240 bytes)
disk size: 8 GiB

$ time ./qemu-img convert -f raw -O raw -t none -T none -W test.img /dev/test/lv1

Before:

real    1m20.483s
user    0m0.490s
sys     0m0.739s

After:

real    0m55.831s
user    0m0.610s
sys     0m0.956s

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3ab8f5a0fa..cd2e409184 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1621,6 +1621,16 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
     /* First try to write zeros and unmap at the same time */
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    /*
+     * The block device fallocate() implementation in the kernel does set
+     * BLKDEV_ZERO_NOFALLBACK, but it does not guarantee that the operation is
+     * fast so we can't call this if we have to avoid slow fallbacks.
+     */
+    if (aiocb->aio_type & QEMU_AIO_BLKDEV &&
+        aiocb->aio_type & QEMU_AIO_NO_FALLBACK) {
+        return -ENOTSUP;
+    }
+
     int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            aiocb->aio_offset, aiocb->aio_nbytes);
     if (ret != -ENOTSUP) {
-- 
2.25.4


