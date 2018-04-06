Received: from eggs.gnu.org ([2001:4830:134:3::10]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4T7W-0003Fi-GB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4T7V-0003rh-9d
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:17:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  6 Apr 2018 17:17:29 +0200
Message-Id: <20180406151731.4285-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] iotests: Skip 181 and 201 without
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

My non-Fedora testing system does not have a kernel with userfaultfd
support which causes 181 and 201 to fail.  That is annoying.  This
series makes those tests recognize the issue and convert it into a
_notrun.


Max Reitz (2):
  iotests: Add failure matching to common.qemu
  iotests: Skip 181 and 201 without userfaultfd

 tests/qemu-iotests/181         | 13 ++++++++++
 tests/qemu-iotests/201         | 13 ++++++++++
 tests/qemu-iotests/common.qemu | 58 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 77 insertions(+), 7 deletions(-)

-- 
2.14.3
