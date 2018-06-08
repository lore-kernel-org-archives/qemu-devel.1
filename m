Received: from eggs.gnu.org ([2001:4830:134:3::10]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUG-0002Rn-ME
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0001au-P5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUE-0001aW-LD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:42 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:21 -0400
Message-Id: <20180608174733.4936-19-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/30] ahci: delete old host register address
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-16-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci_internal.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index f9dcf8b6e6..2953243929 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -55,12 +55,6 @@
 #define RX_FIS_UNK                0x60 /* offset of Unknown FIS data */
=20
 /* global controller registers */
-#define HOST_CAP                  0x00 /* host capabilities */
-#define HOST_CTL                  0x04 /* global host control */
-#define HOST_IRQ_STAT             0x08 /* interrupt status */
-#define HOST_PORTS_IMPL           0x0c /* bitmap of implemented ports */
-#define HOST_VERSION              0x10 /* AHCI spec. version compliancy =
*/
-
 enum AHCIHostReg {
     AHCI_HOST_REG_CAP        =3D 0,  /* CAP: host capabilities */
     AHCI_HOST_REG_CTL        =3D 1,  /* GHC: global host control */
--=20
2.14.3
