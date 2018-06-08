Received: from eggs.gnu.org ([2001:4830:134:3::10]:47797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RU-4p
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUC-0001Xc-0l
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUB-0001X3-Rn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:11 -0400
Message-Id: <20180608174733.4936-9-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/30] ahci: combine identical clauses in port
 write
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
Message-id: 20180531222835.16558-6-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index a19f46c301..2aea9c3e12 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -330,11 +330,7 @@ static void ahci_port_write(AHCIState *s, int port, =
int offset, uint32_t val)
         check_cmd(s, port);
         break;
     case PORT_TFDATA:
-        /* Read Only. */
-        break;
     case PORT_SIG:
-        /* Read Only */
-        break;
     case PORT_SCR_STAT:
         /* Read Only */
         break;
--=20
2.14.3
