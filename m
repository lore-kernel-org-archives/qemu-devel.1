Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfU-0005Sa-Gk
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfT-0002w9-Qf
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:05 +0100
Message-Id: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, berrange@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This adds blockdev-add support to the iscsi block driver.

Note that this is only compile tested at this point. Jeff is going to
take over from here and bring the series to a mergable state.

Kevin Wolf (6):
  iscsi: Split URL into individual options
  iscsi: Handle -iscsi user/password in bdrv_parse_filename()
  iscsi: Add initiator-name option
  iscsi: Add header-digest option
  iscsi: Add timeout option
  iscsi: Add blockdev-add support

 block/iscsi.c        | 342 ++++++++++++++++++++++++++++++---------------------
 qapi/block-core.json |  74 ++++++++++-
 2 files changed, 272 insertions(+), 144 deletions(-)

-- 
1.8.3.1
