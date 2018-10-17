Received: from eggs.gnu.org ([2001:4830:134:3::10]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNW-0002Km-5S
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNU-00054h-6C
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:34 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:25821)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNQ-0004r8-Fw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:30 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 17 Oct 2018 17:44:03 +0800
Message-Id: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 0/3] Modern shell scripting (use $() instead of
 ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, philmd@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, sw@weilnetz.de, kwolf@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, famz@redhat.com

Various shell files contain a mix between obsolete `` and
modern $(); It would be nice to convert to using $()
everywhere.

On https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02920.html
I just replaced `` in scripts dir,  so this series is a 
thorough cleanup of all obsolete `` in the source tree. 

Cc: philmd@redhat.com
Cc: peter.maydell@linaro.org
Cc: thuth@redhat.com
Cc: sw@weilnetz.de
Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: alex.bennee@linaro.org
Cc: famz@redhat.com

Mao Zhongyi (3):
  qemu-iotests: Modern shellscripting (use $() instead of ``)
  debian-bootstrap.pre: Modern shell scripting (use $() instead of ``)
  po/Makefile: Modern shell scripting (use $() instead of ``)

 po/Makefile                                   |  2 +-
 tests/docker/dockerfiles/debian-bootstrap.pre |  4 +-
 tests/qemu-iotests/001                        |  4 +-
 tests/qemu-iotests/002                        |  4 +-
 tests/qemu-iotests/003                        |  4 +-
 tests/qemu-iotests/004                        |  4 +-
 tests/qemu-iotests/005                        |  4 +-
 tests/qemu-iotests/007                        |  6 +-
 tests/qemu-iotests/008                        |  4 +-
 tests/qemu-iotests/009                        |  4 +-
 tests/qemu-iotests/010                        |  4 +-
 tests/qemu-iotests/011                        |  6 +-
 tests/qemu-iotests/012                        |  4 +-
 tests/qemu-iotests/013                        |  4 +-
 tests/qemu-iotests/014                        |  6 +-
 tests/qemu-iotests/015                        |  4 +-
 tests/qemu-iotests/017                        |  4 +-
 tests/qemu-iotests/018                        |  4 +-
 tests/qemu-iotests/019                        |  4 +-
 tests/qemu-iotests/020                        |  4 +-
 tests/qemu-iotests/021                        |  4 +-
 tests/qemu-iotests/022                        |  4 +-
 tests/qemu-iotests/023                        |  4 +-
 tests/qemu-iotests/024                        |  4 +-
 tests/qemu-iotests/025                        |  4 +-
 tests/qemu-iotests/026                        |  4 +-
 tests/qemu-iotests/027                        |  4 +-
 tests/qemu-iotests/028                        |  4 +-
 tests/qemu-iotests/029                        |  4 +-
 tests/qemu-iotests/031                        |  4 +-
 tests/qemu-iotests/032                        |  4 +-
 tests/qemu-iotests/033                        |  4 +-
 tests/qemu-iotests/034                        |  4 +-
 tests/qemu-iotests/035                        |  4 +-
 tests/qemu-iotests/036                        |  4 +-
 tests/qemu-iotests/037                        |  4 +-
 tests/qemu-iotests/038                        |  4 +-
 tests/qemu-iotests/039                        |  4 +-
 tests/qemu-iotests/042                        |  4 +-
 tests/qemu-iotests/043                        |  4 +-
 tests/qemu-iotests/046                        |  4 +-
 tests/qemu-iotests/047                        |  4 +-
 tests/qemu-iotests/048                        |  2 +-
 tests/qemu-iotests/049                        |  4 +-
 tests/qemu-iotests/050                        |  4 +-
 tests/qemu-iotests/051                        |  4 +-
 tests/qemu-iotests/052                        |  4 +-
 tests/qemu-iotests/053                        |  4 +-
 tests/qemu-iotests/054                        |  4 +-
 tests/qemu-iotests/058                        |  4 +-
 tests/qemu-iotests/059                        |  4 +-
 tests/qemu-iotests/061                        |  4 +-
 tests/qemu-iotests/062                        |  4 +-
 tests/qemu-iotests/063                        |  4 +-
 tests/qemu-iotests/064                        |  4 +-
 tests/qemu-iotests/067                        |  4 +-
 tests/qemu-iotests/070                        |  4 +-
 tests/qemu-iotests/073                        |  4 +-
 tests/qemu-iotests/074                        |  2 +-
 tests/qemu-iotests/075                        |  4 +-
 tests/qemu-iotests/076                        |  4 +-
 tests/qemu-iotests/077                        |  4 +-
 tests/qemu-iotests/078                        |  4 +-
 tests/qemu-iotests/079                        |  4 +-
 tests/qemu-iotests/080                        |  4 +-
 tests/qemu-iotests/081                        |  4 +-
 tests/qemu-iotests/082                        |  4 +-
 tests/qemu-iotests/083                        |  4 +-
 tests/qemu-iotests/084                        |  4 +-
 tests/qemu-iotests/085                        |  4 +-
 tests/qemu-iotests/086                        |  4 +-
 tests/qemu-iotests/087                        |  4 +-
 tests/qemu-iotests/088                        |  4 +-
 tests/qemu-iotests/091                        |  4 +-
 tests/qemu-iotests/092                        |  4 +-
 tests/qemu-iotests/095                        |  4 +-
 tests/qemu-iotests/101                        |  4 +-
 tests/qemu-iotests/104                        |  4 +-
 tests/qemu-iotests/105                        |  4 +-
 tests/qemu-iotests/116                        |  4 +-
 tests/qemu-iotests/128                        |  4 +-
 tests/qemu-iotests/131                        |  4 +-
 tests/qemu-iotests/133                        |  4 +-
 tests/qemu-iotests/134                        |  4 +-
 tests/qemu-iotests/135                        |  4 +-
 tests/qemu-iotests/142                        |  4 +-
 tests/qemu-iotests/144                        |  4 +-
 tests/qemu-iotests/145                        |  4 +-
 tests/qemu-iotests/146                        |  4 +-
 tests/qemu-iotests/154                        |  4 +-
 tests/qemu-iotests/158                        |  4 +-
 tests/qemu-iotests/171                        |  4 +-
 tests/qemu-iotests/172                        |  4 +-
 tests/qemu-iotests/173                        |  4 +-
 tests/qemu-iotests/174                        |  4 +-
 tests/qemu-iotests/175                        |  4 +-
 tests/qemu-iotests/177                        |  4 +-
 tests/qemu-iotests/178                        |  4 +-
 tests/qemu-iotests/181                        |  4 +-
 tests/qemu-iotests/183                        |  4 +-
 tests/qemu-iotests/184                        |  4 +-
 tests/qemu-iotests/185                        |  4 +-
 tests/qemu-iotests/186                        |  4 +-
 tests/qemu-iotests/187                        |  4 +-
 tests/qemu-iotests/188                        |  4 +-
 tests/qemu-iotests/189                        |  4 +-
 tests/qemu-iotests/190                        |  4 +-
 tests/qemu-iotests/191                        |  4 +-
 tests/qemu-iotests/192                        |  4 +-
 tests/qemu-iotests/195                        |  4 +-
 tests/qemu-iotests/198                        |  4 +-
 tests/qemu-iotests/200                        |  4 +-
 tests/qemu-iotests/201                        |  2 +-
 tests/qemu-iotests/204                        |  4 +-
 tests/qemu-iotests/226                        |  4 +-
 tests/qemu-iotests/231                        |  4 +-
 tests/qemu-iotests/check                      | 62 +++++++++----------
 tests/qemu-iotests/common.config              |  6 +-
 tests/qemu-iotests/common.pattern             |  4 +-
 tests/qemu-iotests/common.rc                  |  2 +-
 120 files changed, 268 insertions(+), 268 deletions(-)

-- 
2.17.1
