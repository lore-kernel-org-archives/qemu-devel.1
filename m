Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA681C5517A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39269208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ok+CNsyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39269208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayDR-0007Zd-T6
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <01011733ea3177e437d8999b77c73caa93266896@lizzy.crudebyte.com>)
 id 1kayCA-0006Cv-Uo
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:12 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:54727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <01011733ea3177e437d8999b77c73caa93266896@lizzy.crudebyte.com>)
 id 1kayC9-000796-7J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=cuovt0Feftktuski+XJazOvPm4C/mceIzl+3zbI0FZ8=; b=ok+CN
 syu6BAjYPGwGU0UYN2bpeYrTjLZdPh1CwzhezSepRKgrQvr2Uev6drbO1xxMBL/iBwX9J7UMdeRLJ
 SIkcsrK3FFGpBkjBxxr0EU2D9LGfaDW09bVkp6/pUF22rD0vSydGJe3J1T/qv+yFaajhqAcZAcDRr
 6OtHteQFPJLlSmzrYNg/0Qe+eW4mwe9yl1sEp5dcxwv6K4V/YHu8ko04X7b5p2E6yUHqLK9jiYkYB
 411lcz/91HQwdIZJelvj/8gvKOiumPOpJRwSJYXh/hmHaXF3kpZtWChkB3qOZ9I7vj9JMLOEJfWVZ
 SW7pSpOREUuL3NG2Y0urAQEHZBLRw==;
Message-Id: <01011733ea3177e437d8999b77c73caa93266896.1604653990.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604653990.git.qemu_oss@crudebyte.com>
References: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 06 Nov 2020 10:13:10 +0100
Subject: [PULL 1/4] hw/9pfs : add spaces around operator
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Xinhao Zhang <zhangxinhao1@huawei.com>,
 Kai Deng <dengkai1@huawei.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=01011733ea3177e437d8999b77c73caa93266896@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:36:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Operator needs spaces both sides.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20201030043515.1030223-1-zhangxinhao1@huawei.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 10 +++++-----
 hw/9pfs/9p.c       | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 3107637209..af52c1daac 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -162,13 +162,13 @@ static void local_mapped_file_attr(int dirfd, const char *name,
     memset(buf, 0, ATTR_MAX);
     while (fgets(buf, ATTR_MAX, fp)) {
         if (!strncmp(buf, "virtfs.uid", 10)) {
-            stbuf->st_uid = atoi(buf+11);
+            stbuf->st_uid = atoi(buf + 11);
         } else if (!strncmp(buf, "virtfs.gid", 10)) {
-            stbuf->st_gid = atoi(buf+11);
+            stbuf->st_gid = atoi(buf + 11);
         } else if (!strncmp(buf, "virtfs.mode", 11)) {
-            stbuf->st_mode = atoi(buf+12);
+            stbuf->st_mode = atoi(buf + 12);
         } else if (!strncmp(buf, "virtfs.rdev", 11)) {
-            stbuf->st_rdev = atoi(buf+12);
+            stbuf->st_rdev = atoi(buf + 12);
         }
         memset(buf, 0, ATTR_MAX);
     }
@@ -823,7 +823,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
         if (fd == -1) {
             goto out;
         }
-        credp->fc_mode = credp->fc_mode|S_IFREG;
+        credp->fc_mode = credp->fc_mode | S_IFREG;
         if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
             /* Set cleint credentials in xattr */
             err = local_set_xattrat(dirfd, name, credp);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 741d222c3f..94df440fc7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1091,7 +1091,7 @@ static mode_t v9mode_to_mode(uint32_t mode, V9fsString *extension)
         }
     }
 
-    if (!(ret&~0777)) {
+    if (!(ret & ~0777)) {
         ret |= S_IFREG;
     }
 
@@ -2776,7 +2776,7 @@ static void coroutine_fn v9fs_create(void *opaque)
         v9fs_path_unlock(s);
     } else {
         err = v9fs_co_open2(pdu, fidp, &name, -1,
-                            omode_to_uflags(mode)|O_CREAT, perm, &stbuf);
+                            omode_to_uflags(mode) | O_CREAT, perm, &stbuf);
         if (err < 0) {
             goto out;
         }
@@ -3428,7 +3428,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
      * compute bsize factor based on host file system block size
      * and client msize
      */
-    bsize_factor = (s->msize - P9_IOHDRSZ)/stbuf->f_bsize;
+    bsize_factor = (s->msize - P9_IOHDRSZ) / stbuf->f_bsize;
     if (!bsize_factor) {
         bsize_factor = 1;
     }
@@ -3440,9 +3440,9 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
      * adjust(divide) the number of blocks, free blocks and available
      * blocks by bsize factor
      */
-    f_blocks = stbuf->f_blocks/bsize_factor;
-    f_bfree  = stbuf->f_bfree/bsize_factor;
-    f_bavail = stbuf->f_bavail/bsize_factor;
+    f_blocks = stbuf->f_blocks / bsize_factor;
+    f_bfree  = stbuf->f_bfree / bsize_factor;
+    f_bavail = stbuf->f_bavail / bsize_factor;
     f_files  = stbuf->f_files;
     f_ffree  = stbuf->f_ffree;
     fsid_val = (unsigned int) stbuf->f_fsid.__val[0] |
@@ -4185,6 +4185,6 @@ static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
         error_report("Failed to get the resource limit");
         exit(1);
     }
-    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur/3);
-    open_fd_rc = rlim.rlim_cur/2;
+    open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur / 3);
+    open_fd_rc = rlim.rlim_cur / 2;
 }
-- 
2.20.1


