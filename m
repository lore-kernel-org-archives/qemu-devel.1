Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AX-00083E-Df
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AS-0007VT-Cl
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AS-0007To-3D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29EB73D953
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C357A881FA
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:17 +0200
Message-Id: <1494317205-2211-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[v3]: Rebase & resolve semantic conflicts, with help from Eric Blake
[v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
commit message=20

The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:

  Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v3

for you to fetch changes up to dcd3b25d656d346205dc0f2254723fccf0264e45:

  qmp-shell: improve help (2017-05-09 09:14:41 +0200)

----------------------------------------------------------------
QAPI patches for 2017-05-04

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      tests/check-qdict: Fix missing brackets

Eric Blake (10):
      pci: Use struct instead of QDict to pass back parameters
      pci: Reduce scope of error injection
      coccinelle: Add script to remove useless QObject casts
      qobject: Drop useless QObject casts
      qobject: Add helper macros for common scalar insertions
      qobject: Use simpler QDict/QList scalar insertion macros
      block: Simplify bdrv_append_temp_snapshot() logic
      QemuOpts: Simplify qemu_opts_to_qdict()
      fdc-test: Avoid deprecated 'change' command
      test-qga: Actually test 0xff sync bytes

John Snow (1):
      qmp-shell: add persistent command history

Marc-Andr=C3=A9 Lureau (5):
      test-keyval: fix leaks
      qmp-shell: add -N option to skip negotiate
      qmp-shell: Cope with query-commands error
      qmp-shell: don't show version greeting if unavailable
      qmp-shell: improve help

Markus Armbruster (11):
      sockets: Prepare vsock_parse() for flattened SocketAddress
      sockets: Prepare inet_parse() for flattened SocketAddress
      qapi: New QAPI_CLONE_MEMBERS()
      sockets: Rename SocketAddress to SocketAddressLegacy
      sockets: Rename SocketAddressFlat to SocketAddress
      sockets: Limit SocketAddressLegacy to external interfaces
      sockets: Delete unused helper socket_address_crumple()
      qmp: Improve QMP dispatch error messages
      qobject-input-visitor: Document full_name_nth()
      qapi: Document intended use of @name within alternate visits
      qobject-input-visitor: Catch misuse of end_struct vs. end_list

 MAINTAINERS                         |   1 +
 block.c                             |  70 ++++++--------
 block/blkdebug.c                    |   8 +-
 block/blkverify.c                   |  11 +--
 block/curl.c                        |   2 +-
 block/file-posix.c                  |   8 +-
 block/file-win32.c                  |   4 +-
 block/gluster.c                     |  48 +++++-----
 block/nbd.c                         |  77 ++++++++-------
 block/nfs.c                         |  43 ++++-----
 block/null.c                        |   2 +-
 block/qcow2.c                       |   4 +-
 block/quorum.c                      |  16 ++--
 block/rbd.c                         |  16 ++--
 block/sheepdog.c                    |  20 ++--
 block/snapshot.c                    |   2 +-
 block/ssh.c                         |  16 ++--
 block/vvfat.c                       |  10 +-
 block/vxhs.c                        |   6 +-
 blockdev-nbd.c                      |  21 +++--
 blockdev.c                          |  30 +++---
 chardev/char-socket.c               |  36 +++----
 chardev/char-udp.c                  |  20 ++--
 hmp.c                               |   3 +-
 hw/block/xen_disk.c                 |   2 +-
 hw/pci/pcie_aer.c                   |  48 ++++++----
 hw/usb/xen-usb.c                    |  12 +--
 include/block/nbd.h                 |   3 +
 include/hw/pci/pcie_aer.h           |   4 -
 include/io/channel-socket.h         |   4 +-
 include/qapi/clone-visitor.h        |  14 +++
 include/qapi/qmp/qdict.h            |   8 ++
 include/qapi/qmp/qlist.h            |   8 ++
 include/qapi/visitor.h              |   6 +-
 include/qemu/sockets.h              |  16 ++--
 io/dns-resolver.c                   |  17 ++--
 migration/rdma.c                    |   4 +-
 migration/socket.c                  |  20 ++--
 monitor.c                           |  23 +++--
 qapi-schema.json                    |  35 +++----
 qapi/block-core.json                |   6 +-
 qapi/block.json                     |   2 +-
 qapi/qapi-clone-visitor.c           |  13 +++
 qapi/qmp-dispatch.c                 |  14 +--
 qapi/qmp-event.c                    |   2 +-
 qapi/qobject-input-visitor.c        |  32 ++++++-
 qemu-img.c                          |   6 +-
 qemu-io.c                           |   2 +-
 qemu-nbd.c                          |  11 +--
 qga/main.c                          |   4 +-
 qobject/qdict.c                     |   2 +-
 scripts/coccinelle/qobject.cocci    |  35 +++++++
 scripts/qmp/qmp-shell               |  44 ++++++++-
 target/s390x/cpu_models.c           |   4 +-
 tests/check-qdict.c                 | 144 ++++++++++++++--------------
 tests/check-qlist.c                 |   4 +-
 tests/device-introspect-test.c      |   4 +-
 tests/fdc-test.c                    |   8 +-
 tests/libqtest.c                    |   8 ++
 tests/test-char.c                   |   5 +-
 tests/test-io-channel-socket.c      |  52 +++++------
 tests/test-keyval.c                 |   4 +
 tests/test-qemu-opts.c              |   4 +-
 tests/test-qga.c                    |  41 ++++++--
 tests/test-qmp-commands.c           |  30 +++---
 tests/test-qmp-event.c              |  30 +++---
 tests/test-qobject-output-visitor.c |   6 +-
 ui/vnc-auth-sasl.c                  |   5 +-
 ui/vnc.c                            |  68 +++++++-------
 util/qemu-option.c                  |   6 +-
 util/qemu-sockets.c                 | 181 +++++++++++++++++-------------=
------
 71 files changed, 806 insertions(+), 669 deletions(-)
 create mode 100644 scripts/coccinelle/qobject.cocci

--=20
2.7.4
