Received: from eggs.gnu.org ([2001:4830:134:3::10]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOGA-0007kc-M8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOG9-0008OZ-Rs
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ciOG9-0008ON-MX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 27 Feb 2017 16:34:43 +0000
Message-Id: <20170227163447.20428-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Block patches
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

The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 1ab17f9f5c63c2798d707aeb22588e4fcc17b2cd:

  tests-aio-multithread: use atomic_read properly (2017-02-27 14:00:53 +0=
000)

----------------------------------------------------------------

----------------------------------------------------------------

Paolo Bonzini (4):
  curl: do not use aio_context_acquire/release
  nfs: do not use aio_context_acquire/release
  iscsi: do not use aio_context_acquire/release
  tests-aio-multithread: use atomic_read properly

 block/curl.c                 | 24 ++++++++-----
 block/iscsi.c                | 83 ++++++++++++++++++++++++++++++++++----=
------
 block/nfs.c                  | 23 +++++++++---
 tests/test-aio-multithread.c |  4 +--
 4 files changed, 100 insertions(+), 34 deletions(-)

--=20
2.9.3
