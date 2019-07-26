Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A738C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1168E21951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1168E21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvfx-0000sl-Rt
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hqvfS-0007t6-FA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hqvfR-0001J6-8o
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hqvfQ-00018r-Sm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C689A3086208
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:33:30 +0000 (UTC)
Received: from localhost (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C49E5C46C;
 Fri, 26 Jul 2019 08:33:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Fri, 26 Jul 2019 09:33:20 +0100
Message-Id: <20190726083322.13637-2-stefanha@redhat.com>
In-Reply-To: <20190726083322.13637-1-stefanha@redhat.com>
References: <20190726083322.13637-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 26 Jul 2019 08:33:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] virtiofsd: sync up fuse.h Linux 5.1 header
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_kernel.h | 51 ++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/contrib/virtiofsd/fuse_kernel.h b/contrib/virtiofsd/fuse_ker=
nel.h
index 3186efbed6..7722e0ac23 100644
--- a/contrib/virtiofsd/fuse_kernel.h
+++ b/contrib/virtiofsd/fuse_kernel.h
@@ -119,6 +119,12 @@
  *
  *  7.28
  *  - add FUSE_COPY_FILE_RANGE
+ *  - add FOPEN_CACHE_DIR
+ *  - add FUSE_MAX_PAGES, add max_pages to init_out
+ *  - add FUSE_CACHE_SYMLINKS
+ *
+ *  7.29
+ *  - add FUSE_NO_OPENDIR_SUPPORT flag
  */
=20
 #ifndef _LINUX_FUSE_H
@@ -154,7 +160,7 @@
 #define FUSE_KERNEL_VERSION 7
=20
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 27
+#define FUSE_KERNEL_MINOR_VERSION 29
=20
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -222,10 +228,12 @@ struct fuse_file_lock {
  * FOPEN_DIRECT_IO: bypass page cache for this open file
  * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
  * FOPEN_NONSEEKABLE: the file is not seekable
+ * FOPEN_CACHE_DIR: allow caching this directory
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 #define FOPEN_NONSEEKABLE	(1 << 2)
+#define FOPEN_CACHE_DIR		(1 << 3)
=20
 /**
  * INIT request/reply flags
@@ -252,6 +260,9 @@ struct fuse_file_lock {
  * FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on write/chown=
/trunc
  * FUSE_POSIX_ACL: filesystem supports posix acls
  * FUSE_ABORT_ERROR: reading the device after abort returns ECONNABORTED
+ * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pag=
es
+ * FUSE_CACHE_SYMLINKS: cache READLINK responses
+ * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -275,6 +286,9 @@ struct fuse_file_lock {
 #define FUSE_HANDLE_KILLPRIV	(1 << 19)
 #define FUSE_POSIX_ACL		(1 << 20)
 #define FUSE_ABORT_ERROR	(1 << 21)
+#define FUSE_MAX_PAGES		(1 << 22)
+#define FUSE_CACHE_SYMLINKS	(1 << 23)
+#define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
=20
 /**
  * CUSE INIT request/reply flags
@@ -385,8 +399,8 @@ enum fuse_opcode {
 	FUSE_RENAME2		=3D 45,
 	FUSE_LSEEK		=3D 46,
 	FUSE_COPY_FILE_RANGE	=3D 47,
-        FUSE_SETUPMAPPING       =3D 48,
-        FUSE_REMOVEMAPPING      =3D 49,
+	FUSE_SETUPMAPPING       =3D 48,
+	FUSE_REMOVEMAPPING      =3D 49,
=20
 	/* CUSE specific operations */
 	CUSE_INIT		=3D 4096,
@@ -621,7 +635,9 @@ struct fuse_init_out {
 	uint16_t	congestion_threshold;
 	uint32_t	max_write;
 	uint32_t	time_gran;
-	uint32_t	unused[9];
+	uint16_t	max_pages;
+	uint16_t	padding;
+	uint32_t	unused[8];
 };
=20
 #define CUSE_INIT_INFO_MAX 4096
@@ -814,31 +830,32 @@ struct fuse_copy_file_range_in {
 };
=20
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
-        /* An already open handle */
+	/* An already open handle */
 	uint64_t	fh;
-        /* Offset into the file to start the mapping */
-        uint64_t        foffset;
-        /* Length of mapping required */
-        uint64_t        len;
-        /* Flags, FUSE_SETUPMAPPING_FLAG_* */
-        uint64_t        flags;
-        /* memory offset in to dax window */
-        uint64_t        moffset;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
 };
=20
 struct fuse_removemapping_in {
         /* An already open handle */
-	uint64_t	fh;
+        uint64_t	fh;
 	/* number of fuse_removemapping_one follows */
 	uint32_t        count;
 };
=20
 struct fuse_removemapping_one {
-        /* Offset into the dax to start the unmapping */
+	/* Offset into the dax window start the unmapping */
 	uint64_t        moffset;
-	/* Length of mapping required */
-	uint64_t        len;
+        /* Length of mapping required */
+        uint64_t	len;
 };
=20
 #endif /* _LINUX_FUSE_H */
--=20
2.21.0


