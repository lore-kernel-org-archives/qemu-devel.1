Received: from eggs.gnu.org ([209.51.188.92]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQ4u-0005SB-Dq
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQ4s-0000Je-EZ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:36 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  6 Feb 2019 11:29:00 -0500
Message-Id: <20190206162901.19082-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] Introduce a Python module structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>

The amount of Python code that is being reused by a now large number
of different scripts and tests on QEMU urges for a better structure.

This addresses the feedback received on a previous RFC[1], but further
changes that will really benefit from this change were not attempted
here.  Once, the module structure is present, I myself have plans to
send some unittests to "QEMUMachine", to some parts of "qemu.qmp", and
others.

Documentation, lint and style checkers are other possible candidates.

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05478.html

---

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/python_module
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/python_module

Travis CI Info:
  - Job: https://travis-ci.org/clebergnu/qemu/builds/489616874

Cleber Rosa (1):
  Introduce a Python module structure

 configure                                  |  1 +
 scripts/qemu.py =3D> python/qemu/__init__.py | 11 ++++++-----
 {scripts/qmp =3D> python/qemu}/qmp.py        |  0
 {scripts =3D> python/qemu}/qtest.py          |  5 +++--
 scripts/device-crash-test                  |  2 ++
 scripts/qmp/__init__.py                    |  0
 scripts/qmp/qemu-ga-client                 |  5 ++++-
 scripts/qmp/qmp-shell                      |  4 +++-
 scripts/render_block_graph.py              |  2 ++
 tests/acceptance/avocado_qemu/__init__.py  |  5 ++---
 tests/acceptance/virtio_version.py         |  2 +-
 tests/migration/guestperf/engine.py        |  7 ++++---
 tests/qemu-iotests/235                     |  2 +-
 tests/qemu-iotests/238                     |  2 +-
 tests/qemu-iotests/iotests.py              |  4 ++--
 tests/vm/basevm.py                         |  2 +-
 16 files changed, 33 insertions(+), 21 deletions(-)
 rename scripts/qemu.py =3D> python/qemu/__init__.py (98%)
 rename {scripts/qmp =3D> python/qemu}/qmp.py (100%)
 rename {scripts =3D> python/qemu}/qtest.py (98%)
 delete mode 100644 scripts/qmp/__init__.py

--=20
2.20.1
