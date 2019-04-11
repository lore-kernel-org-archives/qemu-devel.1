Received: from eggs.gnu.org ([209.51.188.92]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEacb-0004cp-MA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-00012K-Nf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 Apr 2019 17:23:44 +0300
Message-Id: <cover.1554992449.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

Patch 1 is the fix for the bug reported by Max here:

   https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00293.html

Patch 2 fixes a different (but slightly related) issue that I found
while preparing the first patch.

Regards,

Berto

Alberto Garcia (2):
  block: Fix check for default backing files in bdrv_reopen_prepare()
  block: Clear the backing_file fields on detach

 block.c                | 6 +++++-
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.11.0
