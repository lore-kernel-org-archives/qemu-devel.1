Received: from eggs.gnu.org ([2001:4830:134:3::10]:43954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4ws-0002YQ-7k
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wr-0006YY-FE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:26 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:23 +0100
Message-Id: <20180209092524.31348-29-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] MAINTAINERS: reorganize s390-ccw bios
 maintainership
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

Split it out from the s390-ccw-virtio machine, add Thomas as a
maintainer in addition to Christian.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c675f2a7e..e3e0b1d2f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -855,15 +855,22 @@ F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
 F: hw/s390x/
 F: include/hw/s390x/
-F: pc-bios/s390-ccw/
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
-F: pc-bios/s390-ccw.img
 F: default-configs/s390x-softmmu.mak
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
+S390-ccw Bios
+M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Thomas Huth <thuth@redhat.com>
+S: Supported
+F: pc-bios/s390-ccw/
+F: pc-bios/s390-ccw.img
+T: git git://github.com/borntraeger/qemu.git s390-next
+L: qemu-s390x@nongnu.org
+
 UniCore32 Machines
 -------------
 PKUnity-3 SoC initramfs-with-busybox
-- 
2.13.6
