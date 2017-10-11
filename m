Received: from eggs.gnu.org ([2001:4830:134:3::10]:50016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M64-0006IS-LW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M61-0000ee-JO
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e2M61-0000dR-Dh
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 11 Oct 2017 15:50:58 -0300
Message-Id: <20171011185103.26259-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Python queue, 2017-10-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

The following changes since commit bac960832015bf4c4c1b873011612e2675e446=
4c:

  Merge remote-tracking branch 'remotes/elmarco/tags/vus-pull-request' in=
to staging (2017-10-11 13:10:36 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 1a6d3757107181dc0b9baf3dd8ff40fb2a242b66:

  scripts: Remove debug parameter from QEMUMachine (2017-10-11 15:15:17 -=
0300)

----------------------------------------------------------------
Python queue, 2017-10-11

----------------------------------------------------------------

Eduardo Habkost (5):
  iotests: Set up Python logging
  basevm: Call logging.basicConfig()
  guestperf: Configure logging on all shell frontends
  scripts: Remove debug parameter from QEMUMonitorProtocol
  scripts: Remove debug parameter from QEMUMachine

 scripts/qemu.py                     |  9 +++------
 scripts/qmp/qmp.py                  | 16 +++++++---------
 tests/migration/guestperf/engine.py |  6 ++----
 tests/migration/guestperf/shell.py  | 13 +++++++++++++
 tests/qemu-iotests/iotests.py       |  5 +++--
 tests/vm/basevm.py                  |  4 ++--
 6 files changed, 30 insertions(+), 23 deletions(-)

--=20
2.13.6
