Received: from eggs.gnu.org ([209.51.188.92]:41939)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1grtF7-00075C-Tx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 18:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1grtF6-0004QP-0X
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 18:38:05 -0500
From: Kamil Rytarowski <n54@gmx.com>
Date: Fri,  8 Feb 2019 00:37:04 +0100
Message-Id: <20190207233704.29978-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: Add HAX support in NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, yu.ning@intel.com, asanchez@kryptoslogic.com, pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>

The NetBSD support in Intel HAXM has beem merged upstream and is functional.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index b18281c61f..89b889072d 100755
--- a/configure
+++ b/configure
@@ -819,6 +819,7 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
+  hax="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
-- 
2.20.1
