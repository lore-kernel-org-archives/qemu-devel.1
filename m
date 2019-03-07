Received: from eggs.gnu.org ([209.51.188.92]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9w-0002LG-IY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9v-0003LK-UX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:04 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu,  7 Mar 2019 16:33:56 +0300
Message-Id: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/4] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Some test cases require specific formats to be supported by QEMU. The
list of formats supported by the block layer doesn't take whitelists
into account. This series manages this issue. The method decorator
skip_if_unsupported() checks if requested formats are whitelisted.
The sample output is shown with the test #139.

v1:
Discussed in the email thread with the message ID:
<1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Fixes and amendments suggested by Kevin Wolf were applied in v2.

Andrey Shinkevich (4):
  iotests: open notrun files in text mode
  block: iterate_format with account of whitelisting
  iotests: ask QEMU for supported formats
  iotests: check whitelisted formats

 block.c                       | 23 ++++++++++++++++++----
 blockdev.c                    |  4 +++-
 include/block/block.h         |  2 +-
 qemu-img.c                    |  2 +-
 tests/qemu-iotests/139        |  3 +++
 tests/qemu-iotests/check      | 13 ++++++++++++-
 tests/qemu-iotests/iotests.py | 45 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 83 insertions(+), 9 deletions(-)

-- 
1.8.3.1
