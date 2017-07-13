Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA0-0008V3-5m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVe9v-0001Js-MT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVe9v-0001JO-DT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:27:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2108179706
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 13:27:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DED6370467
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 13:27:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:47 +0200
Message-Id: <1499952476-3454-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Error reporting patches for 2017-07-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 31fe1c414501047cbb91b695bdccc0068496dc=
f6:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-07-11 17:13:49 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-07-13

for you to fetch changes up to 88f83f3539fdedd5f315c5fe434ffcb7a010cc73:

  Convert error_report*_err() to warn_report*_err() (2017-07-13 13:50:24 =
+0200)

----------------------------------------------------------------
Error reporting patches for 2017-07-13

----------------------------------------------------------------
Alistair Francis (6):
      util/qemu-error: Rename error_print_loc() to be more generic
      error: Functions to report warnings and informational messages
      Convert error_report() to warn_report()
      char-socket: Report TCP socket waiting as information
      error: Implement the warn and free Error functions
      Convert error_report*_err() to warn_report*_err()

Eduardo Habkost (3):
      xilinx: Fix latent error handling bug
      block: Don't try to set *errp directly
      websock: Don't try to set *errp directly

 block.c                        |   8 ++--
 block/backup.c                 |  12 ++---
 block/gluster.c                |   3 +-
 block/iscsi.c                  |   6 +--
 block/nfs.c                    |  12 ++---
 block/rbd.c                    |   6 +--
 block/ssh.c                    |   4 +-
 blockdev.c                     |   2 +-
 chardev/char-socket.c          |   4 +-
 cpus.c                         |   2 +-
 hw/9pfs/9p.c                   |   2 +-
 hw/arm/highbank.c              |   6 +--
 hw/arm/imx25_pdk.c             |   6 +--
 hw/arm/kzm.c                   |   6 +--
 hw/core/machine.c              |  10 ++--
 hw/core/qdev-properties.c      |  10 ++--
 hw/dma/xilinx_axidma.c         |   4 +-
 hw/i386/acpi-build.c           |  10 ++--
 hw/i386/kvm/pci-assign.c       |   6 +--
 hw/i386/pc.c                   |  13 +++--
 hw/i386/pc_piix.c              |   8 ++--
 hw/i386/pc_q35.c               |   6 +--
 hw/misc/aspeed_sdmc.c          |   8 ++--
 hw/net/xilinx_axienet.c        |   4 +-
 hw/nvram/fw_cfg.c              |   2 +-
 hw/pci-host/piix.c             |   2 +-
 hw/ppc/pnv.c                   |   6 +--
 hw/ppc/spapr.c                 |   4 +-
 hw/ppc/spapr_iommu.c           |   2 +-
 hw/scsi/scsi-bus.c             |   6 +--
 hw/usb/dev-smartcard-reader.c  |   6 +--
 hw/usb/redirect.c              |   2 +-
 include/qapi/error.h           |  11 +++++
 include/qemu/error-report.h    |   7 +++
 io/channel-websock.c           |   4 +-
 net/tap-linux.c                |   2 +-
 scripts/checkpatch.pl          |   7 ++-
 target/i386/cpu.c              |  22 ++++-----
 target/i386/kvm.c              |  12 ++---
 target/s390x/cpu_models.c      |   6 +--
 target/s390x/kvm.c             |   4 +-
 tests/test-qdev-global-props.c |   6 +--
 trace/control.c                |   8 ++--
 util/error.c                   |  20 ++++++++
 util/qemu-error.c              | 106 +++++++++++++++++++++++++++++++++++=
+++---
 vl.c                           |  20 ++++----
 46 files changed, 275 insertions(+), 148 deletions(-)

--=20
2.7.5
