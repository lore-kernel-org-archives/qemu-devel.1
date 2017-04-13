Received: from eggs.gnu.org ([2001:4830:134:3::10]:37575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRT-0003M2-Ob
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRT-0002Kr-3j
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:11 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 22:33:58 +0200
Message-Id: <20170413203401.3213-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/3] qemu-img/convert: Some small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This series fixes some small issues I found in qemu-img's convert
subcommand while reviewing Dan's convert/dd series.

Nothing serious at all, so all for 2.10.


Max Reitz (3):
  qemu-img/convert: Always set ret < 0 on error
  qemu-img/convert: Use @opts for one thing only
  qemu-img/convert: Move bs_n > 1 && -B check down

 qemu-img.c                 | 26 +++++++++++++++-----------
 tests/qemu-iotests/122.out |  4 ++--
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.12.2
