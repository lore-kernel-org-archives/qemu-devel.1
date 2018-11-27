Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZgL-00038n-5q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZgF-0004gR-F1
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:21 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:41 +0400
Message-Id: <20181127092801.21777-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 08/28] net: cadence_gem: Remove
 incorrect assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, mbilal <muhammad_bilal@mentor.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Don't assert on RX descriptor settings when the receiver is
disabled. This fixes an issue with incoming packets on an
unused GEM.

Reported-by: mbilal <muhammad_bilal@mentor.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181123135450.24829-2-edgar.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d95cc27f58..7f63411430 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -979,7 +979,6 @@ static ssize_t gem_receive(NetClientState *nc, const =
uint8_t *buf, size_t size)
=20
         /* Do nothing if receive is not enabled. */
         if (!gem_can_receive(nc)) {
-            assert(!first_desc);
             return -1;
         }
=20
--=20
2.20.0.rc1
