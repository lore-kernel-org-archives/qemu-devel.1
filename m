Received: from eggs.gnu.org ([2001:4830:134:3::10]:35298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG3Z-000209-Ku
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG3Y-00007W-SU
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Feb 2018 09:42:07 +0000
Message-Id: <20180215094210.27770-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea2=
17:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-02-13 18:24:08 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to d2f668b74907cbd96d9df0774971768ed06de2f0:

  misc: fix spelling (2018-02-15 09:39:49 +0000)

----------------------------------------------------------------
Pull request

v2:
 * Dropped Fam's git-publish series because there is still ongoing discus=
sion

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  misc: fix spelling

Stefan Hajnoczi (1):
  vl: pause vcpus before stopping iothreads

Wolfgang Bumiller (1):
  ratelimit: don't align wait time with slices

 include/qemu/ratelimit.h   | 11 +++++------
 util/qemu-coroutine-lock.c |  2 +-
 vl.c                       | 12 ++++++++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

--=20
2.14.3
