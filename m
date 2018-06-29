Received: from eggs.gnu.org ([2001:4830:134:3::10]:49745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxag-0000JB-Et
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxae-00005t-TX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxae-00005Y-OM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:27 +0100
Message-Id: <20180629175330.19391-9-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/11] hw/net/ne2000: Convert printf() calls to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/net/ne2000.c     | 8 ++------
 hw/net/trace-events | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 26b234b7eb..07d79e317f 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -277,9 +277,7 @@ static void ne2000_ioport_write(void *opaque, uint32_=
t addr, uint32_t val)
     int offset, page, index;
=20
     addr &=3D 0xf;
-#ifdef DEBUG_NE2000
-    printf("NE2000: write addr=3D0x%x val=3D0x%02x\n", addr, val);
-#endif
+    trace_ne2000_ioport_write(addr, val);
     if (addr =3D=3D E8390_CMD) {
         /* control register */
         s->cmd =3D val;
@@ -442,9 +440,7 @@ static uint32_t ne2000_ioport_read(void *opaque, uint=
32_t addr)
             break;
         }
     }
-#ifdef DEBUG_NE2000
-    printf("NE2000: read addr=3D0x%x val=3D%02x\n", addr, ret);
-#endif
+    trace_ne2000_ioport_read(addr, ret);
     return ret;
 }
=20
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 95a1de01e9..f57010df37 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -26,6 +26,8 @@ mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to =
%d (0x%02x)"
 # hw/net/ne2000.c
 ne2000_read(uint64_t addr, uint64_t val) "read addr=3D0x%" PRIx64 " val=3D=
0x%" PRIx64
 ne2000_write(uint64_t addr, uint64_t val) "write addr=3D0x%" PRIx64 " va=
l=3D0x%" PRIx64
+ne2000_ioport_read(uint64_t addr, uint64_t val) "io read addr=3D0x%02" P=
RIx64 " val=3D0x%02" PRIx64
+ne2000_ioport_write(uint64_t addr, uint64_t val) "io write addr=3D0x%02"=
 PRIx64 " val=3D0x%02" PRIx64
=20
 # hw/net/opencores_eth.c
 open_eth_mii_write(unsigned idx, uint16_t v) "MII[0x%02x] <- 0x%04x"
--=20
2.17.1
