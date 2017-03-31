Received: from eggs.gnu.org ([2001:4830:134:3::10]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAf-0007mW-5M
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAc-0006Bh-4T
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:09 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2017 09:15:54 +0800
Message-Id: <1490922956-19731-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
References: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] e1000: disable debug by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, qemu-stable@nongnu.org

Disable debug output by default, the information were not needed for
release.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>
Cc: Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9324949..f2e5072 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -40,7 +40,7 @@
=20
 static const uint8_t bcast[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
=20
-#define E1000_DEBUG
+/* #define E1000_DEBUG */
=20
 #ifdef E1000_DEBUG
 enum {
--=20
2.7.4
