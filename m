Received: from eggs.gnu.org ([2001:4830:134:3::10]:36625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScT-0001gq-Dx
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScQ-0005WZ-4f
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dzScP-0005W7-UC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  3 Oct 2017 15:12:22 -0400
Message-Id: <20171003191227.11845-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10=
ea:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-10-03 16:27:24 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to f708a5e71cba0d784e307334c07ade5f56f827ab:

  aio: fix assert when remove poll during destroy (2017-10-03 14:36:19 -0=
400)

----------------------------------------------------------------

----------------------------------------------------------------

Peter Xu (4):
  qom: provide root container for internal objs
  iothread: provide helpers for internal use
  iothread: export iothread_stop()
  iothread: delay the context release to finalize

Stefan Hajnoczi (1):
  aio: fix assert when remove poll during destroy

 include/qom/object.h      | 11 +++++++++++
 include/sysemu/iothread.h |  9 +++++++++
 iothread.c                | 46 ++++++++++++++++++++++++++++++++++++-----=
-----
 qom/object.c              | 11 +++++++++++
 util/aio-posix.c          |  9 ++++++++-
 5 files changed, 75 insertions(+), 11 deletions(-)

--=20
2.13.6
