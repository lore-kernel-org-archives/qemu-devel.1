Received: from eggs.gnu.org ([2001:4830:134:3::10]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKO-0002yD-80
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKL-0004e8-22
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKK-0004dg-Tv
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:14 +0800
Message-Id: <20180910035719.18056-1-famz@redhat.com>
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

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to b28ef6b9eb2401b9500c59cb32ff5fe43400f0be:

  docker: Clean dangling tarball files (2018-09-10 11:50:06 +0800)

----------------------------------------------------------------
docker testing improvements by Phil.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (5):
  docker: Sort Fedora packages
  docker: Sort Fedora packages (i386-cross)
  docker: Sort Ubuntu packages
  docker: Sort CentOS packages
  docker: Clean dangling tarball files

 tests/docker/Makefile.include                 |   1 +
 tests/docker/dockerfiles/centos7.docker       |   2 +-
 .../dockerfiles/fedora-i386-cross.docker      |   9 +-
 tests/docker/dockerfiles/fedora.docker        | 102 ++++++++++++++----
 tests/docker/dockerfiles/ubuntu.docker        |  61 +++++++++--
 5 files changed, 142 insertions(+), 33 deletions(-)

--=20
2.17.1
