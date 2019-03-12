Received: from eggs.gnu.org ([209.51.188.92]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vsg-0008P6-Bb
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3VlW-0007Fq-6d
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3VlV-0007FJ-W8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:23 -0300
Message-Id: <20190312005930.9043-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Machine queue, 2019-03-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit 336cfef495f0cd5b1606251c52628d0372e9a8=
09:

  Makefile: Don't install non-sphinx files in sphinx docs install (2019-0=
3-11 11:10:44 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to edaed6c711f07267785a05a633d97dc9268a7385:

  memfd: improve error messages (2019-03-11 17:17:01 -0300)

----------------------------------------------------------------
Machine queue, 2019-03-11

* memfd fixes (Ilya Maximets)
* Move nvdimms state into struct MachineState (Eric Auger)
* hostmem-file: reject invalid pmem file sizes (Stefan Hajnoczi)

----------------------------------------------------------------

Queue for Machine Core patches


Eric Auger (2):
  nvdimm: Rename AcpiNVDIMMState into NVDIMMState
  machine: Move nvdimms state into struct MachineState

Ilya Maximets (4):
  hostmem-memfd: disable for systems without sealing support
  memfd: always check for MFD_CLOEXEC
  memfd: set up correct errno if not supported
  memfd: improve error messages

Stefan Hajnoczi (1):
  hostmem-file: reject invalid pmem file sizes

 include/hw/boards.h      |  2 ++
 include/hw/i386/pc.h     |  4 ---
 include/hw/mem/nvdimm.h  | 10 +++----
 include/qemu/osdep.h     | 13 ++++++++
 backends/hostmem-file.c  | 23 ++++++++++++++
 backends/hostmem-memfd.c | 18 +++++------
 hw/acpi/nvdimm.c         | 18 +++++------
 hw/core/machine.c        | 65 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c     |  6 ++--
 hw/i386/pc.c             | 57 ++++-------------------------------
 hw/i386/pc_piix.c        |  4 +--
 hw/i386/pc_q35.c         |  4 +--
 tests/vhost-user-test.c  |  5 ++--
 util/memfd.c             | 10 +++++--
 util/oslib-posix.c       | 53 ++++++++++++++++++++++++++++++++
 util/oslib-win32.c       |  5 ++++
 16 files changed, 206 insertions(+), 91 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
