Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5j-0007g8-9c
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5g-0002bA-3g
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f5R5f-0002az-Ue
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  9 Apr 2018 15:19:30 +0800
Message-Id: <20180409071934.20845-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>

The following changes since commit 08e173f29461396575c85510eb41474b993cb1=
fb:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-r=
equest' into staging (2018-04-06 17:51:21 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/testing-pull-request

for you to fetch changes up to 07fed474177a4566052ea81b1563d53a37083e84:

  docker: fedora: test more components (2018-04-09 15:13:02 +0800)

----------------------------------------------------------------
Testing patches

----------------------------------------------------------------

Fam Zheng (2):
  tests: Fix ubuntu.i386 image initialization
  docker: Inline "prep_fail" in run script

Paolo Bonzini (1):
  docker: fedora: test more components

Philippe Mathieu-Daud=C3=A9 (1):
  docker: dump 'config.log' if ./configure fails

 tests/docker/common.rc                 |  4 +++-
 tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
 tests/docker/run                       |  2 +-
 tests/vm/basevm.py                     |  5 +----
 4 files changed, 15 insertions(+), 9 deletions(-)

--=20
2.14.3
