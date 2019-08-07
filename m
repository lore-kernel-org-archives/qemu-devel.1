Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A4EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E7421E71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND0QVaF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E7421E71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMpS-0007NX-0w
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hvMom-0005xO-2V
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hvMol-0008Vo-19
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:32 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hvMok-0008VS-Tc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:30 -0400
Received: by mail-qk1-x743.google.com with SMTP id s145so65919906qke.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kkvGcqaG6Hw21CZ6CMR4F3QU5tZjnOVQB5zjN4lycZY=;
 b=ND0QVaF0LBULJ/dWcaXXlRMEYtojW4/DZ1Q3fBgV86/PuowwVee2vxF88gl8kVp9yl
 s7ya5tw64Txcys4KX+0H80xtnEyJAMP+KYJ665DEJ88x2LjtNF3LGMIIvZLAD/2maxAM
 lC1uJ0zJrh3gr80EvIlMtj0fpiiCJJYGqduV1Fq1POL8xLn3Pmd3gCVBWuM1NDTRtnV+
 MQhI8i8FkybEpBj/g4lRmtRwjtMBWKAStPa2byQIIudspdv2cdNSoqipMnT+Sz3koQaf
 Ti7pTyOuZSbHQwuL66euQeZDuippdleAdTuHDaop7XiV3hg8pWzboNqf1Bkh7fPGtFXp
 VegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kkvGcqaG6Hw21CZ6CMR4F3QU5tZjnOVQB5zjN4lycZY=;
 b=bf0zXhrbSes/LawDyVlGKhtU+wslPm9AnayuhUiowvXW7+p10QmVaJxcsNnPt8Jmvt
 UzcojSo4mHLNB2BscXC/oz4o80Mii2zgX/UOMqmZFIJzS4ZzySh+dwGQTeQS+bYfbOCb
 Q+gAqNU+V3DmAtxDZAxr57zMYsGvCnoWEbc5l4s4dtZkxXUwwHrW6IF1f9ol7x3zBmQY
 A8iJVyjW/yxoxPQUKPxoZ4O2KrKn6PZmJw0lug7BMabptrCnZ5cZvHL2YC+k2JDvlRw3
 +Wc/h+/M4I/l/JGWGVpYVBqzpD6kNyR9p8vCVnFMnziwwIi+Skexn/sxvCu1T4M3DXkc
 7F0w==
X-Gm-Message-State: APjAAAUR1nK/rjKPdy9n48iUPPE70SAn7jjf4+j0wVilKmImNIcjzPJB
 r5mWghy6D9NkryWkYUmoQj0fx8MF
X-Google-Smtp-Source: APXvYqxfcw8jp43y7sZ9T3yjPDk86xADVFye5tOvbVvlO1RgZqocvxm5yuzPLzG1Tl+L9yc1Wqv5SQ==
X-Received: by 2002:a37:bc03:: with SMTP id m3mr8307018qkf.199.1565187690319; 
 Wed, 07 Aug 2019 07:21:30 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id e18sm31472034qkm.49.2019.08.07.07.21.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:21:30 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 11:21:11 -0300
Message-Id: <20190807142114.17569-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807142114.17569-1-danielhb413@gmail.com>
References: <20190807142114.17569-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v5 1/4] block: introducing
 'bdrv_co_delete_file' interface
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding to Block Drivers the capability of being able to clean up
its created files can be useful in certain situations. For the
LUKS driver, for instance, a failure in one of its authentication
steps can leave files in the host that weren't there before.

This patch adds the 'bdrv_co_delete_file' interface to block
drivers and add it to the 'file' driver in file-posix.c.The
implementation is given by 'raw_co_delete_file'.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/file-posix.c        | 28 ++++++++++++++++++++++++++++
 include/block/block_int.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..278952d5a2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2376,6 +2376,33 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
     return raw_co_create(&options, errp);
 }
 
+/**
+ * Co-routine function that erases a regular file.
+ */
+static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
+                                           Error **errp)
+{
+    struct stat st;
+    int ret;
+
+    if (!(stat(bs->filename, &st) == 0) || !S_ISREG(st.st_mode)) {
+        ret = -ENOENT;
+        error_setg_errno(errp, -ret, "%s is not a regular file",
+                         bs->filename);
+        goto done;
+    }
+
+    ret = unlink(bs->filename);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Error when deleting file %s",
+                         bs->filename);
+    }
+
+done:
+    return ret;
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -2927,6 +2954,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
+    .bdrv_co_delete_file = raw_co_delete_file,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..4cb3232dc4 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -309,6 +309,12 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
 
+    /*
+     * Delete a local created file.
+     */
+    int coroutine_fn (*bdrv_co_delete_file)(BlockDriverState *bs,
+                                            Error **errp);
+
     /*
      * Flushes all data that was already written to the OS all the way down to
      * the disk (for example file-posix.c calls fsync()).
-- 
2.21.0


