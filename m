Received: from eggs.gnu.org ([2001:4830:134:3::10]:60529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQq9-0001iY-Ue
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQq6-0000C8-ET
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQq6-0000Bu-6W
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:30 -0300
Message-Id: <20180611174243.31070-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Python queue, 2018-06-11
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

The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed45=
82:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80608' into staging (2018-06-08 16:26:51 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to c7883412440905b41dde7e70f4af782932e80e90:

  python: Remove scripts/ordereddict.py (2018-06-08 16:40:54 -0300)

----------------------------------------------------------------
Python queue, 2018-06-11

* Make code compatible with Python 3 using 'futurize --stage1'
* Require Python >=3D 2.7 and remove Python 2.6 compatibility
  modules

----------------------------------------------------------------

Eduardo Habkost (13):
  python: futurize -f libfuturize.fixes.fix_print_with_import
  python: futurize -f libfuturize.fixes.fix_absolute_import
  python: futurize -f libfuturize.fixes.fix_next_call
  python: futurize -f lib2to3.fixes.fix_has_key
  python: futurize -f lib2to3.fixes.fix_standarderror
  python: futurize -f lib2to3.fixes.fix_reduce
  python: futurize -f lib2to3.fixes.fix_tuple_params
  python: futurize -f lib2to3.fixes.fix_renames
  python: futurize -f lib2to3.fixes.fix_except
  python: futurize -f lib2to3.fixes.fix_numliterals
  configure: Require Python 2.7 or newer
  python: Remove scripts/argparse.py
  python: Remove scripts/ordereddict.py

 configure                                |    4 +-
 Makefile                                 |    1 -
 scripts/analyse-9p-simpletrace.py        |   89 +-
 scripts/analyse-locks-simpletrace.py     |    3 +-
 scripts/analyze-migration.py             |   11 +-
 scripts/argparse.py                      | 2406 ----------------------
 scripts/dump-guest-memory.py             |    1 +
 scripts/ordereddict.py                   |  128 --
 scripts/qapi/common.py                   |    5 +-
 scripts/replay-dump.py                   |   21 +-
 scripts/signrom.py                       |    1 +
 scripts/simpletrace.py                   |    5 +-
 scripts/vmstate-static-checker.py        |   89 +-
 scripts/device-crash-test                |    3 +-
 scripts/kvm/kvm_flightrecorder           |   21 +-
 scripts/kvm/vmxcap                       |    1 +
 scripts/qmp/qemu-ga-client               |   10 +-
 scripts/qmp/qmp                          |   24 +-
 scripts/qmp/qmp-shell                    |   40 +-
 scripts/qmp/qom-fuse                     |   11 +-
 scripts/qmp/qom-get                      |   12 +-
 scripts/qmp/qom-list                     |   16 +-
 scripts/qmp/qom-set                      |   10 +-
 scripts/qmp/qom-tree                     |   16 +-
 tests/Makefile.include                   |    1 -
 tests/docker/docker.py                   |   17 +-
 tests/docker/travis.py                   |   15 +-
 tests/guest-debug/test-gdbstub.py        |    1 +
 tests/image-fuzzer/qcow2/__init__.py     |    3 +-
 tests/image-fuzzer/qcow2/fuzz.py         |    1 +
 tests/image-fuzzer/qcow2/layout.py       |    3 +-
 tests/image-fuzzer/runner.py             |   42 +-
 tests/migration/guestperf/engine.py      |   29 +-
 tests/migration/guestperf/plot.py        |   17 +-
 tests/migration/guestperf/shell.py       |   19 +-
 tests/qemu-iotests/093                   |    2 +-
 tests/qemu-iotests/096                   |    4 +-
 tests/qemu-iotests/118                   |   24 +-
 tests/qemu-iotests/136                   |    2 +-
 tests/qemu-iotests/149                   |    3 +-
 tests/qemu-iotests/165                   |    3 +-
 tests/qemu-iotests/iotests.py            |    5 +-
 tests/qemu-iotests/nbd-fault-injector.py |    7 +-
 tests/qemu-iotests/qcow2.py              |   39 +-
 tests/qemu-iotests/qed.py                |   17 +-
 tests/vm/basevm.py                       |    3 +-
 46 files changed, 341 insertions(+), 2844 deletions(-)
 delete mode 100644 scripts/argparse.py
 delete mode 100644 scripts/ordereddict.py

--=20
2.18.0.rc1.1.g3f1ff2140
