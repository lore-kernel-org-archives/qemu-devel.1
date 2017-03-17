Received: from eggs.gnu.org ([2001:4830:134:3::10]:51115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <craig@rancher.com>) id 1coueb-0001Ff-5h
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <craig@rancher.com>) id 1coueX-00040K-4o
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:23:01 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com
	([104.47.37.134]:17184
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <craig@rancher.com>) id 1coueW-0003zd-Pn
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:22:57 -0400
From: Craig Jellick <craig@rancher.com>
Date: Fri, 17 Mar 2017 08:49:55 -0700
Message-ID: <1489765795-32398-1-git-send-email-craig@rancher.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Add 'none' as type for drive's if option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Craig Jellick <craig@rancher.com>

Signed-off-by: Craig Jellick <craig@rancher.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..8291e64 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -591,7 +591,7 @@ Special files such as iSCSI devices can be specified using protocol
 specific URLs. See the section for "Device URL Syntax" for more information.
 @item if=@var{interface}
 This option defines on which type on interface the drive is connected.
-Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio.
+Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
 @item bus=@var{bus},unit=@var{unit}
 These options define where is connected the drive by defining the bus number and
 the unit id.
-- 
2.7.4
