Received: from eggs.gnu.org ([2001:4830:134:3::10]:57536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbE-0002pN-0D
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbA-00082q-3e
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:48 +0300
Message-Id: <2f14ad6a961a96640da9f87cc299dda17427ec14.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 30/31] Drop gld linker usage on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Kamil Rytarowski <n54@gmx.com>

This is required to be removed on SmartOS (Illumos).
As of now there are no alternative supported SunOS distributions.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 1f7b4f03ce..7727f6ba5b 100755
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
2.11.0
