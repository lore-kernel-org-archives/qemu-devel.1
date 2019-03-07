Received: from eggs.gnu.org ([209.51.188.92]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1ug1-00077u-8E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1ufv-0002dP-Qd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  7 Mar 2019 16:10:44 +0100
Message-Id: <20190307151046.15086-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/2] qemu-iotests: Add dependency to
 qemu-block tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi Kevin, Max, John.

Two trivial fixes I encountered while trying to run QEMU test suite on
a distribution which doesn't has the qemu-tools distrib-wide installed,
see https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html:

  $ make vm-build-ubuntu.i386
  Traceback (most recent call last):
    File "source/qemu/tests/vm/basevm.py", line 236, in main
      return vm.build_image(args.image)
    File "tests/vm/ubuntu.i386", line 67, in build_image
      subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
  OSError: [Errno 2] No such file or directory
  tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.i=
mg' failed
  make: *** [tests/vm/ubuntu.i386.img] Error 2

All patches are reviewed.

Since v3:
- dropped RFC patches
- split generic tests/ patches (sent as another series)

Since v2:
- Added R-b tags
- Addressed Eric's comments (in code and commit descriptions)

Since v1:
- various qemu-block fixes and notes.

Regards,

Phil.

v3: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00952.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07513.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06676.html

Philippe Mathieu-Daud=C3=A9 (2):
  ahci-test: Add dependency to qemu-img tool
  qemu-iotests: Add dependency to qemu-nbd tool

 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.20.1
