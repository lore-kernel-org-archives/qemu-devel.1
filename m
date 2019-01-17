Received: from eggs.gnu.org ([209.51.188.92]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6o-0004kq-0m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6n-0003XQ-7p
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6m-0003RK-6n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:48 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:34 -0200
Message-Id: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Python queue, 2019-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

The following changes since commit 681d61362d3f766a00806b89d6581869041f73=
cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-01-17 12:48:42 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 49ebe9b15876f3ce9a5f45cb53a16b6a788d65fd:

  scripts/replay-dump.py: fix utf-8 mangling (2019-01-17 17:52:40 -0200)

----------------------------------------------------------------
Python queue, 2019-01-17

Fixes:
* Actually test different Python versions on Travis CI
* Fix qemu.py error message when qemu dies from signal

Cleanups:
* Track Python version on config-host.mak
* Remove fixed crashes from scripts/device-crash-test
* Acceptance tests: Linux initrd checking test
* Fix utf-8 mangling at scripts/replay-dump.py
* Remove unused python imports from multiple scripts

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  scripts/replay-dump.py: fix utf-8 mangling

Cleber Rosa (4):
  configure: keep track of Python version
  check-venv: use recorded Python version
  Travis CI: make specified Python versions usable on jobs
  check-help: visual and content improvements

Eric Blake (1):
  qemu.py: Fix error message when qemu dies from signal

Philippe Mathieu-Daud=C3=A9 (1):
  scripts: Remove unused python imports

Thomas Huth (1):
  scripts/device-crash-test: Remove known crashes

Wainer dos Santos Moschetta (1):
  Acceptance tests: add Linux initrd checking test

 configure                                    |  6 ++-
 scripts/analyse-locks-simpletrace.py         |  1 -
 scripts/analyze-migration.py                 |  1 -
 scripts/qemu.py                              |  2 +-
 scripts/replay-dump.py                       |  2 +-
 scripts/simpletrace.py                       |  1 -
 scripts/tracetool.py                         |  2 -
 scripts/tracetool/format/simpletrace_stap.py |  2 +-
 .travis.yml                                  |  4 +-
 scripts/device-crash-test                    | 16 -------
 tests/Makefile.include                       | 11 +++--
 tests/acceptance/linux_initrd.py             | 48 ++++++++++++++++++++
 12 files changed, 65 insertions(+), 31 deletions(-)
 create mode 100644 tests/acceptance/linux_initrd.py

--=20
2.18.0.rc1.1.g3f1ff2140
