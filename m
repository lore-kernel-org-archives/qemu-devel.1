Received: from eggs.gnu.org ([2001:4830:134:3::10]:36571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOIi-0004c0-Dn
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZOIf-0006wO-6e
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZOIe-0006vI-UJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:57:17 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 18 Dec 2018 16:57:11 -0600
Message-Id: <20181218225714.284495-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] nbd-client: drop extra error noise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com

This is a counter-proposal to Vladimir's initial post for
reducing the noise in iotest 083.  The difference is that
I dropped error_get_hint, since I couldn't find any useful
hint to be traced during transmission phase in the first place,
and instead added a trace message for the one place where we
do set hints during handshaking phase.

Eric Blake (1):
  nbd/client: Trace all server option error messages

Vladimir Sementsov-Ogievskiy (2):
  nbd: publish _lookup functions
  block/nbd-client: use traces instead of noisy error_report_err

 include/block/nbd.h        |  5 +++++
 nbd/nbd-internal.h         |  5 -----
 block/nbd-client.c         | 23 +++++++++++++++++++----
 nbd/client.c               |  2 ++
 block/trace-events         |  4 ++++
 nbd/trace-events           |  1 +
 tests/qemu-iotests/083.out | 28 ----------------------------
 7 files changed, 31 insertions(+), 37 deletions(-)

-- 
2.17.2
