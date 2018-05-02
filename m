Received: from eggs.gnu.org ([2001:4830:134:3::10]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFV-0003TK-Gl
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFU-0005OU-Py
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 22:20:48 +0200
Message-Id: <20180502202051.15493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-io/img: Fix -U/force-share conflict
 testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

qemu-img and qemu-io try to detect when you use both -U and force-share
manually, but a conflict is not rejected with an error message but with
a segmentation fault.  I guess that works, but it's probably not the way
it was meant to be.


Max Reitz (3):
  qemu-io: Use purely string blockdev options
  qemu-img: Use only string options in img_open_opts
  iotests: Add test for -U/force-share conflicts

 qemu-img.c                 |  4 ++--
 qemu-io.c                  |  4 ++--
 tests/qemu-iotests/153     | 17 +++++++++++++++++
 tests/qemu-iotests/153.out | 16 ++++++++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.14.3
