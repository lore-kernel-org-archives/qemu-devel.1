Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23496C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9432083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZE69Hrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9432083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkOV-0002Zt-1w
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 10:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNQ-0001YW-Me; Mon, 31 Aug 2020 10:01:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNN-0005Re-5y; Mon, 31 Aug 2020 10:01:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so84919wme.0;
 Mon, 31 Aug 2020 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hps0WnAMGV8M6tEIQQs0UxGyHLY9Kbi1+pTVoL39GFw=;
 b=tZE69HrtZHhZJop3qKm6VkCuCFG3EgzbVV3F5YFXFTgD4+uvT6b6kkENwqeeXiZs+i
 sz+lLwXl1R7WWBH8we70b3RYVMFHmvFn2U7NwTwMFmZyhjzL2jUZTYVc7IOMMmoL9iBz
 YT9A8QPlfVK7IDHVSHozeogKMsBlxdxGXM7NcG/WnVdrj4dNAAQcEnP1oy4f4+ehI10t
 qhf1ppGOfugeodmWeC3OisB53nx6vYihSiK+F6P8FmH/b1AkuU8/GJQDHBO13HDoBy03
 hGz9p7NO0L3+VrLIoFgOalfCxpsmGGWLBs2uF5REyj6z5jgwyzv5Mz53sZY4WiBR63C9
 jUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hps0WnAMGV8M6tEIQQs0UxGyHLY9Kbi1+pTVoL39GFw=;
 b=UE8LCgHxKKXVTxbyZPoIdYFbKo6Jex8KzttgjkGp0+m2AYlgR5Ejq2D8S5x4VfxOYG
 Fwb4AR5Dl4USmpwng+3wmn4BwtWS6mOTdidQIBwseicu2DQGrurS0R8AEnBdPnuFrz/X
 zn450lf91PWrLH5rDWLIyUxWKwi1JyDv0W0W3ujYScdKQPvsb666ky+OB2lt98yQ+0Em
 qKo70Tz8MVVVx2A2QQPsfHxcGIuVW9bhRuUFu9yHf5EAKgTQrg8E3CCbupAxqQ5Ah350
 97IwQse++tUEt6psKJ20J5u0wtQmqabqUgOu0+TFDQiLiJijp1bKJ6HHk6jlUezoH21O
 yEAA==
X-Gm-Message-State: AOAM533hmDNDmf+u8bmZN+IIw/oxtEbEAgQyis37n1wZnThEcWIOX8nc
 36Ny9Sff+9ghHzTQO3tJUfC6ZcK2qAyjxEzW
X-Google-Smtp-Source: ABdhPJyfqFcdV1tEWieRwTbPJ6mR4u7sPtO6Zx27N+gM6P1Ao1HVZGQ9FH6/wc0JWcp+g/QgC5rZDg==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr1457264wmk.7.1598882493577;
 Mon, 31 Aug 2020 07:01:33 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id q192sm12413320wme.13.2020.08.31.07.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 07:01:32 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block: file-posix: Extract preallocate helpers
Date: Mon, 31 Aug 2020 17:01:26 +0300
Message-Id: <20200831140127.657134-2-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831140127.657134-1-nsoffer@redhat.com>
References: <20200831140127.657134-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

handle_aiocb_truncate() was too big and complex, implementing 3
different preallocation modes. In a future patch I want to introduce a
fallback from "falloc" to "full"; it will be too messy and error prone
with the current code.

Extract a helper for each of the preallocation modes (falloc, full, off)
and leave only the common preparation and cleanup code in
handle_aiocb_truncate().

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c | 206 ++++++++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 86 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..341ffb1cb4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1832,12 +1832,128 @@ static int allocate_first_block(int fd, size_t max_size)
     return ret;
 }
 
+static int preallocate_falloc(int fd, int64_t current_length, int64_t offset,
+                              Error **errp)
+{
+#ifdef CONFIG_POSIX_FALLOCATE
+    int result;
+
+    if (offset == current_length)
+        return 0;
+
+    /*
+     * Truncating before posix_fallocate() makes it about twice slower on
+     * file systems that do not support fallocate(), trying to check if a
+     * block is allocated before allocating it, so don't do that here.
+     */
+
+    result = -posix_fallocate(fd, current_length,
+                              offset - current_length);
+    if (result != 0) {
+        /* posix_fallocate() doesn't set errno. */
+        error_setg_errno(errp, -result,
+                         "Could not preallocate new data");
+        return result;
+    }
+
+    if (current_length == 0) {
+        /*
+         * posix_fallocate() uses fallocate() if the filesystem supports
+         * it, or fallback to manually writing zeroes. If fallocate()
+         * was used, unaligned reads from the fallocated area in
+         * raw_probe_alignment() will succeed, hence we need to allocate
+         * the first block.
+         *
+         * Optimize future alignment probing; ignore failures.
+         */
+        allocate_first_block(fd, offset);
+    }
+
+    return 0;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int preallocate_full(int fd, int64_t current_length, int64_t offset,
+                            Error **errp)
+{
+    int64_t num = 0, left = offset - current_length;
+    off_t seek_result;
+    int result;
+    char *buf = NULL;
+
+    /*
+     * Knowing the final size from the beginning could allow the file
+     * system driver to do less allocations and possibly avoid
+     * fragmentation of the file.
+     */
+    if (ftruncate(fd, offset) != 0) {
+        result = -errno;
+        error_setg_errno(errp, -result, "Could not resize file");
+        goto out;
+    }
+
+    buf = g_malloc0(65536);
+
+    seek_result = lseek(fd, current_length, SEEK_SET);
+    if (seek_result < 0) {
+        result = -errno;
+        error_setg_errno(errp, -result,
+                         "Failed to seek to the old end of file");
+        goto out;
+    }
+
+    while (left > 0) {
+        num = MIN(left, 65536);
+        result = write(fd, buf, num);
+        if (result < 0) {
+            if (errno == EINTR) {
+                continue;
+            }
+            result = -errno;
+            error_setg_errno(errp, -result,
+                             "Could not write zeros for preallocation");
+            goto out;
+        }
+        left -= result;
+    }
+
+    result = fsync(fd);
+    if (result < 0) {
+        result = -errno;
+        error_setg_errno(errp, -result, "Could not flush file to disk");
+        goto out;
+    }
+
+out:
+    g_free(buf);
+
+    return result;
+}
+
+static int preallocate_off(int fd, int64_t current_length, int64_t offset,
+                           Error **errp)
+{
+    if (ftruncate(fd, offset) != 0) {
+        int result = -errno;
+        error_setg_errno(errp, -result, "Could not resize file");
+        return result;
+    }
+
+    if (current_length == 0 && offset > current_length) {
+        /* Optimize future alignment probing; ignore failures. */
+        allocate_first_block(fd, offset);
+    }
+
+    return 0;
+}
+
 static int handle_aiocb_truncate(void *opaque)
 {
     RawPosixAIOData *aiocb = opaque;
     int result = 0;
     int64_t current_length = 0;
-    char *buf = NULL;
     struct stat st;
     int fd = aiocb->aio_fildes;
     int64_t offset = aiocb->aio_offset;
@@ -1859,95 +1975,14 @@ static int handle_aiocb_truncate(void *opaque)
     switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
     case PREALLOC_MODE_FALLOC:
-        /*
-         * Truncating before posix_fallocate() makes it about twice slower on
-         * file systems that do not support fallocate(), trying to check if a
-         * block is allocated before allocating it, so don't do that here.
-         */
-        if (offset != current_length) {
-            result = -posix_fallocate(fd, current_length,
-                                      offset - current_length);
-            if (result != 0) {
-                /* posix_fallocate() doesn't set errno. */
-                error_setg_errno(errp, -result,
-                                 "Could not preallocate new data");
-            } else if (current_length == 0) {
-                /*
-                 * posix_fallocate() uses fallocate() if the filesystem
-                 * supports it, or fallback to manually writing zeroes. If
-                 * fallocate() was used, unaligned reads from the fallocated
-                 * area in raw_probe_alignment() will succeed, hence we need to
-                 * allocate the first block.
-                 *
-                 * Optimize future alignment probing; ignore failures.
-                 */
-                allocate_first_block(fd, offset);
-            }
-        } else {
-            result = 0;
-        }
+        result = preallocate_falloc(fd, current_length, offset, errp);
         goto out;
 #endif
     case PREALLOC_MODE_FULL:
-    {
-        int64_t num = 0, left = offset - current_length;
-        off_t seek_result;
-
-        /*
-         * Knowing the final size from the beginning could allow the file
-         * system driver to do less allocations and possibly avoid
-         * fragmentation of the file.
-         */
-        if (ftruncate(fd, offset) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-            goto out;
-        }
-
-        buf = g_malloc0(65536);
-
-        seek_result = lseek(fd, current_length, SEEK_SET);
-        if (seek_result < 0) {
-            result = -errno;
-            error_setg_errno(errp, -result,
-                             "Failed to seek to the old end of file");
-            goto out;
-        }
-
-        while (left > 0) {
-            num = MIN(left, 65536);
-            result = write(fd, buf, num);
-            if (result < 0) {
-                if (errno == EINTR) {
-                    continue;
-                }
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not write zeros for preallocation");
-                goto out;
-            }
-            left -= result;
-        }
-        if (result >= 0) {
-            result = fsync(fd);
-            if (result < 0) {
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not flush file to disk");
-                goto out;
-            }
-        }
+        result = preallocate_full(fd, current_length, offset, errp);
         goto out;
-    }
     case PREALLOC_MODE_OFF:
-        if (ftruncate(fd, offset) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-        } else if (current_length == 0 && offset > current_length) {
-            /* Optimize future alignment probing; ignore failures. */
-            allocate_first_block(fd, offset);
-        }
-        return result;
+        return preallocate_off(fd, current_length, offset, errp);
     default:
         result = -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
@@ -1963,7 +1998,6 @@ out:
         }
     }
 
-    g_free(buf);
     return result;
 }
 
-- 
2.26.2


