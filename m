Received: from eggs.gnu.org ([2001:4830:134:3::10]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFmYD-0003VT-9q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFmY8-0005iN-Sy
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFmY8-0005i3-Mv
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 May 2017 16:11:19 -0300
Message-Id: <20170530191121.1920-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] NUMA fixes, 2017-05-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b=
04:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-30 14:15:15 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/numa-pull-request

for you to fetch changes up to f892291eee376505cfec8b6cade7ccf952a6d3e0:

  numa: Fix format string for "Invalid node" message (2017-05-30 16:09:58=
 -0300)

----------------------------------------------------------------
NUMA fixes, 2017-05-30

----------------------------------------------------------------

Eduardo Habkost (1):
  numa: Fix format string for "Invalid node" message

Marc-Andr=C3=A9 Lureau (1):
  numa-test: fix query-cpus leaks

 numa.c            |  3 +--
 tests/numa-test.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

--=20
2.11.0.259.g40922b1
