Received: from eggs.gnu.org ([2001:4830:134:3::10]:34502)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drVqf-0003qx-Gf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drVqa-00031T-Kb
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:02:29 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Mon, 11 Sep 2017 22:50:01 +0200
Message-Id: <20170911205001.11789-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] Drop gld linker usage on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, jperkin@joyent.com, Kamil Rytarowski <n54@gmx.com>

This is required to be removed on SmartOS (Illumos).
As of now there are no alternative supported SunOS distributions.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index fd7e3a5e81..3dc0a71984 100755
--- a/configure
+++ b/configure
@@ -746,7 +746,6 @@ SunOS)
   solaris="yes"
   make="${MAKE-gmake}"
   install="${INSTALL-ginstall}"
-  ld="gld"
   smbd="${SMBD-/usr/sfw/sbin/smbd}"
   if test -f /usr/include/sys/soundcard.h ; then
     audio_drv_list="oss"
-- 
2.14.1
