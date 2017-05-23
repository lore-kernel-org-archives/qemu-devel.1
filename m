Received: from eggs.gnu.org ([2001:4830:134:3::10]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCznu-0004jY-DH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCznr-0005D4-3Q
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCznq-0005Cq-Tf
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:07 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:50 +0800
Message-Id: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Net patches
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

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 82342e91b60a4a078811df4e1a545e57abffa11d:

  e1000e: Fix ICR "Other" causes clear logic (2017-05-23 10:10:38 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Sameeh Jubran (1):
      e1000e: Fix ICR "Other" causes clear logic

Thomas Huth (3):
      net/tap: Replace tap-haiku.c and tap-aix.c by a generic tap-stub.c
      net/dump: Issue a warning for the deprecated "-net dump"
      hmp / net: Mark host_net_add/remove as deprecated

Yunjian Wang (1):
      virtio-net: fix wild pointer when remove virtio-net queues

Zhang Chen (4):
      COLO-compare: Improve tcp compare trace event readability
      net/filter-mirror.c: Remove duplicate check code.
      net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
      net/filter-rewriter: Remove unused option in filter-rewriter

 hmp-commands.hx               |  8 ++--
 hw/net/e1000e_core.c          | 10 ++++-
 hw/net/virtio-net.c           |  3 ++
 net/Makefile.objs             | 15 ++++----
 net/colo-compare.c            | 33 ++++++++++------
 net/dump.c                    |  3 ++
 net/filter-mirror.c           | 35 ++++++++---------
 net/net.c                     | 13 +++++++
 net/tap-haiku.c               | 87 -------------------------------------=
------
 net/{tap-aix.c =3D> tap-stub.c} |  3 +-
 net/trace-events              |  3 +-
 qemu-options.hx               |  2 +-
 12 files changed, 80 insertions(+), 135 deletions(-)
 delete mode 100644 net/tap-haiku.c
 rename net/{tap-aix.c =3D> tap-stub.c} (97%)
