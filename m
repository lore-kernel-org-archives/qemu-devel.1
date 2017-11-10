Received: from eggs.gnu.org ([2001:4830:134:3::10]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eD9aK-00021S-D4
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eD9aE-00069j-Oj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eD9aE-000674-Ch
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:42:58 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 10 Nov 2017 21:42:52 +0800
Message-Id: <20171110134254.25031-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Docker patches
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

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-pull-request

for you to fetch changes up to 6423795efc5b665c595d9a0bf93cfbbca00362e9:

  docker: correctly escape $BACKEND in the help output (2017-11-08 10:59:=
42 +0800)

----------------------------------------------------------------

Hi Peter,

Here are two fixes on docker testing (the one saying "improved" is to
make it actually "correct"). Thanks.

Fam

----------------------------------------------------------------

Fam Zheng (1):
  docker: Improved image checksum

Philippe Mathieu-Daud=C3=A9 (1):
  docker: correctly escape $BACKEND in the help output

 tests/docker/Makefile.include |  2 +-
 tests/docker/docker.py        | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

--=20
2.13.6
