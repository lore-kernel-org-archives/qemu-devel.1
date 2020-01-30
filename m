Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E753AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB4D2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srXJ75Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB4D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHbD-0002A5-RY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWx-0003DH-LW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWw-0001N4-II
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:19 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:34451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ixHWw-0001LQ-E4; Thu, 30 Jan 2020 16:39:18 -0500
Received: by mail-qv1-xf42.google.com with SMTP id o18so2282227qvf.1;
 Thu, 30 Jan 2020 13:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j3SBfARHb0Q5itXyfHtP6FdgEQPvIk7U2AMegh5GrHs=;
 b=srXJ75Nk0svSHAU/Lc0Ul5pfySABkeHQPg5gZPNdkvyb90NayJNDLpNIsPlaugjfNf
 OTPiqJztov018XNSHgfdYhhqr6ioOWyNIN3eaWOzq+geWlFdSq1Np80oEfuxfqxd0fha
 rn3Ae6eKj6wZ6ji8dSVekEw84D8GH1lqJIld0f4XEpZXj+aotwZinGHHokSMx0oCHNe6
 Dh3qhIMoUCkOrc4Pb/LsZzaWeD8dCgbRP0XNc2ubq8sZ0zn6qEwtuvoY6vkbSzFCeW1v
 iwWauj5JtQRWSoRlz06Hx1UGnIW/IWCyfYDC5Q5lXESYkDTZYyvVbgzNPGKxDhkjl2sW
 j1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j3SBfARHb0Q5itXyfHtP6FdgEQPvIk7U2AMegh5GrHs=;
 b=aSzYk+Kt32B8yeEpckm+RPzC9FxE5mgGoQdDuZ/T9ZRGoWhxhm1qeCJIiWXh+hmv8J
 wOV0FVuuyqVy51bv11ulIPqWhR16RTqtyV3TjZjiTi9U42zLKlTHFzXyUcQYxnn+gYrf
 AYZqU+gZYc9kSeovrn6PjdFqdc3ub48cGjcae5hbBrZNW7XPJ3ygPANpk42wpeGDZvth
 XkpRPAtiWnp/PKAiCg/BgzA3xYwAi6J1hOaEbsigYganvPhwyAicSyMTsauLqGt5KYLI
 a3NTmoCqI23rS3gSh+dZcoRZx/5UpWHBOJ+f9fJYgjsqJZRSjKE94Vc0asX3I9vhoD1H
 7kBg==
X-Gm-Message-State: APjAAAWAeBfxNf8d9MMWFEb1ItffcXMMgTRiwz+Ohp2KyEydeZFTLHjQ
 l/3RGhhdcVqekNh9GchHg5e/CIIC
X-Google-Smtp-Source: APXvYqx6h0Z5ta9VcTE8ux329Xhz1rLueajd+IDTv8KMHQJWhflQNYUOmKn5phWaswkgupv+yThMBg==
X-Received: by 2002:a0c:ea92:: with SMTP id d18mr7006622qvp.201.1580420357635; 
 Thu, 30 Jan 2020 13:39:17 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id f26sm3650597qtv.77.2020.01.30.13.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 13:39:17 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 1/4] block: introducing 'bdrv_co_delete_file' interface
Date: Thu, 30 Jan 2020 18:39:04 -0300
Message-Id: <20200130213907.2830642-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
References: <20200130213907.2830642-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding to Block Drivers the capability of being able to clean up
its created files can be useful in certain situations. For the
LUKS driver, for instance, a failure in one of its authentication
steps can leave files in the host that weren't there before.

This patch adds the 'bdrv_co_delete_file' interface to block
drivers and add it to the 'file' driver in file-posix.c. The
implementation is given by 'raw_co_delete_file'.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/file-posix.c        | 23 +++++++++++++++++++++++
 include/block/block_int.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1b805bd938..ed28234bb8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2386,6 +2386,28 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
     return raw_co_create(&options, errp);
 }
 
+static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
+                                           Error **errp)
+{
+    struct stat st;
+    int ret;
+
+    if (!(stat(bs->filename, &st) == 0) || !S_ISREG(st.st_mode)) {
+        error_setg_errno(errp, ENOENT, "%s is not a regular file",
+                         bs->filename);
+        return -ENOENT;
+    }
+
+    ret = unlink(bs->filename);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Error when deleting file %s",
+                         bs->filename);
+    }
+
+    return ret;
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -3017,6 +3039,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
+    .bdrv_co_delete_file = raw_co_delete_file,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..d938d3e8d2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -314,6 +314,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
 
+    /* Delete a created file. */
+    int coroutine_fn (*bdrv_co_delete_file)(BlockDriverState *bs,
+                                            Error **errp);
+
     /*
      * Flushes all data that was already written to the OS all the way down to
      * the disk (for example file-posix.c calls fsync()).
-- 
2.24.1


