Received: from eggs.gnu.org ([2001:4830:134:3::10]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvnNB-00030w-02
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvnN6-0007gB-3N
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:33:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:51323)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dvnN5-0007f2-RW
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 12:33:40 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 23 Sep 2017 19:33:34 +0300
Message-Id: <20170923163334.9997-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH] remove trailing whitespace from qemu-options.hx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.orh, Michael Tokarev <mjt@tls.msk.ru>

Remove trailing whitespace in qemu-options documentation, as it causes
reproducibility issues depending on the echo implementation used by
the Makefile.

Reported-By: Vagrant Cascadian <vagrant@debian.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 77859a248c..39225ae6c3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -284,8 +284,8 @@ Set default value of @var{driver}'s property @var{prop} to @var{value}, e.g.:
 qemu-system-i386 -global ide-hd.physical_block_size=4096 disk-image.img
 @end example
 
-In particular, you can use this to set driver properties for devices which are 
-created automatically by the machine model. To create a device which is not 
+In particular, you can use this to set driver properties for devices which are
+created automatically by the machine model. To create a device which is not
 created automatically and set properties on it, use -@option{device}.
 
 -global @var{driver}.@var{prop}=@var{value} is shorthand for -global
-- 
2.11.0
