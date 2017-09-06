Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpW2O-0005nY-HA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpW2L-0004bO-UX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:50:20 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Wed,  6 Sep 2017 09:50:06 +0100
Message-Id: <20170906085006.26983-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] qemu-options: Document the -drive
 locking parameter.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, famz@redhat.com, kwolf@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru

Commit 16b48d5d66d2 ("file-posix: Add 'locking' option") added this
option, but as it was not documented in the -help output it was not
easily possible to tell if a particular qemu binary supports it.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..f8f95eb498 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -796,7 +796,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
     "       [,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
-    "       [,readonly=on|off][,copy-on-read=on|off]\n"
+    "       [,readonly=on|off][,copy-on-read=on|off][,locking=off|auto|on]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
     "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
     "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
-- 
2.13.2
