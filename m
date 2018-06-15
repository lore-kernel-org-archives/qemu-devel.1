Received: from eggs.gnu.org ([2001:4830:134:3::10]:46885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuA9-0007xC-Si
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuA5-0007EG-T9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuA5-0007Dg-N0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:20 -0300
Message-Id: <20180615191327.11480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Python queue, 2018-06-15
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

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 1b145d59b74a5880d82954ee940a219e73851f9e:

  configure: Enable out-of-tree acceptance tests (2018-06-15 16:10:11 -03=
00)

----------------------------------------------------------------
Python queue, 2018-06-15

* Add avocado_qemu: functional/acceptance test infrastructure

----------------------------------------------------------------

Cleber Rosa (5):
  Add functional/acceptance tests infrastructure
  scripts/qemu.py: allow adding to the list of extra arguments
  Acceptance tests: add quick VNC tests
  scripts/qemu.py: introduce set_console() method
  Acceptance tests: add Linux kernel boot and console checking test

Eduardo Habkost (1):
  Remove COPYING.PYTHON

Philippe Mathieu-Daud=C3=A9 (1):
  configure: Enable out-of-tree acceptance tests

 docs/devel/testing.rst                    | 192 +++++++++++++++
 configure                                 |   8 +-
 scripts/qemu.py                           | 103 ++++++++-
 COPYING.PYTHON                            | 270 ----------------------
 tests/acceptance/README.rst               |  10 +
 tests/acceptance/avocado_qemu/__init__.py |  54 +++++
 tests/acceptance/boot_linux_console.py    |  47 ++++
 tests/acceptance/version.py               |  24 ++
 tests/acceptance/vnc.py                   |  60 +++++
 9 files changed, 494 insertions(+), 274 deletions(-)
 delete mode 100644 COPYING.PYTHON
 create mode 100644 tests/acceptance/README.rst
 create mode 100644 tests/acceptance/avocado_qemu/__init__.py
 create mode 100644 tests/acceptance/boot_linux_console.py
 create mode 100644 tests/acceptance/version.py
 create mode 100644 tests/acceptance/vnc.py

--=20
2.18.0.rc1.1.g3f1ff2140
