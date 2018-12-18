Received: from eggs.gnu.org ([2001:4830:134:3::10]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJx-00060T-ID
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJu-00086Z-Sp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJu-0007yE-IC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1B787FD44
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 10:09:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E5175C229
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 10:09:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:34 +0100
Message-Id: <20181218100941.25267-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] QAPI patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f=
6c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into =
staging (2018-12-17 13:04:25 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-12-18

for you to fetch changes up to ce1a1aec47877a281d69dbc2e65f86bfe8fea231:

  qapi: fix flat union on uncovered branches conditionals (2018-12-18 07:=
57:36 +0100)

----------------------------------------------------------------
QAPI patches for 2018-12-18

* QMP events SHUTDOWN and RESET now carry a reason
* New QMP command query-current-machine
* QMP/HMP command system_wakeup now fails when the guest isn't
  suspended, or doesn't even support suspend.
* Fix build for --disable-replication

----------------------------------------------------------------
Daniel Henrique Barboza (3):
      qmp: query-current-machine with wakeup-suspend-support
      qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
      qmp hmp: Make system_wakeup check wake-up support and run state

Dominik Csapak (3):
      qapi: Turn ShutdownCause into QAPI enum
      qmp: Add reason to SHUTDOWN and RESET events
      qmp: Split ShutdownCause host-qmp into quit and system-reset

Marc-Andr=C3=A9 Lureau (1):
      qapi: fix flat union on uncovered branches conditionals

 hmp.c                      |  5 ++++-
 hw/acpi/core.c             |  9 ++++++++-
 hw/char/serial.c           |  2 +-
 hw/i386/xen/xen-hvm.c      |  5 +++++
 hw/input/ps2.c             |  6 +++---
 hw/timer/mc146818rtc.c     |  2 +-
 include/sysemu/sysemu.h    | 24 +++---------------------
 migration/migration.c      |  4 ++--
 qapi/misc.json             | 32 +++++++++++++++++++++++++++++++-
 qapi/run-state.json        | 44 ++++++++++++++++++++++++++++++++++++++++=
++--
 qga/qapi-schema.json       | 16 ++++++++++------
 qmp.c                      | 12 +++++++++---
 scripts/qapi/common.py     |  3 ++-
 tests/qemu-iotests/060.out |  4 ++--
 tests/qemu-iotests/071.out |  4 ++--
 tests/qemu-iotests/081.out | 14 +++++++-------
 tests/qemu-iotests/087.out | 12 ++++++------
 tests/qemu-iotests/094.out |  2 +-
 tests/qemu-iotests/109.out | 44 ++++++++++++++++++++++------------------=
----
 tests/qemu-iotests/117.out |  2 +-
 tests/qemu-iotests/119.out |  2 +-
 tests/qemu-iotests/120.out |  2 +-
 tests/qemu-iotests/127.out |  2 +-
 tests/qemu-iotests/140.out |  2 +-
 tests/qemu-iotests/143.out |  2 +-
 tests/qemu-iotests/156.out |  2 +-
 tests/qemu-iotests/176.out | 16 ++++++++--------
 tests/qemu-iotests/183.out |  4 ++--
 tests/qemu-iotests/184.out | 12 ++++++++----
 tests/qemu-iotests/185.out | 10 +++++-----
 tests/qemu-iotests/191.out |  6 ++++--
 tests/qemu-iotests/195.out |  6 ++++--
 tests/qemu-iotests/223.out |  2 +-
 tests/qemu-iotests/227.out | 12 ++++++++----
 vl.c                       | 27 ++++++++++++++++++++++++---
 35 files changed, 232 insertions(+), 121 deletions(-)

--=20
2.17.2
