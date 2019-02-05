Received: from eggs.gnu.org ([209.51.188.92]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoRz-0006Ex-1I
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoRx-0007oX-Nc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:18:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 01:18:27 +0100
Message-Id: <20190205001835.25660-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] OpenBSD: Block layer fixes (was 'Enable
 qtesting')
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

Various fixes I encountered while trying to run QEMU test suite on OpenBS=
D.

This is the 'block' part of the v2.
Most non-RFC patches are reviewed and could be applied.

Since v2:
- Added R-b tags
- Addressed Eric's comments (in code and commit descriptions)

Since v1:
- various qemu-block fixes and notes.

Regards,

Phil.

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07513.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06676.html

Philippe Mathieu-Daud=C3=A9 (8):
  ahci-test: Add dependency to qemu-img tool
  qemu-iotests: Add dependency to qemu-nbd tool
  qemu-iotests: Improve portability by searching bash in the $PATH
  qemu-iotests: Ensure GNU sed is used
  iotests: Let verify_platform() check for unsupported platforms
  RFC iotests: Disable 208 on OpenBSD
  RFC iotests: Disable 209 on OpenBSD
  RFC iotests: Disable 236 and 238 on OpenBSD

 tests/Makefile.include            |  4 ++--
 tests/qemu-iotests/001            |  2 +-
 tests/qemu-iotests/002            |  2 +-
 tests/qemu-iotests/003            |  2 +-
 tests/qemu-iotests/004            |  2 +-
 tests/qemu-iotests/005            |  2 +-
 tests/qemu-iotests/007            |  2 +-
 tests/qemu-iotests/008            |  2 +-
 tests/qemu-iotests/009            |  2 +-
 tests/qemu-iotests/010            |  2 +-
 tests/qemu-iotests/011            |  2 +-
 tests/qemu-iotests/012            |  2 +-
 tests/qemu-iotests/013            |  2 +-
 tests/qemu-iotests/014            |  2 +-
 tests/qemu-iotests/015            |  2 +-
 tests/qemu-iotests/017            |  2 +-
 tests/qemu-iotests/018            |  2 +-
 tests/qemu-iotests/019            |  2 +-
 tests/qemu-iotests/020            |  2 +-
 tests/qemu-iotests/021            |  2 +-
 tests/qemu-iotests/022            |  2 +-
 tests/qemu-iotests/023            |  2 +-
 tests/qemu-iotests/024            |  2 +-
 tests/qemu-iotests/025            |  2 +-
 tests/qemu-iotests/026            |  2 +-
 tests/qemu-iotests/027            |  2 +-
 tests/qemu-iotests/028            |  2 +-
 tests/qemu-iotests/029            |  2 +-
 tests/qemu-iotests/031            |  2 +-
 tests/qemu-iotests/032            |  2 +-
 tests/qemu-iotests/033            |  2 +-
 tests/qemu-iotests/034            |  2 +-
 tests/qemu-iotests/035            |  2 +-
 tests/qemu-iotests/036            |  2 +-
 tests/qemu-iotests/037            |  2 +-
 tests/qemu-iotests/038            |  2 +-
 tests/qemu-iotests/039            |  2 +-
 tests/qemu-iotests/042            |  2 +-
 tests/qemu-iotests/043            |  2 +-
 tests/qemu-iotests/046            |  2 +-
 tests/qemu-iotests/047            |  2 +-
 tests/qemu-iotests/048            |  2 +-
 tests/qemu-iotests/049            |  2 +-
 tests/qemu-iotests/050            |  2 +-
 tests/qemu-iotests/051            |  2 +-
 tests/qemu-iotests/052            |  2 +-
 tests/qemu-iotests/053            |  2 +-
 tests/qemu-iotests/054            |  2 +-
 tests/qemu-iotests/058            |  2 +-
 tests/qemu-iotests/059            |  2 +-
 tests/qemu-iotests/060            |  2 +-
 tests/qemu-iotests/061            |  2 +-
 tests/qemu-iotests/062            |  2 +-
 tests/qemu-iotests/063            |  2 +-
 tests/qemu-iotests/064            |  2 +-
 tests/qemu-iotests/066            |  2 +-
 tests/qemu-iotests/067            |  2 +-
 tests/qemu-iotests/068            |  2 +-
 tests/qemu-iotests/069            |  2 +-
 tests/qemu-iotests/070            |  2 +-
 tests/qemu-iotests/071            |  2 +-
 tests/qemu-iotests/072            |  2 +-
 tests/qemu-iotests/073            |  2 +-
 tests/qemu-iotests/074            |  2 +-
 tests/qemu-iotests/075            |  2 +-
 tests/qemu-iotests/076            |  2 +-
 tests/qemu-iotests/077            |  2 +-
 tests/qemu-iotests/078            |  2 +-
 tests/qemu-iotests/079            |  2 +-
 tests/qemu-iotests/080            |  2 +-
 tests/qemu-iotests/081            |  2 +-
 tests/qemu-iotests/082            |  2 +-
 tests/qemu-iotests/083            |  2 +-
 tests/qemu-iotests/084            |  2 +-
 tests/qemu-iotests/085            |  2 +-
 tests/qemu-iotests/086            |  2 +-
 tests/qemu-iotests/087            |  2 +-
 tests/qemu-iotests/088            |  2 +-
 tests/qemu-iotests/089            |  2 +-
 tests/qemu-iotests/090            |  2 +-
 tests/qemu-iotests/091            |  2 +-
 tests/qemu-iotests/092            |  2 +-
 tests/qemu-iotests/094            |  2 +-
 tests/qemu-iotests/095            |  2 +-
 tests/qemu-iotests/097            |  2 +-
 tests/qemu-iotests/098            |  2 +-
 tests/qemu-iotests/099            |  2 +-
 tests/qemu-iotests/101            |  2 +-
 tests/qemu-iotests/102            |  2 +-
 tests/qemu-iotests/103            |  2 +-
 tests/qemu-iotests/104            |  2 +-
 tests/qemu-iotests/105            |  2 +-
 tests/qemu-iotests/106            |  2 +-
 tests/qemu-iotests/107            |  2 +-
 tests/qemu-iotests/108            |  2 +-
 tests/qemu-iotests/109            |  2 +-
 tests/qemu-iotests/110            |  2 +-
 tests/qemu-iotests/111            |  2 +-
 tests/qemu-iotests/112            |  2 +-
 tests/qemu-iotests/113            |  2 +-
 tests/qemu-iotests/114            |  2 +-
 tests/qemu-iotests/115            |  2 +-
 tests/qemu-iotests/116            |  2 +-
 tests/qemu-iotests/117            |  2 +-
 tests/qemu-iotests/119            |  2 +-
 tests/qemu-iotests/120            |  2 +-
 tests/qemu-iotests/121            |  2 +-
 tests/qemu-iotests/122            |  2 +-
 tests/qemu-iotests/123            |  2 +-
 tests/qemu-iotests/125            |  2 +-
 tests/qemu-iotests/126            |  2 +-
 tests/qemu-iotests/127            |  2 +-
 tests/qemu-iotests/128            |  2 +-
 tests/qemu-iotests/130            |  2 +-
 tests/qemu-iotests/131            |  2 +-
 tests/qemu-iotests/133            |  2 +-
 tests/qemu-iotests/134            |  2 +-
 tests/qemu-iotests/135            |  2 +-
 tests/qemu-iotests/137            |  2 +-
 tests/qemu-iotests/138            |  2 +-
 tests/qemu-iotests/140            |  2 +-
 tests/qemu-iotests/141            |  2 +-
 tests/qemu-iotests/142            |  2 +-
 tests/qemu-iotests/143            |  2 +-
 tests/qemu-iotests/144            |  2 +-
 tests/qemu-iotests/145            |  2 +-
 tests/qemu-iotests/146            |  2 +-
 tests/qemu-iotests/150            |  2 +-
 tests/qemu-iotests/153            |  2 +-
 tests/qemu-iotests/154            |  2 +-
 tests/qemu-iotests/156            |  2 +-
 tests/qemu-iotests/157            |  2 +-
 tests/qemu-iotests/158            |  2 +-
 tests/qemu-iotests/159            |  2 +-
 tests/qemu-iotests/160            |  2 +-
 tests/qemu-iotests/161            |  2 +-
 tests/qemu-iotests/162            |  2 +-
 tests/qemu-iotests/170            |  2 +-
 tests/qemu-iotests/171            |  2 +-
 tests/qemu-iotests/172            |  2 +-
 tests/qemu-iotests/173            |  2 +-
 tests/qemu-iotests/174            |  2 +-
 tests/qemu-iotests/175            |  2 +-
 tests/qemu-iotests/176            |  2 +-
 tests/qemu-iotests/177            |  2 +-
 tests/qemu-iotests/178            |  2 +-
 tests/qemu-iotests/179            |  2 +-
 tests/qemu-iotests/181            |  2 +-
 tests/qemu-iotests/182            |  2 +-
 tests/qemu-iotests/183            |  2 +-
 tests/qemu-iotests/184            |  2 +-
 tests/qemu-iotests/185            |  2 +-
 tests/qemu-iotests/186            |  2 +-
 tests/qemu-iotests/187            |  2 +-
 tests/qemu-iotests/188            |  2 +-
 tests/qemu-iotests/189            |  2 +-
 tests/qemu-iotests/190            |  2 +-
 tests/qemu-iotests/191            |  2 +-
 tests/qemu-iotests/192            |  2 +-
 tests/qemu-iotests/195            |  2 +-
 tests/qemu-iotests/197            |  2 +-
 tests/qemu-iotests/198            |  2 +-
 tests/qemu-iotests/200            |  2 +-
 tests/qemu-iotests/201            |  2 +-
 tests/qemu-iotests/204            |  2 +-
 tests/qemu-iotests/208            |  1 +
 tests/qemu-iotests/209            |  1 +
 tests/qemu-iotests/214            |  2 +-
 tests/qemu-iotests/215            |  2 +-
 tests/qemu-iotests/217            |  2 +-
 tests/qemu-iotests/220            |  2 +-
 tests/qemu-iotests/221            |  2 +-
 tests/qemu-iotests/223            |  2 +-
 tests/qemu-iotests/225            |  2 +-
 tests/qemu-iotests/226            |  2 +-
 tests/qemu-iotests/227            |  2 +-
 tests/qemu-iotests/229            |  2 +-
 tests/qemu-iotests/231            |  2 +-
 tests/qemu-iotests/232            |  2 +-
 tests/qemu-iotests/233            |  2 +-
 tests/qemu-iotests/236            |  1 +
 tests/qemu-iotests/238            |  2 ++
 tests/qemu-iotests/check          |  2 +-
 tests/qemu-iotests/common.config  |  2 +-
 tests/qemu-iotests/common.filter  | 38 +++++++++++++++----------------
 tests/qemu-iotests/common.nbd     |  2 +-
 tests/qemu-iotests/common.pattern |  2 +-
 tests/qemu-iotests/common.qemu    |  2 +-
 tests/qemu-iotests/common.rc      | 15 +++++++++++-
 tests/qemu-iotests/common.tls     |  2 +-
 tests/qemu-iotests/iotests.py     |  4 +++-
 191 files changed, 226 insertions(+), 206 deletions(-)

--=20
2.20.1
