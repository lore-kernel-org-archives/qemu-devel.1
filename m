Received: from eggs.gnu.org ([2001:4830:134:3::10]:53344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5g-0002Uj-BK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5c-0007n8-Dh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5c-0007mq-9R
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:36 -0400
Received: by mail-qk0-x243.google.com with SMTP id h200so6325484qke.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:27:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 18:27:23 -0300
Message-Id: <20180419212727.26095-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/4] qdev: remove DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

Since v2:
  - rebased for 2.13 (Markus)
  - dropped 2 patches already merged (Gerd)
  - start sentences with a capital letter and end with a full stop (Peter)

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

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  hw/i2c/smbus: Use DeviceClass::realize instead of SMBusDeviceClass::init
  hw/i2c: Use DeviceClass::realize instead of I2CSlaveClass::init
  qdev: Simplify the SysBusDeviceClass::init path
  qdev: Remove DeviceClass::exit

 include/hw/i2c/i2c.h    |  3 ---
 include/hw/i2c/smbus.h  |  1 -
 include/hw/qdev-core.h  |  4 ----
 hw/audio/wm8750.c       |  8 +++-----
 hw/core/qdev.c          | 28 ----------------------------
 hw/core/sysbus.c        | 15 ++++++++++-----
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
 16 files changed, 48 insertions(+), 115 deletions(-)

-- 
2.17.0
