Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gTkji-0002bg-5W
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gTkUe-000376-Q7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:26:24 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:27724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1gTkUe-000332-Is
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:26:20 -0500
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Mon,  3 Dec 2018 10:26:14 +0100
Message-Id: <20181203092617.24090-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qapi: return ShutdownCause for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This series improves the QMP SHUTDOWN and RESET events by adding
the ShutdownCause as additional parameter and splitting
the HOST_QMP reason into HOST_QMP_QUIT and HOST_QMP_SYSTEM_RESET
to be able to detect the difference between them when using '--no-reboot'

this is an alternative to my previous patches[1][2] which
added an exit-script/added a 'reset' argument to the events

 1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00697.html
 2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01271.html

changes from v1:
* explain the reason for the patches in more detail in commit messages
* better punctuation and wording in commit messages
* switched patch 2 and 3
* fix iotests after both 2 and 3
* added documentation for 'reason' in the SHUTDOWN/RESET events
  (this was missing in v1)

Dominik Csapak (3):
  qapi: Turn ShutdownCause into QAPI enum
  qapi: Add reason to SHUTDOWN and RESET events
  qapi: Split host-qmp into quit and system-reset

 include/sysemu/sysemu.h    | 20 --------------------
 qapi/run-state.json        | 44 ++++++++++++++++++++++++++++++++++++++++++--
 qmp.c                      |  4 ++--
 tests/qemu-iotests/060.out |  4 ++--
 tests/qemu-iotests/071.out |  4 ++--
 tests/qemu-iotests/081.out | 14 +++++++-------
 tests/qemu-iotests/087.out | 12 ++++++------
 tests/qemu-iotests/094.out |  2 +-
 tests/qemu-iotests/109.out | 44 ++++++++++++++++++++++----------------------
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
 vl.c                       |  4 ++--
 25 files changed, 133 insertions(+), 101 deletions(-)

-- 
2.11.0
