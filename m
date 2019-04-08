Received: from eggs.gnu.org ([209.51.188.92]:32920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEs-00057C-VZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEq-0005yJ-Vg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 18:34:37 +0200
Message-Id: <20190408163439.18818-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit f55a585d1037e5de6088f25e75443c2776786e=
29:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-04-07 14:54:55 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to ab63817119b03b95f7dce6fae036e6d063ad63fb:

  hmp: Fix drive_add ... format=3Dhelp crash (2019-04-08 17:42:06 +0200)

----------------------------------------------------------------
Block layer patches:

- hmp: Fix drive_add ... format=3Dhelp crash
- block: Forward 'discard' to temporary overlay

----------------------------------------------------------------
Kevin Wolf (1):
      block: Forward 'discard' to temporary overlay

Markus Armbruster (1):
      hmp: Fix drive_add ... format=3Dhelp crash

 block.c          | 3 ++-
 device-hotplug.c | 2 +-
 tests/test-hmp.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)
