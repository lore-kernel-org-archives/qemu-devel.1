Received: from eggs.gnu.org ([209.51.188.92]:53321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAv-0001ur-In
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAu-0006mH-Mo
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:37 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue,  9 Apr 2019 17:56:30 +0300
Message-Id: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-img convert: ignore read errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The 'qemu-img convert' new command option 'force read' with the key '-R'
allows converting a damaged image to get all the available information
in case of the read errors. The program reports read errors and continue
the image conversion. The users should keep in their minds that the
resulting image is inconsistent.

Andrey Shinkevich (2):
  qemu-img convert: ignore read errors
  iotests: new test 253 check qemu-img convert force read

 qemu-img-cmds.hx           |  4 +--
 qemu-img.c                 | 18 ++++++++++--
 qemu-img.texi              |  2 +-
 tests/qemu-iotests/253     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out |  4 +++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

-- 
1.8.3.1
