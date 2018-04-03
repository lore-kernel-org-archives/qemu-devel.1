Received: from eggs.gnu.org ([2001:4830:134:3::10]:50248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3OZ5-00043k-Iu
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3OZ4-0005FU-Q6
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:13:43 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  3 Apr 2018 12:13:21 -0400
Message-Id: <20180403161324.24514-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Block patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit f184de7553272223d6af731d7d623a7cebf710=
b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critic=
al-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 9dae635afa98f83688806861cefe77ff1b4d76a8:

  gluster: Fix blockdev-add with server.N.type=3Dunix (2018-04-03 09:57:1=
4 -0400)

----------------------------------------------------------------
Blockjob and Gluster patches
----------------------------------------------------------------

Kevin Wolf (1):
  gluster: Fix blockdev-add with server.N.type=3Dunix

Marc-Andr=C3=A9 Lureau (2):
  blockjob: leak fix, remove from txn when failing early
  blockjob: use qapi enum helpers

 block/gluster.c | 21 +++++++++++++++++----
 blockjob.c      | 28 +++++++++++++++++-----------
 2 files changed, 34 insertions(+), 15 deletions(-)

--=20
2.13.6
