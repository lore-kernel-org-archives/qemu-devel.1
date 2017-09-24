Received: from eggs.gnu.org ([2001:4830:134:3::10]:45685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVQ-0004sJ-J1
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEVN-0000IQ-DE
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:32:04 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:39 +0300
Message-Id: <467e6372f88cec9f9f70d1d32703c03ee40bf083.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 21/31] remove trailing whitespace from
 qemu-options.hx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

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
