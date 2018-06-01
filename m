Received: from eggs.gnu.org ([2001:4830:134:3::10]:33414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr7-00038q-Qd
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr6-0003Bc-Us
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYr6-0003BB-Pu
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id p23-v6so5420484qtn.6
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:48 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:09 -0400
Message-Id: <08ddd5a3e1b0679ac63f36fe4a28988b6c2bfea4.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 14/20] 9p: darwin: Provide a compatibility
 definition for XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

No change from v1.

 hw/9pfs/9p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 70cfab9..24802b9 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3374,6 +3374,13 @@ out_nofid:
     v9fs_string_free(&name);
 }
 
+#if defined(CONFIG_DARWIN) && !defined(XATTR_SIZE_MAX)
+/* Darwin doesn't seem to define a maximum xattr size in its user
+   user space header, but looking at the kernel source, HFS supports
+   up to INT32_MAX, so use that as the maximum.
+*/
+#define XATTR_SIZE_MAX INT32_MAX
+#endif
 static void coroutine_fn v9fs_xattrcreate(void *opaque)
 {
     int flags;
-- 
2.8.1
