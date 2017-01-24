Received: from eggs.gnu.org ([2001:4830:134:3::10]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cW7iO-0003Ui-JH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cW7iL-00032W-D4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:29:16 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 23:29:08 +0300
Message-Id: <cover.1485289633.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-01-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Rebased, yes it was a trivial merge conflict (a trivial patch
changed comment in a removed section of a file). The same as
before, with the merge conflict fixed and an r-b added.

Not resending other stuff, just the cover letter.

Thanks,

/mjt

The following changes since commit a9e404600a9bd1e6a26431fc89e5069092e67f=
14:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170124' into =
staging (2017-01-24 17:26:26 +0000)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 5658ffa39aae034458231bc4abfee57637b88c6e:

  hw/isa/isa-bus: Set category of the "isabus-bridge" device (2017-01-24 =
23:26:54 +0300)

----------------------------------------------------------------
trivial patches for 2017-01-24

----------------------------------------------------------------
Cao jin (5):
      pcie: fix typo in comments
      doc/usb2: fix typo
      vfio: remove a duplicated word in comments
      util/mmap-alloc: check parameter before using
      util/mmap-alloc: refactor a little bit for readability

Frediano Ziglio (1):
      usb: Fix typo in documentation

Gerd Hoffmann (1):
      docs: sync pci-ids.txt

Marc-Andr=C3=A9 Lureau (3):
      object.h: spelling fix
      object: make some funcs static
      win32: use glib gpoll if glib >=3D 2.50

Michael Tokarev (1):
      doc: don't mention -memory, it is -m

Paolo Bonzini (4):
      qemu-img: remove dead check
      pci-assign: avoid pointless stat
      block: remove dead check
      qga: fix erroneous argument to strerror

Peter Maydell (6):
      README: Add linux to macOS build info
      hw/i386/kvmvapic: Remove dead code in patch_hypercalls()
      lm32: milkymist-tmu2: fix another integer overflow
      disas/cris.c: Fix Coverity warning about unchecked NULL
      hw/display/framebuffer.c: Avoid overflow for framebuffers > 4GB
      scsi-disk: add 'fall through' comment to switch VERIFY cases

Po-Hsu Lin (1):
      qemu-options: cleanup duplicated help message for kernel_irqchip

Samuel Thibault (1):
      Drop duplicate display option documentation

Stefan Weil (4):
      hw/block/m25p80: Fix typo in local macro name
      Fix documentation and some comments (article, grammar)
      include: Fix typos found by codespell
      hw: Fix typos found by codespell

Thomas Huth (2):
      usb: Set category and description of the MTP device
      hw/isa/isa-bus: Set category of the "isabus-bridge" device

Ziyue Yang (2):
      gdbstub.c: fix GDB connection segfault caused by empty machines
      gdbstub.c: update old error report statements

 README                         |  1 +
 block.c                        |  2 +-
 disas/cris.c                   |  2 +-
 docs/specs/pci-ids.txt         |  3 +++
 docs/usb-storage.txt           |  2 +-
 docs/usb2.txt                  |  2 +-
 gdbstub.c                      | 17 ++++++++++++-----
 hw/block/m25p80.c              |  4 ++--
 hw/core/generic-loader.c       |  4 ++--
 hw/core/qdev-properties.c      |  2 +-
 hw/display/framebuffer.c       |  2 +-
 hw/display/milkymist-tmu2.c    |  2 +-
 hw/display/xlnx_dp.c           |  4 ++--
 hw/i386/kvmvapic.c             |  6 ------
 hw/i386/pc.c                   |  2 +-
 hw/i386/pci-assign-load-rom.c  | 16 ++++++++--------
 hw/isa/isa-bus.c               |  1 +
 hw/net/cadence_gem.c           |  2 +-
 hw/net/spapr_llan.c            |  4 ++--
 hw/pci/pcie.c                  |  2 +-
 hw/ppc/spapr_drc.c             |  2 +-
 hw/s390x/s390-pci-bus.h        |  4 ++--
 hw/scsi/scsi-disk.c            |  1 +
 hw/usb/dev-mtp.c               |  4 +++-
 hw/vfio/pci-quirks.c           |  2 +-
 hw/vfio/pci.c                  |  4 ++--
 hw/virtio/virtio-crypto.c      |  2 +-
 include/glib-compat.h          |  2 +-
 include/hw/dma/xlnx_dpdma.h    |  3 ++-
 include/hw/pci-host/q35.h      |  2 +-
 include/hw/register.h          |  2 +-
 include/qapi/dealloc-visitor.h |  2 +-
 include/qemu/qht.h             |  2 +-
 include/qemu/xattr.h           |  2 +-
 include/qom/object.h           | 26 +-------------------------
 qemu-doc.texi                  |  2 +-
 qemu-img.c                     | 12 +++++-------
 qemu-options.hx                |  7 +++----
 qga/main.c                     |  4 ++--
 qom/object.c                   |  4 ++--
 util/mmap-alloc.c              | 17 ++++++++---------
 util/oslib-win32.c             |  2 ++
 util/uri.c                     |  4 ++--
 43 files changed, 88 insertions(+), 104 deletions(-)
