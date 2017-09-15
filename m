Received: from eggs.gnu.org ([2001:4830:134:3::10]:54675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaC-0007iX-HL
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsla9-0000YH-Ce
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dsla9-0000Y5-6i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:37 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:20 +0200
Message-Id: <1505462549-27298-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Fixes and improvements for various qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

The following changes since commit 3dabde1128b671f36ac6cb36b97b2731399644=
20:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' =
into staging (2017-09-14 16:33:02 +0100)

are available in the git repository at:

  git://github.com/huth/qemu.git tags/check-20170915

for you to fetch changes up to 7b899f4dd596dbb7d271f7fab36fbfffec84868e:

  qtest: Avoid passing raw strings through hmp() (2017-09-15 09:05:19 +02=
00)

----------------------------------------------------------------
Some fixes and improvements for various qtests by Eric and me.

----------------------------------------------------------------
Eric Blake (5):
      test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING code
      qtest: Don't perform side effects inside assertion
      numa-test: Use hmp()
      libqtest: Remove dead qtest_instances variable
      qtest: Avoid passing raw strings through hmp()

Thomas Huth (4):
      tests: Introduce generic device hot-plug/hot-unplug functions
      tests/test-hmp: Remove puv3 and tricore_testboard from the blacklis=
t
      tests/libqtest: Use a proper error message if QTEST_QEMU_BINARY is =
missing
      tests: Fix broken ivshmem-server-msi/-irq tests

 qtest.c                    |  82 ++++++++++++++++++++++++-----------
 tests/libqos/pci.c         |  26 ++++-------
 tests/libqos/usb.c         |  30 +++----------
 tests/libqtest.c           | 105 +++++++++++++++++++++++++++++++++++++++=
------
 tests/libqtest.h           |  27 ++++++++++--
 tests/numa-test.c          |  21 ++-------
 tests/test-hmp.c           |   7 ++-
 tests/test-qga.c           |  90 --------------------------------------
 tests/usb-hcd-uhci-test.c  |  26 +----------
 tests/usb-hcd-xhci-test.c  |  51 ++--------------------
 tests/virtio-scsi-test.c   |  24 +----------
 tests/virtio-serial-test.c |  25 ++---------
 12 files changed, 203 insertions(+), 311 deletions(-)
