Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFe-00044o-Dk
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFS-0004oq-Nt
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g7tFI-00048f-CX
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 Oct 2018 23:19:39 -0300
Message-Id: <20181004021943.22724-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Python queue, 2018-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The following changes since commit dafd95053611aa14dda40266857608d12ddce6=
58:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-02 18:27:18 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to cd0c3da730bc8369f0b6c1c6bf81babd9851060d:

  scripts/device-crash-test: Remove entries for serial devices (2018-10-0=
3 23:08:51 -0300)

----------------------------------------------------------------
Python queue, 2018-10-03

* Remove fixed serial device errors from device-crash-test
* Remove unnecessary Python 2.6 compatibility code

----------------------------------------------------------------

Eduardo Habkost (3):
  device-crash-test: No need for sys.path hack
  Revert "docker.py: Python 2.6 argparse compatibility"
  Revert "tests: migration/guestperf Python 2.6 argparse compatibility"

Thomas Huth (1):
  scripts/device-crash-test: Remove entries for serial devices

 scripts/device-crash-test          | 6 ------
 tests/docker/docker.py             | 4 +---
 tests/migration/guestperf/shell.py | 8 +++-----
 3 files changed, 4 insertions(+), 14 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
