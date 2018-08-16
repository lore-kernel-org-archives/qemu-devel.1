Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmT-0000qc-3H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmH-0005C6-Qs
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmB-00058t-Ts
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 613FB40150F8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E9C22026D7E
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:36 +0200
Message-Id: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/25] Testing patches for 2018-08-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c146b54c7fdbd926ee8fc4369699e3480d54f6=
fa:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-08-15'=
 into staging (2018-08-15 20:20:34 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-tests-2018-08-16

for you to fetch changes up to f9e986d237881fda3ce599a89c26433531f5acbb:

  libqtest: Improve error reporting for bad read from QEMU (2018-08-16 08=
:43:53 +0200)

----------------------------------------------------------------
Testing patches for 2018-08-16

----------------------------------------------------------------
Eric Blake (2):
      libqtest: Document calling conventions
      tests/libqtest: Improve kill_qemu()

Markus Armbruster (23):
      libqtest: Rename functions to send QMP messages
      libqtest: Clean up how we read device_del messages
      libqtest: Clean up how we read the QMP greeting
      libqtest: Remove qtest_qmp_discard_response() & friends
      qobject: Replace qobject_from_jsonf() by qobject_from_jsonf_nofail(=
)
      qobject: New qobject_from_vjsonf_nofail(), qdict_from_vjsonf_nofail=
()
      libqtest: Simplify qmp_fd_vsend() a bit
      test-qobject-input-visitor: Avoid format string ambiguity
      qobject: qobject_from_jsonv() is dangerous, hide it away
      tests: Pass literal format strings directly to qmp_FOO()
      tests: Clean up string interpolation into QMP input (simple cases)
      cpu-plug-test: Don't pass integers as strings to device_add
      tests: Clean up string interpolation around qtest_qmp_device_add()
      migration-test: Make wait_command() return the "return" member
      tests: New helper qtest_qmp_receive_success()
      migration-test: Make wait_command() cope with '%'
      migration-test: Clean up string interpolation into QMP, part 1
      migration-test: Clean up string interpolation into QMP, part 2
      migration-test: Clean up string interpolation into QMP, part 3
      libqtest: Enable compile-time format string checking
      libqtest: Replace qtest_startf() by qtest_initf()
      libqtest: Rename qtest_FOOv() to qtest_vFOO() for consistency
      libqtest: Improve error reporting for bad read from QEMU

 include/qapi/qmp/qjson.h           |  12 +-
 qobject/qjson.c                    |  89 +++++++++++----
 tests/ahci-test.c                  |  15 +--
 tests/boot-order-test.c            |  13 ++-
 tests/boot-serial-test.c           |  10 +-
 tests/cdrom-test.c                 |   6 +-
 tests/check-qjson.c                |  15 +--
 tests/cpu-plug-test.c              |   7 +-
 tests/drive_del-test.c             |   3 +
 tests/e1000e-test.c                |   6 +-
 tests/endianness-test.c            |  24 ++--
 tests/fdc-test.c                   |   4 +
 tests/ide-test.c                   |   9 +-
 tests/ipmi-bt-test.c               |   2 +-
 tests/ivshmem-test.c               |   8 +-
 tests/libqos/ahci.c                |   4 +-
 tests/libqos/pci-pc.c              |   9 +-
 tests/libqos/pci.c                 |   7 --
 tests/libqos/pci.h                 |   2 -
 tests/libqos/usb.c                 |  10 +-
 tests/libqos/usb.h                 |   2 +-
 tests/libqtest.c                   | 219 ++++++++++++++++++++-----------=
------
 tests/libqtest.h                   | 124 +++++++++++----------
 tests/m25p80-test.c                |   6 +-
 tests/m48t59-test.c                |   2 +-
 tests/machine-none-test.c          |   2 +-
 tests/migration-test.c             | 187 ++++++++++++++-----------------
 tests/numa-test.c                  |   4 +-
 tests/pnv-xscom-test.c             |   8 +-
 tests/prom-env-test.c              |  10 +-
 tests/qmp-test.c                   |  20 ++--
 tests/sdhci-test.c                 |   6 +-
 tests/tco-test.c                   |   6 +-
 tests/test-filter-mirror.c         |   6 +-
 tests/test-filter-redirector.c     |   8 +-
 tests/test-qga.c                   | 150 +++++++++++--------------
 tests/test-qobject-input-visitor.c |  19 ++--
 tests/tpm-util.c                   |  41 ++-----
 tests/usb-hcd-ehci-test.c          |   2 +-
 tests/usb-hcd-ohci-test.c          |   2 +-
 tests/usb-hcd-uhci-test.c          |   4 +-
 tests/usb-hcd-xhci-test.c          |  10 +-
 tests/vhost-user-test.c            |   6 +-
 tests/virtio-balloon-test.c        |   4 +-
 tests/virtio-blk-test.c            |  17 ++-
 tests/virtio-console-test.c        |  12 +-
 tests/virtio-net-test.c            |   3 +-
 tests/virtio-rng-test.c            |   3 +-
 tests/virtio-scsi-test.c           |   2 +-
 tests/virtio-serial-test.c         |   6 +-
 tests/vmgenid-test.c               |   6 +-
 51 files changed, 585 insertions(+), 567 deletions(-)

--=20
2.17.1
