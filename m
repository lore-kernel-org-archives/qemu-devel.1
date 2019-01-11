Received: from eggs.gnu.org ([209.51.188.92]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxeD-0005uM-3q
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxR8-0002Dl-5i
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:05:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:04:23 +0100
Message-Id: <20190111140457.2935-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/33] typedefs: Remove scarcely used
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Artyom Tarasenko <atar4qemu@gmail.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org

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

Eric Blake (1):
  typedefs: (Re-)sort entries alphabetically

Frediano Ziglio (1):
  spice: Remove unused include

Gerd Hoffmann (6):
  egl-headless: add egl_create_context
  keymaps: remove modifiers include
  keymaps: drop nl-be map
  keymaps: remove common include
  keymaps: drop support for include files
  usb-audio: ignore usb packages with wrong size

Li Qiang (1):
  ioapic: use TYPE_FOO MACRO than constant string

Marc-Andr=C3=A9 Lureau (1):
  configure: bump spice-server required version to 0.12.5

Peter Maydell (2):
  ui/console: Remove qemu_create_display_surface_guestmem()
  linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0

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

Priit Laes (1):
  qom: Include qemu/fprintf-fn.h in cpu.h

Thomas Huth (3):
  hw/audio/marvell: Don't include unnecessary i2c.h header file
  trivial: Don't include isa.h if it is not really necessary
  hw/audio/marvell: Don't include unnecessary i2c.h header file

Tom Deseyn (1):
  Add getsockopt for settable SOL_IPV6 options

Wainer dos Santos Moschetta (1):
  hw/core: fix whitespace in a sentence

--=20
2.17.2
