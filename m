Received: from eggs.gnu.org ([209.51.188.92]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCHH-0000QR-6t
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCF6-0007g2-CT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gxCF6-0006Dn-0H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:00 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Feb 2019 22:55:07 +0800
Message-Id: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Netpatches
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

The following changes since commit 7817ea16c1bb91ba3849e704d5f3e3c5775087=
bf:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190221' into =
staging (2019-02-22 13:04:42 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to eb4702b3ffcf11ec62f0c401f77f49219594e95c:

  net: netmap: improve netmap_receive_iov() (2019-02-22 22:39:24 +0800)

----------------------------------------------------------------

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

 hmp-commands.hx                |  14 +++++
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
 tests/test-announce-self.c     |  83 ++++++++++++++++++++++++
 tests/test-hmp.c               |   1 +
 25 files changed, 636 insertions(+), 174 deletions(-)
 create mode 100644 include/net/announce.h
 create mode 100644 net/announce.c
 create mode 100644 tests/test-announce-self.c
