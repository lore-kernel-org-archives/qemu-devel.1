Received: from eggs.gnu.org ([209.51.188.92]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe6-0005j5-Uw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxV8-0000Oj-Ku
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:09:35 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:42 +0100
Message-Id: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND 00/15] typedefs: Remove scarcely used
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Hi,

Since this file became a hot topic [*], I took previous cleanups
from last year and continue to clean it.

Regards,

Phil.

[*] "HACKING: Clarify the paragraph about typedefs"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02132.html
[*] "Fix duplicated typedefs to be able to compile with Clang in gnu99 mo=
de"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02117.html

Philippe Mathieu-Daud=C3=A9 (15):
  hw/input/ps2: Remove PS2State from "qemu/typedefs.h"
  hw/pcmcia: Remove PCMCIACardState from "qemu/typedefs.h"
  hw/ssi: Remove SSIBus from "qemu/typedefs.h"
  hw/ide/ahci: Remove AllwinnerAHCIState from "qemu/typedefs.h"
  hw/nvram/fw_cfg: Remove various typedefs from "qemu/typedefs.h"
  hw/i2c/smbus: Remove SMBusDevice from "qemu/typedefs.h"
  hw/bt: Remove HCIInfo from "qemu/typedefs.h"
  hw/char/serial: Remove SerialState from "qemu/typedefs.h"
  hw/i386: Remove PCMachineClass from "qemu/typedefs.h"
  range: Remove Range from "qemu/typedefs.h"
  audio: Remove AudioState from "qemu/typedefs.h"
  ui/console: Remove MouseTransformInfo from qemu/typedefs.h
  ui/console: Remove QemuDmaBuf from "qemu/typedefs.h"
  ui/console: Remove DisplayState/DisplaySurface from "qemu/typedefs.h"
  RFC ui/console: Add "ui/pixelformat.h" to declare PixelFormat

 audio/audio_int.h         |  4 ++--
 hw/arm/strongarm.h        |  1 +
 include/hw/acpi/vmgenid.h |  1 +
 include/hw/arm/pxa.h      |  2 ++
 include/hw/arm/virt.h     |  1 +
 include/hw/char/serial.h  |  4 ++--
 include/hw/devices.h      |  1 +
 include/hw/i2c/smbus.h    |  2 ++
 include/hw/i386/pc.h      |  4 ++--
 include/hw/ide/ahci.h     |  4 ++--
 include/hw/input/ps2.h    |  2 ++
 include/hw/mem/nvdimm.h   |  1 +
 include/hw/nvram/fw_cfg.h |  8 +++++++-
 include/hw/pci-host/q35.h |  1 +
 include/hw/pci/pci.h      |  1 +
 include/hw/pcmcia.h       |  4 ++--
 include/hw/ssi/pl022.h    |  1 +
 include/hw/ssi/ssi.h      |  1 +
 include/qemu/range.h      |  4 ++--
 include/qemu/typedefs.h   | 19 -------------------
 include/sysemu/bt.h       |  4 ++--
 include/ui/console.h      | 25 +++++++++----------------
 include/ui/pixelformat.h  | 31 +++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h  |  2 ++
 24 files changed, 78 insertions(+), 50 deletions(-)
 create mode 100644 include/ui/pixelformat.h

--=20
2.17.2
