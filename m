Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eW-0007bv-8i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eU-00082S-GD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg9eU-000829-7i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 649C212B24
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1LCYfil026899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:34:42 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 13:34:28 +0100
Message-Id: <1487680479-15132-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Changes to -drive without if= and with
 if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b856256179f14c33a513d0b9cc3e4be355b95f=
43:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170221-1' =
into staging (2017-02-21 09:35:15 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-21

for you to fetch changes up to f778a82f0c179634892ea716970d4d35264dc841:

  hw/i386: Deprecate -drive if=3Dscsi with PC machine types (2017-02-21 1=
3:17:45 +0100)

----------------------------------------------------------------
Changes to -drive without if=3D and with if=3Dscsi

----------------------------------------------------------------
Markus Armbruster (11):
      hw: Default -drive to if=3Dide explicitly where it works
      hw/arm/cubieboard hw/arm/xlnx-ep108: Fix units_per_default_bus
      hw: Default -drive to if=3Dnone instead of ide when ide cannot work
      hw: Default -drive to if=3Dnone instead of scsi when scsi cannot wo=
rk
      hw/arm/highbank: Default -drive to if=3Dide instead of if=3Dscsi
      blockdev: Improve message for orphaned -drive
      blockdev: Make orphaned -drive fatal
      hw: Drop superfluous special checks for orphaned -drive
      hw/scsi: Concentrate -drive if=3Dscsi auto-create in one place
      hw: Deprecate -drive if=3Dscsi with non-onboard HBAs
      hw/i386: Deprecate -drive if=3Dscsi with PC machine types

 blockdev.c                    | 23 ++++++++++--------
 hw/alpha/dp264.c              |  1 +
 hw/arm/cubieboard.c           |  4 ++++
 hw/arm/highbank.c             |  8 +++++--
 hw/arm/realview.c             |  3 +--
 hw/arm/spitz.c                |  3 +++
 hw/arm/tosa.c                 |  1 +
 hw/arm/versatilepb.c          |  2 +-
 hw/arm/vexpress.c             |  1 -
 hw/arm/xilinx_zynq.c          |  1 -
 hw/arm/xlnx-ep108.c           |  6 +++++
 hw/i386/pc.c                  |  7 ++++++
 hw/ide/core.c                 | 17 -------------
 hw/mips/mips_fulong2e.c       |  1 +
 hw/mips/mips_jazz.c           |  4 ----
 hw/mips/mips_malta.c          |  1 +
 hw/mips/mips_r4k.c            |  1 +
 hw/ppc/mac_newworld.c         |  1 +
 hw/ppc/mac_oldworld.c         |  1 +
 hw/ppc/prep.c                 |  1 +
 hw/scsi/esp-pci.c             |  3 ---
 hw/scsi/esp.c                 |  6 -----
 hw/scsi/lsi53c895a.c          | 10 +++++---
 hw/scsi/megasas.c             |  4 ----
 hw/scsi/mptsas.c              |  4 ----
 hw/scsi/scsi-bus.c            | 56 +++++++++++++++++++++++++++++++++++++=
------
 hw/scsi/spapr_vscsi.c         |  5 ++--
 hw/scsi/virtio-scsi.c         |  8 -------
 hw/sh4/r2d.c                  |  1 +
 hw/sparc/sun4m.c              |  5 ----
 hw/sparc64/sun4u.c            |  2 ++
 include/hw/pci/pci.h          |  2 ++
 include/hw/scsi/scsi.h        |  3 ++-
 include/sysemu/blockdev.h     | 11 ++++-----
 qemu-options.hx               |  5 ----
 tests/qemu-iotests/051.pc.out | 12 ++++++----
 vl.c                          | 10 ++++++++
 37 files changed, 137 insertions(+), 97 deletions(-)
