Received: from eggs.gnu.org ([209.51.188.92]:32786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIvw-0007Yi-Ph
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBIvv-0003xX-B6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBIvv-0003vj-38
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:54:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C27B4308794F
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 12:54:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  2 Apr 2019 13:54:14 +0100
Message-Id: <20190402125417.21573-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Filemon next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bandan Das <bsd@redhat.com>

The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8=
c7:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-r=
equest' into staging (2019-04-02 08:18:24 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/filemon-next-pull-request

for you to fetch changes up to b4682a63f86ed81abcaa543ea6135e17f9e99d01:

  filemon: fix watch IDs to avoid potential wraparound issues (2019-04-02=
 13:52:02 +0100)

----------------------------------------------------------------
filemon: various fixes / improvements to file monitor for USB MTP

Ensure watch IDs unique within a monitor and avoid integer wraparound
issues when many watches are set & unset over time.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  tests: refactor file monitor test to make it more understandable
  filemon: ensure watch IDs are unique to QFileMonitor scope
  filemon: fix watch IDs to avoid potential wraparound issues

 authz/listfile.c              |   2 +-
 hw/usb/dev-mtp.c              |  10 +-
 include/authz/listfile.h      |   2 +-
 include/qemu/filemonitor.h    |  16 +-
 tests/test-util-filemonitor.c | 650 +++++++++++++++++-----------------
 util/filemonitor-inotify.c    |  26 +-
 util/filemonitor-stub.c       |   4 +-
 util/trace-events             |   6 +-
 8 files changed, 356 insertions(+), 360 deletions(-)

--=20
2.20.1
