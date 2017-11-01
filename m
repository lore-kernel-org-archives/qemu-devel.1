Received: from eggs.gnu.org ([2001:4830:134:3::10]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1f-0005WR-AY
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1a-00083V-Ca
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:12847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1a-00081x-4N
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:46 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 1 Nov 2017 14:25:22 +0000
Message-ID: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] QIOChannelFile bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi,

Here is a bug fix with the use of QIOChannelFile and 2 bug fixes and an
improvement to implementation of QIOChannelFile.

Regards,
Ross Lagerwall

Ross Lagerwall (4):
  migration: Don't leak IO channels
  io: Fix QIOChannelFile when creating and opening read-write
  io: Don't call close multiple times in QIOChannelFile
  io: Add /dev/fdset/ support to QIOChannelFile

 include/io/channel-file.h    |  2 +-
 io/channel-file.c            | 11 ++++-------
 migration/savevm.c           |  2 ++
 tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
 4 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.9.5
