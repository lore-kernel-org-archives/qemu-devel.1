Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViF-00050Y-He
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001WQ-F4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Uv-3B
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 411644026129
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:04:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A9383B8B
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:04:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:44 +0200
Message-Id: <20180504080454.11014-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] QAPI patches for 2018-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 59255887e6cafeff747250d2613003a41d1d9d=
ff:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into =
staging (2018-05-03 11:25:14 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-05-04

for you to fetch changes up to 6ffa3ab453b431ec047ff1fc87120059b5266014:

  qapi: deprecate CpuInfoFast.arch (2018-05-04 08:27:53 +0200)

----------------------------------------------------------------
QAPI patches for 2018-05-04

----------------------------------------------------------------
Laszlo Ersek (5):
      qapi: fill in CpuInfoFast.arch in query-cpus-fast
      qapi: add SysEmuTarget to "common.json"
      qapi: change the type of TargetInfo.arch from string to enum SysEmu=
Target
      qapi: discriminate CpuInfoFast on SysEmuTarget, not CpuInfoArch
      qapi: deprecate CpuInfoFast.arch

Marc-Andr=C3=A9 Lureau (4):
      qobject: Ensure base is at offset 0
      qobject: use a QObjectBase_ struct
      qobject: Replace qobject_incref/QINCREF qobject_decref/QDECREF
      qobject: Modify qobject_ref() to return obj

Markus Armbruster (1):
      qobject: Use qobject_to() instead of type cast

 arch_init.c                         |   4 +-
 block.c                             |  82 +++++++++++++--------------
 block/blkdebug.c                    |   7 +--
 block/blkverify.c                   |   8 +--
 block/crypto.c                      |   4 +-
 block/gluster.c                     |   4 +-
 block/iscsi.c                       |   2 +-
 block/nbd.c                         |   4 +-
 block/nfs.c                         |   4 +-
 block/null.c                        |   3 +-
 block/nvme.c                        |   3 +-
 block/parallels.c                   |   4 +-
 block/qapi.c                        |   2 +-
 block/qcow.c                        |   8 +--
 block/qcow2.c                       |   8 +--
 block/qed.c                         |   4 +-
 block/quorum.c                      |   4 +-
 block/rbd.c                         |  14 ++---
 block/sheepdog.c                    |  12 ++--
 block/snapshot.c                    |   4 +-
 block/ssh.c                         |   4 +-
 block/vdi.c                         |   2 +-
 block/vhdx.c                        |   4 +-
 block/vpc.c                         |   4 +-
 block/vvfat.c                       |   2 +-
 block/vxhs.c                        |   2 +-
 blockdev.c                          |  16 +++---
 cpus.c                              |  73 ++++++++++++++++++++----
 docs/devel/qapi-code-gen.txt        |   2 +-
 hw/i386/acpi-build.c                |  12 ++--
 hw/ppc/spapr_drc.c                  |   2 +-
 hw/usb/xen-usb.c                    |   4 +-
 include/qapi/qmp/qbool.h            |   2 +-
 include/qapi/qmp/qdict.h            |   2 +-
 include/qapi/qmp/qlist.h            |   2 +-
 include/qapi/qmp/qnull.h            |   5 +-
 include/qapi/qmp/qnum.h             |   2 +-
 include/qapi/qmp/qobject.h          |  81 +++++++++++++++------------
 include/qapi/qmp/qstring.h          |   2 +-
 migration/migration.c               |   4 +-
 migration/qjson.c                   |   2 +-
 monitor.c                           |  58 +++++++++----------
 qapi/common.json                    |  23 ++++++++
 qapi/misc.json                      |  68 +++++++++++++++++------
 qapi/qapi-dealloc-visitor.c         |   4 +-
 qapi/qmp-dispatch.c                 |   6 +-
 qapi/qobject-input-visitor.c        |  10 ++--
 qapi/qobject-output-visitor.c       |  11 ++--
 qemu-doc.texi                       |   5 ++
 qemu-img.c                          |  18 +++---
 qemu-io.c                           |   6 +-
 qga/main.c                          |  12 ++--
 qmp.c                               |   4 +-
 qobject/json-parser.c               |  10 ++--
 qobject/qdict.c                     |  49 +++++++---------
 qobject/qjson.c                     |   2 +-
 qobject/qlist.c                     |   4 +-
 qobject/qobject.c                   |  21 +++++--
 qom/object.c                        |  16 +++---
 qom/object_interfaces.c             |   2 +-
 scripts/coccinelle/qobject.cocci    |   8 +--
 scripts/qapi/common.py              |   2 +-
 scripts/qapi/events.py              |   2 +-
 target/ppc/translate_init.c         |   2 +-
 target/s390x/cpu_models.c           |   2 +-
 tests/ahci-test.c                   |   6 +-
 tests/check-qdict.c                 | 108 ++++++++++++++++++------------=
------
 tests/check-qjson.c                 |  84 ++++++++++++++--------------
 tests/check-qlist.c                 |   8 +--
 tests/check-qlit.c                  |  10 ++--
 tests/check-qnull.c                 |  10 ++--
 tests/check-qnum.c                  |  28 +++++-----
 tests/check-qobject.c               |   2 +-
 tests/check-qstring.c               |  10 ++--
 tests/cpu-plug-test.c               |   4 +-
 tests/device-introspect-test.c      |  24 ++++----
 tests/drive_del-test.c              |   4 +-
 tests/libqos/libqos.c               |   8 +--
 tests/libqos/pci-pc.c               |   2 +-
 tests/libqtest.c                    |  24 ++++----
 tests/machine-none-test.c           |   2 +-
 tests/migration-test.c              |  26 ++++-----
 tests/numa-test.c                   |  16 +++---
 tests/pvpanic-test.c                |   2 +-
 tests/q35-test.c                    |   2 +-
 tests/qmp-test.c                    |  38 ++++++-------
 tests/qom-test.c                    |   8 +--
 tests/tco-test.c                    |  12 ++--
 tests/test-char.c                   |   2 +-
 tests/test-keyval.c                 |  82 +++++++++++++--------------
 tests/test-netfilter.c              |  26 ++++-----
 tests/test-qemu-opts.c              |  14 ++---
 tests/test-qga.c                    |  76 ++++++++++++-------------
 tests/test-qmp-cmds.c               |  24 ++++----
 tests/test-qmp-event.c              |   2 +-
 tests/test-qobject-input-visitor.c  |  10 ++--
 tests/test-qobject-output-visitor.c |  18 +++---
 tests/test-visitor-serialization.c  |   6 +-
 tests/test-x86-cpuid-compat.c       |  14 ++---
 tests/tmp105-test.c                 |   4 +-
 tests/vhost-user-test.c             |   6 +-
 tests/virtio-net-test.c             |   6 +-
 tests/vmgenid-test.c                |   2 +-
 tests/wdt_ib700-test.c              |  14 ++---
 util/keyval.c                       |  12 ++--
 util/qemu-config.c                  |   4 +-
 106 files changed, 816 insertions(+), 703 deletions(-)
