Received: from eggs.gnu.org ([2001:4830:134:3::10]:51622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr5-0001cs-Mg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr2-0007Ma-Iv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5Qr2-0007MM-Cx
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Oct 2017 14:32:14 +0800
Message-Id: <20171020063219.2035-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Docker patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 063833a6ec2a6747e27c5f9866bb44c7e8de12=
65:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-10-19 18:42:51 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to 6a2e11974fa6c4eaee6b2b156b1b4e03ca983bab:

  docker: Fix PATH for ccache (2017-10-20 14:28:50 +0800)

----------------------------------------------------------------

----------------------------------------------------------------

Fam Zheng (2):
  docker: Don't allocate tty unless DEBUG=3D1
  docker: Fix PATH for ccache

Greg Kurz (1):
  docker: fix out-of-tree 'make docker-test-build@debian-powerpc-cross'

Paolo Bonzini (1):
  docker: allow running from srcdir !=3D builddir build

Peter Xu (1):
  docker: cleanup temp directory after test

 tests/docker/Makefile.include | 12 +++++++-----
 tests/docker/run              |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

--=20
2.13.5
