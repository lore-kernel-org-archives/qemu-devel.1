Received: from eggs.gnu.org ([2001:4830:134:3::10]:33132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJFz-0000Ow-7c
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJFu-0005WQ-LF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:11:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  5 Sep 2017 14:11:11 -0500
Message-Id: <20170905191114.5959-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] nbd: Use common read/write-all qio
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

Now that Daniel just added convenience qio channel looping functions,
we might as well use it in NBD instead of open-coding our own.  In
doing so, fix a couple of short-falls noticed in the qio code.

If Dan is happy with this, I can take the series through the NBD queue.

[The diffstat is slightly misleading - it's a net reduction in lines
of code, but the added comments hide that fact]

Eric Blake (3):
  io: Yield rather than wait when already in coroutine
  io: Add new qio_channel_read{,v}_all_eof functions
  nbd: Use new qio_channel_*_all() functions

 include/block/nbd.h        |  2 --
 include/io/channel.h       | 53 ++++++++++++++++++++++++++++++++++++++++
 nbd/nbd-internal.h         | 41 ++++++-------------------------
 block/nbd-client.c         | 15 ++++++------
 io/channel.c               | 60 ++++++++++++++++++++++++++++++++++++++--------
 nbd/common.c               | 45 ----------------------------------
 tests/qemu-iotests/083.out |  8 +++----
 7 files changed, 121 insertions(+), 103 deletions(-)

-- 
2.13.5
