Received: from eggs.gnu.org ([209.51.188.92]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wki-0005OR-Tx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wki-0003MB-88
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 18:23:49 +0100
Message-Id: <20190307172401.29451-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/12] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

Based-on: <20190307130323.9353-1-armbru@redhat.com>

v2:
* PATCH 05,06: New [Philippe]
* PATCH 07: Old PATCH 5 rebased onto new patches, with new comment
  [Philippe]
* PATCH 08+10: New, factored out of old PATCH 6 [by Philippe]
* PATCH 09: New [by Philippe]
* PATCH 11: Remainder of old PATCH 6, with FIXME resolved, literal
  4096 de-duplicated [L=C3=A1szl=C3=B3], extraneous error check deleted
  [L=C3=A1szl=C3=B3], and comment typos fixed
* PATCH 12: New

Markus Armbruster (9):
  qdev: Fix latent bug with compat_props and onboard devices
  qom: Move compat_props machinery from qdev to QOM
  vl: Fix latent bug with -global and onboard devices
  sysbus: Fix latent bug with onboard devices
  vl: Improve legibility of BlockdevOptions queue
  vl: Factor configure_blockdev() out of main()
  vl: Create block backends before setting machine properties
  pc: Support firmware configuration with -blockdev
  docs/interop/firmware.json: Prefer -machine to if=3Dpflash

Philippe Mathieu-Daud=C3=A9 (3):
  pflash_cfi01: Add pflash_cfi01_get_blk() helper
  pc_sysfw: Remove unused PcSysFwDevice
  pc_sysfw: Pass PCMachineState to pc_system_firmware_init()

 accel/accel.c              |   1 +
 docs/interop/firmware.json |  21 +++-
 hw/block/pflash_cfi01.c    |   5 +
 hw/core/qdev.c             |  21 +---
 hw/core/sysbus.c           |   3 -
 hw/i386/pc.c               |   4 +-
 hw/i386/pc_sysfw.c         | 249 ++++++++++++++++++++++++-------------
 include/hw/block/flash.h   |   1 +
 include/hw/i386/pc.h       |   6 +-
 include/hw/qdev-core.h     |   2 -
 include/qom/object.h       |   3 +
 qom/object.c               |  39 ++++++
 vl.c                       | 122 +++++++++---------
 13 files changed, 301 insertions(+), 176 deletions(-)

--=20
2.17.2
