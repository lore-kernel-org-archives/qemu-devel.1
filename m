Received: from eggs.gnu.org ([2001:4830:134:3::10]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eK-0008M4-Hj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eF-0007Mx-Nz
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 16:14:44 +0200
Message-Id: <20181015141453.32632-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] iotests: Make them work for both Python 2
 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This series prepares the iotests to work with both Python 2 and 3.  In
some places, it adds version-specific code and decides what to do based
on the version (for instance, whether to import the StringIO class from
the 'io' or the 'StringIO' module), but most of the time, it just makes
code work for both versions in general.

And when we make the switch to make Python 3 mandatory, we can simply
drop the Python 2 branches.


Max Reitz (9):
  iotests: Make nbd-fault-injector flush
  iotests: Flush in iotests.py's QemuIoInteractive
  iotests: Use Python byte strings where appropriate
  iotests: Use // for Python integer division
  iotests: Different iterator behavior in Python 3
  iotests: Explicitly inherit FDs in Python
  iotests: 'new' module replacement in 169
  iotests: Modify imports for Python 3
  iotests: Unify log outputs between Python 2 and 3

 scripts/qemu.py                          |  13 +-
 scripts/qmp/qmp.py                       |   7 +
 scripts/qtest.py                         |   2 +-
 tests/qemu-iotests/040                   |   4 +-
 tests/qemu-iotests/044                   |  20 +-
 tests/qemu-iotests/056                   |   2 +-
 tests/qemu-iotests/065                   |   4 +-
 tests/qemu-iotests/083.out               |   9 +
 tests/qemu-iotests/093                   |  18 +-
 tests/qemu-iotests/124                   |   4 +-
 tests/qemu-iotests/139                   |   2 +-
 tests/qemu-iotests/147                   |   7 +
 tests/qemu-iotests/149                   |  14 +-
 tests/qemu-iotests/151                   |  12 +-
 tests/qemu-iotests/163                   |   8 +-
 tests/qemu-iotests/169                   |   3 +-
 tests/qemu-iotests/194.out               |  22 +-
 tests/qemu-iotests/202.out               |  12 +-
 tests/qemu-iotests/203.out               |  14 +-
 tests/qemu-iotests/206.out               | 144 +++----
 tests/qemu-iotests/207                   |   4 +-
 tests/qemu-iotests/207.out               |  52 +--
 tests/qemu-iotests/208.out               |   8 +-
 tests/qemu-iotests/210.out               |  72 ++--
 tests/qemu-iotests/211.out               |  66 +--
 tests/qemu-iotests/212.out               | 102 ++---
 tests/qemu-iotests/213.out               | 124 +++---
 tests/qemu-iotests/216.out               |   4 +-
 tests/qemu-iotests/218.out               |  20 +-
 tests/qemu-iotests/219.out               | 526 +++++++++++------------
 tests/qemu-iotests/222.out               |  24 +-
 tests/qemu-iotests/iotests.py            |  64 ++-
 tests/qemu-iotests/nbd-fault-injector.py |  12 +-
 tests/qemu-iotests/qcow2.py              |  10 +-
 34 files changed, 745 insertions(+), 664 deletions(-)

-- 
2.17.1
