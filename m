Received: from eggs.gnu.org ([2001:4830:134:3::10]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wr-0002XO-C3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wp-0006X0-RX
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:25 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:22 +0100
Message-Id: <20180209092524.31348-28-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/29] MAINTAINERS: add myself as overall s390x
 maintainer
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

All your mainframes are belong to me.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 301b6996e1..6c675f2a7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -76,6 +76,29 @@ K: ^Subject:.*(?i)trivial
 T: git git://git.corpit.ru/qemu.git trivial-patches
 T: git git://github.com/vivier/qemu.git trivial-patches
=20
+Architecture support
+--------------------
+S390
+M: Cornelia Huck <cohuck@redhat.com>
+S: Supported
+F: default-configs/s390x-softmmu.mak
+F: gdb-xml/s390*.xml
+F: hw/char/sclp*.[hc]
+F: hw/char/terminal3270.c
+F: hw/intc/s390_flic.c
+F: hw/intc/s390_flic_kvm.c
+F: hw/s390x/
+F: hw/vfio/ccw.c
+F: hw/watchdog/wdt_diag288.c
+F: include/hw/s390x/
+F: include/hw/watchdog/wdt_diag288.h
+F: pc-bios/s390-ccw/
+F: pc-bios/s390-ccw.img
+F: target/s390x/
+K: ^Subject:.*(?i)s390x?
+T: git git://github.com/cohuck/qemu.git s390-next
+L: qemu-s390x@nongnu.org
+
 Guest CPU cores (TCG):
 ----------------------
 Overall
--=20
2.13.6
