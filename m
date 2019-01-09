Received: from eggs.gnu.org ([209.51.188.92]:47075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDej-00036I-1a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDbi-00007j-JP
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:09:19 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  9 Jan 2019 14:08:38 +0100
Message-Id: <20190109130844.5172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>

The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to 34bec7a8d04f23d6258dcf338894956b945673a5:

  ioapic: use TYPE_FOO MACRO than constant string (2019-01-09 11:33:47 +0100)

----------------------------------------------------------------
Trivial patches for 4.0 (2019-01-09)

----------------------------------------------------------------

Eric Blake (1):
  typedefs: (Re-)sort entries alphabetically

Li Qiang (1):
  ioapic: use TYPE_FOO MACRO than constant string

Priit Laes (1):
  qom: Include qemu/fprintf-fn.h in cpu.h

Thomas Huth (2):
  hw/audio/marvell: Don't include unnecessary i2c.h header file
  trivial: Don't include isa.h if it is not really necessary

Wainer dos Santos Moschetta (1):
  hw/core: fix whitespace in a sentence

 hw/audio/marvell_88w8618.c    |  1 -
 hw/core/machine.c             |  2 +-
 hw/display/ramfb-standalone.c |  1 -
 hw/i386/kvm/ioapic.c          |  2 +-
 hw/i386/pc.c                  |  4 ++--
 hw/ide/pci.c                  |  1 -
 hw/ide/piix.c                 |  1 -
 hw/ide/via.c                  |  1 -
 hw/intc/ioapic.c              |  2 +-
 hw/misc/macio/mac_dbdma.c     |  1 -
 hw/moxie/moxiesim.c           |  1 -
 hw/nvram/fw_cfg.c             |  1 -
 hw/sparc/sun4m.c              |  1 -
 hw/timer/i8254.c              |  1 -
 include/hw/i386/ioapic.h      |  3 +++
 include/qemu/typedefs.h       | 10 +++++-----
 include/qom/cpu.h             |  1 +
 17 files changed, 14 insertions(+), 20 deletions(-)

-- 
2.20.1
