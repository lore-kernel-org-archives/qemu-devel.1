Received: from eggs.gnu.org ([209.51.188.92]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fb-0002bq-1r
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14FX-0000PQ-Dv
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14FV-0000NG-Kb
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:26 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:07 +0800
Message-Id: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL V2 00/13] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit b6179aaff961627fcb59d7b234297966b81ac7=
26:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20190304=
' into staging (2019-03-04 16:50:41 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 4b9b70000218640a42c3ea908a12665e5840b6cd:

  tests: Add a test for qemu self announcements (2019-03-05 11:27:41 +080=
0)

----------------------------------------------------------------

Changes from V1:
- build fixes for qmp controlled announcing

----------------------------------------------------------------
Dr. David Alan Gilbert (9):
      net: Introduce announce timer
      migration: Add announce parameters
      virtio-net: Switch to using announce timer
      migration: Switch to using announce timer
      net: Add a network device specific self-announcement ability
      virtio-net: Allow qemu_announce_self to trigger virtio announcement=
s
      qmp: Add announce-self command
      hmp: Add hmp_announce_self
      tests: Add a test for qemu self announcements

Vincenzo Maffione (3):
      net: netmap: small improvements netmap_send()
      net: netmap: simplify netmap_receive()
      net: netmap: improve netmap_receive_iov()

Zhang Chen (1):
      net/colo-compare.c: Remove duplicated code

 hmp-commands.hx                |  16 +++++
 hmp.c                          |  33 ++++++++++
 hmp.h                          |   1 +
 hw/net/trace-events            |   6 ++
 hw/net/virtio-net.c            |  69 +++++++++++++++-----
 include/hw/virtio/virtio-net.h |   4 +-
 include/migration/misc.h       |  12 +---
 include/net/announce.h         |  41 ++++++++++++
 include/net/net.h              |   2 +
 include/qemu/typedefs.h        |   1 +
 include/sysemu/sysemu.h        |   2 -
 migration/migration.c          | 103 +++++++++++++++++++++++++++++-
 migration/migration.h          |   4 ++
 migration/savevm.c             |  72 +--------------------
 migration/trace-events         |   1 -
 net/Makefile.objs              |   1 +
 net/announce.c                 | 140 +++++++++++++++++++++++++++++++++++=
++++++
 net/colo-compare.c             |   8 ---
 net/netmap.c                   | 110 ++++++++++++++------------------
 net/trace-events               |   3 +
 qapi/migration.json            |  53 +++++++++++++++-
 qapi/net.json                  |  43 +++++++++++++
 tests/Makefile.include         |   3 +
 tests/test-announce-self.c     |  82 ++++++++++++++++++++++++
 tests/test-hmp.c               |   1 +
 25 files changed, 637 insertions(+), 174 deletions(-)
 create mode 100644 include/net/announce.h
 create mode 100644 net/announce.c
 create mode 100644 tests/test-announce-self.c
