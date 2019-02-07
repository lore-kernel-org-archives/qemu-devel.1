Received: from eggs.gnu.org ([209.51.188.92]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpSz-0002Ja-T5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpSz-0007T2-Bl
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:09 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 14:36:01 -0500
Message-Id: <20190207193605.25676-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Trivial fixes for configure and Python
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

This is just a small collection of trivial fixes for configure
and some Python scripts (missing/unused import statements).

Cleber Rosa (4):
  configure: remove handling of "wav" audio driver
  configure: fix qemu-img name
  scripts/render_block_graph.py: add a missing import
  tests/migration/guestperf/engine.py: remove unused import

 configure                           | 6 +-----
 scripts/render_block_graph.py       | 1 +
 tests/migration/guestperf/engine.py | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

--=20
2.20.1
