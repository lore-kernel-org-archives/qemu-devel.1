Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VG2-0005pZ-S7
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VFz-0002VS-1E
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1VFy-0002VH-RM
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:53:31 +0100
Message-Id: <20170421095334.26692-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/3] Tracing patches
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

The following changes since commit fa54abb8c298f892639ffc4bc2f61448ac3be4=
a1:

  Drop QEMU_GNUC_PREREQ() checks for gcc older than 4.1 (2017-04-20 18:33=
:33 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 659370f71f2c3d4105b04178abd751242e1c1b68:

  simpletrace: document Analyzer method signatures (2017-04-21 10:45:35 +=
0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (2):
  configure: eliminate Python dependency for --help
  simpletrace: document Analyzer method signatures

Xu, Anthony (1):
  trace: Put all trace.o into libqemuutil.a

 configure              | 35 +++++++++++++++++++----------------
 Makefile               |  6 +++---
 Makefile.target        |  5 ++---
 tests/Makefile.include |  2 +-
 scripts/simpletrace.py | 23 ++++++++++++++++++++++-
 5 files changed, 47 insertions(+), 24 deletions(-)

--=20
2.9.3
