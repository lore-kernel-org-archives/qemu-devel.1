Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D57C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D39A2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY+gXMN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqBR-0008UY-0D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioq8v-0005ZK-SO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioq8q-0008Th-Ts
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:47:37 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioq8q-0008T4-Qb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:47:32 -0500
Received: by mail-qk1-x743.google.com with SMTP id 21so42887539qky.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zsukkUdOzMgCkp880DIaEjCzJSIPV+NKAHUZuxaekxI=;
 b=nY+gXMN1yaQU28qY/2dSOcyjq+YHIyFihKeioJnUPKMLSHtgigyWa6IZTH/ydWleLx
 yYWV64sfJ0DiyIgZUchhMn82hG+HXN0HUX4hRbYe7ZsoDO4MUPfJDITdgAc4n40W464E
 FBV8kCYMK2niU1Hgtw0AOPnZ1/0wMIZksxFNxDTZ4r3uEWP6WippornVjwirvYfjLibl
 zRwSySVTQ6Uvif4zaGZip5oysCPyiQUQ1C/0P8FL7EN+GvXqKzifaSrhxtdVQ4i8aVVF
 Tg84BKE03eqcmNvcvOHWoC8S621yv3maPXBla5WgyFPklNEqyOFCeXEC60g9ysL0R0zE
 wONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zsukkUdOzMgCkp880DIaEjCzJSIPV+NKAHUZuxaekxI=;
 b=DSvAMMuM6z/Ge5xwvTk/L0F8vsnOpYpSW0u/l5EQZgMp0o2n2ZxMpQWjOJjVaAGsVs
 cfYRC4shPtkzrBYoA3Tzw5r/AeFsWXfwuNJlkFjMG6+qY9EqdKhXHNr7AQMEOQ1akBf0
 5ENwENaO1BRotPbJpBgGsqlam8hC2GkZJS6FwxNP2iYZh5PLGMP4OEjE4o1DbIV94P2w
 L5GcWD4vOemGmNf3Tou+b2U+YsaR5f5v0haeuR2pAMePSmiShlQU4jn2AEkJXRsJG1RJ
 KrNuwTaGWDDgkXuj1KEg2PPl8J5OAy+2D4biBOjBu4DG5ijoSvL0r6wsef3v6ZIN3RF3
 HBhA==
X-Gm-Message-State: APjAAAVgUMrs8f7/ZPfC5BArUwcuwD6uduBbCRKjXQzla1DRadmIg8hZ
 ZBquRta3K7+ZkgIx/RSmYemazJE/
X-Google-Smtp-Source: APXvYqzHsuvFq7Qn/fjQZEZy69FvX5Njtvd48BFyTu44PpNn0eos6o9RUR5NKTMoGdrebbw/rxXlCg==
X-Received: by 2002:a37:ad0e:: with SMTP id f14mr76773406qkm.213.1578408452012; 
 Tue, 07 Jan 2020 06:47:32 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id x27sm22347072qkx.81.2020.01.07.06.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 06:47:31 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] 9p-local.c: always return -1 on error in
 local_unlinkat_common
Date: Tue,  7 Jan 2020 11:47:18 -0300
Message-Id: <20200107144718.391550-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

local_unlinkat_common() is supposed to always return -1 on error.
This is being done by jumps to the 'err_out' label, which is
a 'return ret' call, and 'ret' is initialized with -1.

Unfortunately there is a condition in which the function will
return 0 on error: in a case where flags == AT_REMOVEDIR, 'ret'
will be 0 when reaching

map_dirfd = openat_dir(...)

And, if map_dirfd == -1 and errno != ENOENT, the existing 'err_out'
jump will execute 'return ret', when ret is still set to zero
at that point.

This patch fixes it by changing all 'err_out' labels by
'return -1' calls, ensuring that the function will always
return -1 on error conditions. 'ret' can be left unintialized
since it's now being used just to store the result of 'unlinkat'
calls.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/9pfs/9p-local.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ca641390fb..de61aca216 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1076,7 +1076,7 @@ out:
 static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
                                  int flags)
 {
-    int ret = -1;
+    int ret;
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int map_dirfd;
@@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
 
             fd = openat_dir(dirfd, name);
             if (fd == -1) {
-                goto err_out;
+                return -1;
             }
             ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
             close_preserve_errno(fd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return -1;
             }
         }
         map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
@@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
             ret = unlinkat(map_dirfd, name, 0);
             close_preserve_errno(map_dirfd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return -1;
             }
         } else if (errno != ENOENT) {
-            goto err_out;
+            return -1;
         }
     }
 
-    ret = unlinkat(dirfd, name, flags);
-err_out:
-    return ret;
+    return unlinkat(dirfd, name, flags);
 }
 
 static int local_remove(FsContext *ctx, const char *path)
-- 
2.24.1


