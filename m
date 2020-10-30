Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EBBC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6038B221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6038B221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYMCH-0006yP-4x
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 00:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kYM9X-0004Tv-O8; Fri, 30 Oct 2020 00:36:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kYM9U-00016Y-4M; Fri, 30 Oct 2020 00:36:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMqJX2jQfz6ty3;
 Fri, 30 Oct 2020 12:36:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 12:36:17 +0800
From: Xinhao Zhang <zhangxinhao1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/3] hw/9pfs : add spaces around operator
Date: Fri, 30 Oct 2020 12:35:13 +0800
Message-ID: <20201030043515.1030223-1-zhangxinhao1@huawei.com>
X-Mailer: git-send-email 2.29.0-rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 23:35:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, qemu-trivial@nongnu.org, qemu_oss@crudebyte.com,
 groug@kaod.org, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix code style. Operator needs spaces both sides.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
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
2.29.0-rc1


