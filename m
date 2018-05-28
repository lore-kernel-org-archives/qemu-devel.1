Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNJOe-0008O5-WC
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNJOa-0005dQ-1C
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fNJOZ-0005c0-S9
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:45:11 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 28 May 2018 16:45:05 +0200
Message-Id: <20180528144509.15812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/4] qdev: remove DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, ehabkost@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, thuth@redhat.com

This lovely series got stuck after v3, so I took the liberty to respin
it.

v4:
* PATCH 1+2 unchanged
* PATCH 3+4 reshuffled a bit, missing documentation updates supplied


Philippe's cover letter:

Since v2:
  - rebased for 2.13 (Markus)
  - dropped 2 patches already merged (Gerd)
  - start sentences with a capital letter and end with a full stop (Peter=
)

since v1:
  - fix format string on 32-bit host (patchew)
  - do not add smbus_eeprom_reset() (Eduardo)
  - directly use DeviceClass::realize (Eduardo)
  - squashed 2 patches (Eduardo)

Hi,

This series finalize the qdev QOMification.

We first convert the I2CSlave/SMBusDevice,
then the usb-ccid and virtio-ccw,
and finally the SysBusDevice.

At the end we removed *TWO* TODO :)

    /* TODO remove, once users are converted to realize */
    /* TODO remove, once users are converted to unrealize */

Philippe Mathieu-Daud=C3=A9 (4):
  hw/i2c/smbus: Use DeviceClass::realize instead of
    SMBusDeviceClass::init
  hw/i2c: Use DeviceClass::realize instead of I2CSlaveClass::init
  qdev: Simplify the SysBusDeviceClass::init path
  qdev: Remove DeviceClass::init() and ::exit()

 hw/audio/wm8750.c       |  8 +++-----
 hw/core/qdev.c          | 28 ----------------------------
 hw/core/sysbus.c        | 12 ++++++++----
 hw/display/ssd0303.c    |  9 ++++-----
 hw/gpio/max7310.c       |  9 ++++-----
 hw/i2c/core.c           | 13 -------------
 hw/i2c/smbus.c          |  9 ---------
 hw/i2c/smbus_eeprom.c   |  5 ++---
 hw/input/lm832x.c       |  9 ++++-----
 hw/misc/tmp105.c        |  7 +++----
 hw/misc/tmp421.c        |  8 +++-----
 hw/nvram/eeprom_at24c.c | 24 +++++++++++-------------
 hw/timer/twl92230.c     | 11 ++++-------
 include/hw/i2c/i2c.h    |  3 ---
 include/hw/i2c/smbus.h  |  1 -
 include/hw/qdev-core.h  | 20 ++++----------------
 16 files changed, 50 insertions(+), 126 deletions(-)

--=20
2.13.6
