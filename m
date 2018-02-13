Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTf-0002Ft-IJ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTe-0003E9-Q1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eleTe-0003DY-Mm
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Feb 2018 17:34:24 +0000
Message-Id: <20180213173429.19501-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58e9=
2a:

  Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +0000=
)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 64b01feca991e5b19a5d750ef77cdca92b68bdbb:

  misc: fix spelling (2018-02-13 15:38:17 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Fam Zheng (2):
  Add a git-publish configuration file
  README: Document 'git-publish' workflow

Marc-Andr=C3=A9 Lureau (1):
  misc: fix spelling

Stefan Hajnoczi (1):
  vl: pause vcpus before stopping iothreads

Wolfgang Bumiller (1):
  ratelimit: don't align wait time with slices

 include/qemu/ratelimit.h   | 11 ++++-----
 util/qemu-coroutine-lock.c |  2 +-
 vl.c                       | 12 ++++++++--
 .gitpublish                | 58 ++++++++++++++++++++++++++++++++++++++++=
++++++
 README                     | 31 ++++++++++++++++++++++++-
 5 files changed, 104 insertions(+), 10 deletions(-)
 create mode 100644 .gitpublish

--=20
2.14.3
