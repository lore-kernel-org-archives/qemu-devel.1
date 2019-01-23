Received: from eggs.gnu.org ([209.51.188.92]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmNNf-0001Xf-PF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmNNc-0002GJ-9p
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gmNNa-0002Es-Ar
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:36:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 18:33:52 +0000
Message-Id: <20190123183352.11025-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] MAINTAINERS: update microbit ARM board files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, jim@groklearning.com, Peter Maydell <peter.maydell@linaro.org>, jusual@mail.ru, contrib@steffen-goertz.de, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

New source files were added without corresponding ./MAINTAINERS file
entries.  Let's get things up to date.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Simplify using wildcard patterns [Thomas]
---
 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..72460f938f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -831,9 +831,11 @@ M: Joel Stanley <joel@jms.id.au>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: hw/arm/nrf51_soc.c
-F: hw/arm/microbit.c
-F: include/hw/arm/nrf51_soc.h
+F: hw/*/nrf51*.c
+F: hw/*/microbit*.c
+F: include/hw/*/nrf51*.h
+F: include/hw/*/microbit*.h
+F: tests/microbit-test.c
=20
 CRIS Machines
 -------------
--=20
2.20.1
