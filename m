Received: from eggs.gnu.org ([2001:4830:134:3::10]:59705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7R-0007RK-MJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7Q-0002u3-5w
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:29 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:00 -0500
Message-Id: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 00/10] I/O tests cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Hi all,

This is a collection of cleanups, simplifications, and hopefully
improvements to the I/O tests.

Please don't mind the "change noise": this almost qualifies as a
collection of trivial patches.  It skips that category (of trivial
patches) because it proposes a few conceptual changes to how tests are
executed and verified.

Thanks!

---

Cleber Rosa (10):
  qemu-iotests: add section on how to write a new I/O test
  qemu-iotests: remove unused "here" variable
  qemu-iotests: clean up double comment characters
  qemu-iotests: remove the concept of $seq.full (and boiler plate code)
  qemu-iotests: turn owner variable into a comment
  qemu-iotests: define functions used in _cleanup() before its use
  qemu-iotests: include (source) filters from common.rc
  qemu-iotests: be strict with expected output
  qemu-iotests: fix filename containing checks
  qemu-iotests: make execution of tests agnostic to test type

 tests/qemu-iotests/001                            | 14 ++--
 tests/qemu-iotests/002                            | 14 ++--
 tests/qemu-iotests/003                            | 14 ++--
 tests/qemu-iotests/004                            | 14 ++--
 tests/qemu-iotests/005                            | 14 ++--
 tests/qemu-iotests/007                            | 14 ++--
 tests/qemu-iotests/008                            | 14 ++--
 tests/qemu-iotests/009                            | 14 ++--
 tests/qemu-iotests/010                            | 14 ++--
 tests/qemu-iotests/011                            | 14 ++--
 tests/qemu-iotests/012                            | 14 ++--
 tests/qemu-iotests/013                            | 16 ++--
 tests/qemu-iotests/014                            | 16 ++--
 tests/qemu-iotests/015                            | 14 ++--
 tests/qemu-iotests/017                            | 16 ++--
 tests/qemu-iotests/018                            | 16 ++--
 tests/qemu-iotests/019                            | 16 ++--
 tests/qemu-iotests/020                            | 16 ++--
 tests/qemu-iotests/021                            | 14 ++--
 tests/qemu-iotests/022                            | 16 ++--
 tests/qemu-iotests/023                            | 16 ++--
 tests/qemu-iotests/024                            | 16 ++--
 tests/qemu-iotests/025                            | 16 ++--
 tests/qemu-iotests/026                            | 16 ++--
 tests/qemu-iotests/026.out                        | 92 ++++++++++-----------
 tests/qemu-iotests/027                            | 14 ++--
 tests/qemu-iotests/028                            | 18 ++--
 tests/qemu-iotests/029                            | 16 ++--
 tests/qemu-iotests/031                            | 16 ++--
 tests/qemu-iotests/032                            | 16 ++--
 tests/qemu-iotests/033                            | 14 ++--
 tests/qemu-iotests/034                            | 14 ++--
 tests/qemu-iotests/035                            | 14 ++--
 tests/qemu-iotests/036                            | 16 ++--
 tests/qemu-iotests/037                            | 14 ++--
 tests/qemu-iotests/038                            | 14 ++--
 tests/qemu-iotests/039                            | 14 ++--
 tests/qemu-iotests/040                            |  1 +
 tests/qemu-iotests/042                            | 14 ++--
 tests/qemu-iotests/043                            | 14 ++--
 tests/qemu-iotests/046                            | 14 ++--
 tests/qemu-iotests/047                            | 14 ++--
 tests/qemu-iotests/048                            | 52 ++++++------
 tests/qemu-iotests/049                            | 14 ++--
 tests/qemu-iotests/049.out                        |  4 +-
 tests/qemu-iotests/050                            | 14 ++--
 tests/qemu-iotests/051                            | 14 ++--
 tests/qemu-iotests/052                            | 14 ++--
 tests/qemu-iotests/053                            | 14 ++--
 tests/qemu-iotests/054                            | 14 ++--
 tests/qemu-iotests/058                            | 16 ++--
 tests/qemu-iotests/059                            | 14 ++--
 tests/qemu-iotests/060                            | 14 ++--
 tests/qemu-iotests/061                            | 14 ++--
 tests/qemu-iotests/061.out                        |  4 +-
 tests/qemu-iotests/062                            | 14 ++--
 tests/qemu-iotests/063                            | 16 ++--
 tests/qemu-iotests/064                            | 14 ++--
 tests/qemu-iotests/066                            | 14 ++--
 tests/qemu-iotests/067                            |  8 +-
 tests/qemu-iotests/068                            | 14 ++--
 tests/qemu-iotests/069                            | 14 ++--
 tests/qemu-iotests/070                            | 14 ++--
 tests/qemu-iotests/071                            | 14 ++--
 tests/qemu-iotests/072                            | 14 ++--
 tests/qemu-iotests/073                            | 14 ++--
 tests/qemu-iotests/074                            | 52 ++++++------
 tests/qemu-iotests/075                            | 14 ++--
 tests/qemu-iotests/076                            | 14 ++--
 tests/qemu-iotests/077                            | 14 ++--
 tests/qemu-iotests/078                            | 14 ++--
 tests/qemu-iotests/079                            | 14 ++--
 tests/qemu-iotests/080                            | 14 ++--
 tests/qemu-iotests/081                            |  8 +-
 tests/qemu-iotests/082                            | 14 ++--
 tests/qemu-iotests/083                            |  8 +-
 tests/qemu-iotests/084                            | 14 ++--
 tests/qemu-iotests/085                            | 16 ++--
 tests/qemu-iotests/086                            | 14 ++--
 tests/qemu-iotests/087                            |  8 +-
 tests/qemu-iotests/088                            | 14 ++--
 tests/qemu-iotests/089                            | 14 ++--
 tests/qemu-iotests/090                            | 14 ++--
 tests/qemu-iotests/091                            | 16 ++--
 tests/qemu-iotests/092                            | 14 ++--
 tests/qemu-iotests/094                            | 17 ++--
 tests/qemu-iotests/095                            | 15 ++--
 tests/qemu-iotests/096                            |  0
 tests/qemu-iotests/097                            | 16 ++--
 tests/qemu-iotests/098                            | 16 ++--
 tests/qemu-iotests/099                            | 14 ++--
 tests/qemu-iotests/101                            | 14 ++--
 tests/qemu-iotests/102                            | 16 ++--
 tests/qemu-iotests/103                            | 14 ++--
 tests/qemu-iotests/104                            |  8 +-
 tests/qemu-iotests/104.out                        |  2 +-
 tests/qemu-iotests/105                            | 14 ++--
 tests/qemu-iotests/106                            | 14 ++--
 tests/qemu-iotests/107                            | 14 ++--
 tests/qemu-iotests/108                            | 14 ++--
 tests/qemu-iotests/109                            | 16 ++--
 tests/qemu-iotests/109.out                        | 44 +++++-----
 tests/qemu-iotests/110                            | 14 ++--
 tests/qemu-iotests/111                            | 14 ++--
 tests/qemu-iotests/112                            | 14 ++--
 tests/qemu-iotests/113                            | 14 ++--
 tests/qemu-iotests/114                            | 14 ++--
 tests/qemu-iotests/115                            | 14 ++--
 tests/qemu-iotests/116                            | 14 ++--
 tests/qemu-iotests/117                            | 18 ++--
 tests/qemu-iotests/119                            | 14 ++--
 tests/qemu-iotests/120                            | 14 ++--
 tests/qemu-iotests/121                            | 14 ++--
 tests/qemu-iotests/122                            | 14 ++--
 tests/qemu-iotests/123                            | 14 ++--
 tests/qemu-iotests/124                            |  0
 tests/qemu-iotests/125                            | 14 ++--
 tests/qemu-iotests/126                            |  8 +-
 tests/qemu-iotests/127                            | 16 ++--
 tests/qemu-iotests/128                            |  8 +-
 tests/qemu-iotests/129                            |  0
 tests/qemu-iotests/130                            | 16 ++--
 tests/qemu-iotests/131                            | 14 ++--
 tests/qemu-iotests/132                            |  0
 tests/qemu-iotests/133                            | 14 ++--
 tests/qemu-iotests/134                            | 15 ++--
 tests/qemu-iotests/135                            | 14 ++--
 tests/qemu-iotests/136                            |  0
 tests/qemu-iotests/137                            | 16 ++--
 tests/qemu-iotests/138                            | 14 ++--
 tests/qemu-iotests/139                            |  0
 tests/qemu-iotests/140                            | 16 ++--
 tests/qemu-iotests/141                            | 16 ++--
 tests/qemu-iotests/142                            | 14 ++--
 tests/qemu-iotests/143                            | 16 ++--
 tests/qemu-iotests/144                            | 16 ++--
 tests/qemu-iotests/145                            | 14 ++--
 tests/qemu-iotests/146                            | 16 ++--
 tests/qemu-iotests/148                            |  0
 tests/qemu-iotests/150                            | 14 ++--
 tests/qemu-iotests/152                            |  0
 tests/qemu-iotests/153                            | 16 ++--
 tests/qemu-iotests/154                            | 14 ++--
 tests/qemu-iotests/156                            | 16 ++--
 tests/qemu-iotests/157                            | 14 ++--
 tests/qemu-iotests/158                            | 14 ++--
 tests/qemu-iotests/159                            | 12 ++-
 tests/qemu-iotests/160                            | 12 ++-
 tests/qemu-iotests/162                            |  8 +-
 tests/qemu-iotests/163                            |  0
 tests/qemu-iotests/170                            | 12 ++-
 tests/qemu-iotests/171                            | 14 ++--
 tests/qemu-iotests/172                            | 16 ++--
 tests/qemu-iotests/173                            | 15 ++--
 tests/qemu-iotests/174                            | 20 +++--
 tests/qemu-iotests/175                            | 14 ++--
 tests/qemu-iotests/175.out                        |  2 +-
 tests/qemu-iotests/176                            | 16 ++--
 tests/qemu-iotests/177                            | 13 ++-
 tests/qemu-iotests/178                            | 16 ++--
 tests/qemu-iotests/179                            | 15 ++--
 tests/qemu-iotests/181                            | 18 ++--
 tests/qemu-iotests/182                            | 16 ++--
 tests/qemu-iotests/183                            | 16 ++--
 tests/qemu-iotests/184                            | 14 ++--
 tests/qemu-iotests/185                            | 16 ++--
 tests/qemu-iotests/186                            | 14 ++--
 tests/qemu-iotests/187                            | 16 ++--
 tests/qemu-iotests/188                            | 14 ++--
 tests/qemu-iotests/189                            | 14 ++--
 tests/qemu-iotests/190                            | 16 ++--
 tests/qemu-iotests/191                            | 16 ++--
 tests/qemu-iotests/192                            | 16 ++--
 tests/qemu-iotests/195                            | 14 ++--
 tests/qemu-iotests/197                            |  7 +-
 tests/qemu-iotests/README                         | 44 ++++++++--
 tests/qemu-iotests/check                          | 13 +--
 tests/qemu-iotests/common.rc                      | 11 ++-
 .../qemu-iotests/sample_test_templates/sample.py  | 59 +++++++++++++
 .../{135 => sample_test_templates/sample.sh}      | 31 ++-----
 180 files changed, 1063 insertions(+), 1595 deletions(-)
