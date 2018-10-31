Received: from eggs.gnu.org ([2001:4830:134:3::10]:42978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQJ-00027o-N3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQG-0003nS-R4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:05 -0300
Message-Id: <20181031003120.26771-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Python queue, 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Sorry for submitting this at the last minute.

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to e301e65c97142c4d2a2adf35f5a4fa73d65d8a4f:

  scripts/qemu.py: use a more consistent docstring style (2018-10-30 21:1=
3:54 -0300)

----------------------------------------------------------------
Python queue, 2018-10-30

* Makefile rule for running acceptance tests
  (make check-acceptance) (Cleber Rosa)
* Make iotests compatible with Python 3
  (Max Reitz)
* device-crash-test whitelist update (Thomas Huth)
* Misc cleanups (Cleber Rosa)

----------------------------------------------------------------

Cleber Rosa (5):
  Bootstrap Python venv for tests
  Acceptance tests: add make rule for running them
  Travis support for the acceptance tests
  scripts/decodetree.py: fix reference to attributes
  scripts/qemu.py: use a more consistent docstring style

Max Reitz (9):
  iotests: Make nbd-fault-injector flush
  iotests: Flush in iotests.py's QemuIoInteractive
  iotests: Use Python byte strings where appropriate
  iotests: Use // for Python integer division
  iotests: Different iterator behavior in Python 3
  iotests: Explicitly bequeath FDs in Python
  iotests: 'new' module replacement in 169
  iotests: Modify imports for Python 3
  iotests: Unify log outputs between Python 2 and 3

Thomas Huth (1):
  scripts/device-crash-test: Remove devices that are not user_creatable
    anymore

 docs/devel/testing.rst                   |  43 +-
 tests/requirements.txt                   |   4 +
 scripts/decodetree.py                    |   2 +-
 scripts/qemu.py                          |  99 +++--
 scripts/qtest.py                         |   2 +-
 .travis.yml                              |   8 +
 scripts/device-crash-test                |  17 -
 tests/Makefile.include                   |  43 ++
 tests/qemu-iotests/030                   |   2 +-
 tests/qemu-iotests/040                   |   4 +-
 tests/qemu-iotests/041                   |   4 +-
 tests/qemu-iotests/044                   |  24 +-
 tests/qemu-iotests/045                   |   2 +-
 tests/qemu-iotests/056                   |   2 +-
 tests/qemu-iotests/065                   |   4 +-
 tests/qemu-iotests/083.out               |   9 +
 tests/qemu-iotests/093                   |  18 +-
 tests/qemu-iotests/124                   |   4 +-
 tests/qemu-iotests/136                   |   2 +-
 tests/qemu-iotests/139                   |   2 +-
 tests/qemu-iotests/147                   |   2 +-
 tests/qemu-iotests/149                   |  14 +-
 tests/qemu-iotests/151                   |  12 +-
 tests/qemu-iotests/163                   |  13 +-
 tests/qemu-iotests/169                   |   3 +-
 tests/qemu-iotests/194.out               |  22 +-
 tests/qemu-iotests/202.out               |  12 +-
 tests/qemu-iotests/203.out               |  14 +-
 tests/qemu-iotests/206.out               | 218 +++++-----
 tests/qemu-iotests/207                   |   6 +-
 tests/qemu-iotests/207.out               |  72 ++--
 tests/qemu-iotests/208.out               |   8 +-
 tests/qemu-iotests/210.out               |  94 ++--
 tests/qemu-iotests/211.out               | 102 ++---
 tests/qemu-iotests/212.out               | 174 ++++----
 tests/qemu-iotests/213.out               | 182 ++++----
 tests/qemu-iotests/216.out               |   4 +-
 tests/qemu-iotests/218.out               |  20 +-
 tests/qemu-iotests/219.out               | 526 +++++++++++------------
 tests/qemu-iotests/222.out               |  24 +-
 tests/qemu-iotests/iotests.py            |  37 +-
 tests/qemu-iotests/nbd-fault-injector.py |  12 +-
 tests/qemu-iotests/qcow2.py              |  10 +-
 tests/qemu-iotests/qed.py                |   6 +-
 44 files changed, 1014 insertions(+), 868 deletions(-)
 create mode 100644 tests/requirements.txt

--=20
2.18.0.rc1.1.g3f1ff2140
