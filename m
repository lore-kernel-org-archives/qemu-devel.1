Received: from eggs.gnu.org ([2001:4830:134:3::10]:56009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUf-0004Js-EU
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUc-00035B-Ap
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:07 +0300
Message-Id: <ed1fcd00094cdd9395315068442abe28f612e8a3.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 04/23] Add 'none' as type for drive's if option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Craig Jellick <craig@rancher.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Craig Jellick <craig@rancher.com>

Signed-off-by: Craig Jellick <craig@rancher.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f68829f3b0..a24fef2107 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -604,7 +604,7 @@ Special files such as iSCSI devices can be specified using protocol
 specific URLs. See the section for "Device URL Syntax" for more information.
 @item if=@var{interface}
 This option defines on which type on interface the drive is connected.
-Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio.
+Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
 @item bus=@var{bus},unit=@var{unit}
 These options define where is connected the drive by defining the bus number and
 the unit id.
-- 
2.11.0
