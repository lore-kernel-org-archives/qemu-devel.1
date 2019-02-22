Received: from eggs.gnu.org ([209.51.188.92]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGhz-0003qr-0W
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGhx-00088R-Sn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:06 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:39 -0500
Message-Id: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Python queue, 2019-02-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be1=
16:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201902=
21.0' into staging (2019-02-22 15:48:04 +0000)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to 8f1c89ec7443e4fa2cf106d8fa1c1c97b6ddeffb:

  Acceptance tests: expect boot to extract 2GiB+ initrd with linux-v4.16 =
(2019-02-22 14:07:01 -0500)

----------------------------------------------------------------
Python queue, 2019-02-22

Python:
* introduce "python" directory with module namespace
* log QEMU launch command line on qemu.QEMUMachine

Acceptance Tests:
* initrd 4GiB+ test
* migration test
* multi vm support in test class
* bump Avocado version and drop ":avocado: enable"

----------------------------------------------------------------

Caio Carrara (2):
  tests.acceptance: adds multi vm capability for acceptance tests
  tests.acceptance: adds simple migration test

Cleber Rosa (3):
  Acceptance tests: drop usage of ":avocado: enable"
  Introduce a Python module structure
  scripts/qemu.py: log QEMU launch command line

Li Zhijian (2):
  Acceptance tests: use linux-3.6 and set vm memory to 4GiB
  Acceptance tests: expect boot to extract 2GiB+ initrd with linux-v4.16

 configure                                  |  1 +
 docs/devel/testing.rst                     | 42 ++++++++++++++++-
 scripts/qemu.py =3D> python/qemu/__init__.py | 12 +++--
 {scripts/qmp =3D> python/qemu}/qmp.py        |  0
 {scripts =3D> python/qemu}/qtest.py          |  5 +-
 scripts/device-crash-test                  |  2 +
 scripts/qmp/__init__.py                    |  0
 scripts/qmp/qemu-ga-client                 |  5 +-
 scripts/qmp/qmp-shell                      |  4 +-
 scripts/render_block_graph.py              |  2 +
 tests/acceptance/avocado_qemu/__init__.py  | 30 +++++++++---
 tests/acceptance/boot_linux_console.py     |  1 -
 tests/acceptance/linux_initrd.py           | 52 +++++++++++++++++----
 tests/acceptance/migration.py              | 53 ++++++++++++++++++++++
 tests/acceptance/version.py                |  1 -
 tests/acceptance/virtio_version.py         |  3 +-
 tests/acceptance/vnc.py                    |  1 -
 tests/migration/guestperf/engine.py        |  7 +--
 tests/qemu-iotests/235                     |  2 +-
 tests/qemu-iotests/238                     |  2 +-
 tests/qemu-iotests/iotests.py              |  4 +-
 tests/requirements.txt                     |  2 +-
 tests/vm/basevm.py                         |  2 +-
 23 files changed, 193 insertions(+), 40 deletions(-)
 rename scripts/qemu.py =3D> python/qemu/__init__.py (98%)
 rename {scripts/qmp =3D> python/qemu}/qmp.py (100%)
 rename {scripts =3D> python/qemu}/qtest.py (98%)
 delete mode 100644 scripts/qmp/__init__.py
 create mode 100644 tests/acceptance/migration.py

--=20
2.20.1
