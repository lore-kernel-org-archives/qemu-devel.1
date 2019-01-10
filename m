Received: from eggs.gnu.org ([209.51.188.92]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpK-0000Ir-JL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpI-0007Zt-H3
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Jan 2019 09:40:18 +0000
Message-Id: <20190110094020.18354-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, Thomas Huth <thuth@redhat.com>, contrib@steffen-goertz.de, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Move stub code into a separate device [Peter]
 * Instantiate stub from microbit board instead of nRF51 SoC since this i=
s
   microbit-specific.  Other boards using the nRF51 wouldn't necessarily =
want
   to see these TWI/I2C devices.
 * Add test case

This series stubs out the microbit's TWI/I2C devices so the microbit-dal
firmware boots successfully.  The accelerometer and magnetometer are prob=
ed at
startup.  If they are not found the firmware panics.

Stefan Hajnoczi (1):
  tests/microbit-test: add TWI stub device test

Steffen G=C3=B6rtz (1):
  arm: Stub out NRF51 TWI magnetometer/accelerometer detection

 hw/i2c/Makefile.objs          |   1 +
 include/hw/arm/nrf51.h        |   2 +
 include/hw/arm/nrf51_soc.h    |   1 +
 include/hw/i2c/microbit_i2c.h |  42 +++++++++++
 hw/arm/microbit.c             |  15 ++++
 hw/i2c/microbit_i2c.c         | 127 ++++++++++++++++++++++++++++++++++
 tests/microbit-test.c         |  44 ++++++++++++
 7 files changed, 232 insertions(+)
 create mode 100644 include/hw/i2c/microbit_i2c.h
 create mode 100644 hw/i2c/microbit_i2c.c

--=20
2.20.1
