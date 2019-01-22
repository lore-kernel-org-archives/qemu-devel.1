Received: from eggs.gnu.org ([209.51.188.92]:56134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1GG-0005xs-50
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1GD-0003b9-6z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:59:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gm1GC-0003Yp-T1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 22 Jan 2019 16:29:24 +0000
Message-Id: <20190122162924.26491-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update microbit ARM board files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, contrib@steffen-goertz.de, jusual@mail.ru, joel@jms.id.au, jim@groklearning.com, Stefan Hajnoczi <stefanha@redhat.com>

New source files were added without corresponding ./MAINTAINERS file
entries.  Let's get things up to date.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This also includes the I2C/TWI stub which Peter has merged into his
target-arm.next tree but isn't in qemu.git/master yet.
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..e3cb67e81d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -833,7 +833,19 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/nrf51_soc.c
 F: hw/arm/microbit.c
+F: hw/char/nrf51_uart.c
+F: hw/gpio/nrf51_gpio.c
+F: hw/i2c/microbit_i2c.c
+F: hw/misc/nrf51_rng.c
+F: hw/timer/nrf51_timer.c
 F: include/hw/arm/nrf51_soc.h
+F: include/hw/arm/nrf51.h
+F: include/hw/char/nrf51_uart.h
+F: include/hw/gpio/nrf51_gpio.h
+F: include/hw/i2c/microbit_i2c.h
+F: include/hw/misc/nrf51_rng.h
+F: include/hw/timer/nrf51_timer.h
+F: tests/microbit-test.c
=20
 CRIS Machines
 -------------
--=20
2.20.1
