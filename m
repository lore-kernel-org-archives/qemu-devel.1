Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF010C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 05:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B705024672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 05:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B705024672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7C5R-0000G4-8w
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 00:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1j7C4K-0007Sc-SN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1j7C4J-0000uL-PL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:44 -0500
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:32725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1j7C4J-0000nu-32
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:43 -0500
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by
 mgwkm03.jp.fujitsu.com with smtp
 id 6d59_3f25_b7d26c65_e4e8_44c3_946d_499c04aabeb1;
 Thu, 27 Feb 2020 14:50:32 +0900
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id C98D3AC009A
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 14:50:31 +0900 (JST)
Received: from g01jpexchyt35.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt01.exch.g01.fujitsu.local (Postfix) with ESMTP id CC59E6D6375;
 Thu, 27 Feb 2020 14:50:30 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt35.g01.fujitsu.local (10.128.193.50) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 14:50:31 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <virtio-fs@redhat.com>
Subject: [PATCH v4 1/2] virtiofsd: passthrough_ll: cleanup getxattr/listxattr
Date: Thu, 27 Feb 2020 14:59:26 +0900
Message-ID: <20200227055927.24566-2-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
References: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.170
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
Cc: qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a cleanup patch to simplify the following xattr fix and
there is no functional changes.

- Move memory allocation to head of the function
- Unify fgetxattr/flistxattr call for both size == 0 and
  size != 0 case
- Remove redundant lo_inode_put call in error path
  (Note: second call is ignored now since @inode is already NULL)

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/passthrough_ll.c | 54 +++++++++++++-------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 9772823066..7b94300ae0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2384,34 +2384,30 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
         goto out;
     }
 
+    if (size) {
+        value = malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+    }
+
     sprintf(procname, "%i", inode->fd);
     fd = openat(lo->proc_self_fd, procname, O_RDONLY);
     if (fd < 0) {
         goto out_err;
     }
 
+    ret = fgetxattr(fd, name, value, size);
+    if (ret == -1) {
+        goto out_err;
+    }
     if (size) {
-        value = malloc(size);
-        if (!value) {
-            goto out_err;
-        }
-
-        ret = fgetxattr(fd, name, value, size);
-        if (ret == -1) {
-            goto out_err;
-        }
         saverr = 0;
         if (ret == 0) {
             goto out;
         }
-
         fuse_reply_buf(req, value, ret);
     } else {
-        ret = fgetxattr(fd, name, NULL, 0);
-        if (ret == -1) {
-            goto out_err;
-        }
-
         fuse_reply_xattr(req, ret);
     }
 out_free:
@@ -2427,7 +2423,6 @@ out_free:
 out_err:
     saverr = errno;
 out:
-    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
@@ -2462,34 +2457,30 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
         goto out;
     }
 
+    if (size) {
+        value = malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+    }
+
     sprintf(procname, "%i", inode->fd);
     fd = openat(lo->proc_self_fd, procname, O_RDONLY);
     if (fd < 0) {
         goto out_err;
     }
 
+    ret = flistxattr(fd, value, size);
+    if (ret == -1) {
+        goto out_err;
+    }
     if (size) {
-        value = malloc(size);
-        if (!value) {
-            goto out_err;
-        }
-
-        ret = flistxattr(fd, value, size);
-        if (ret == -1) {
-            goto out_err;
-        }
         saverr = 0;
         if (ret == 0) {
             goto out;
         }
-
         fuse_reply_buf(req, value, ret);
     } else {
-        ret = flistxattr(fd, NULL, 0);
-        if (ret == -1) {
-            goto out_err;
-        }
-
         fuse_reply_xattr(req, ret);
     }
 out_free:
@@ -2505,7 +2496,6 @@ out_free:
 out_err:
     saverr = errno;
 out:
-    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
-- 
2.21.1


