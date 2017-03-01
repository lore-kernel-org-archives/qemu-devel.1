Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0hy-0006XM-Cx
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0ht-0006pb-Gr
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cj0ht-0006p1-6J
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  1 Mar 2017 10:37:46 +0100
Message-Id: <20170301093748.28033-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: fix eventfd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

This patch series byte-swap the uint64_t data stream
of a file-descriptor opened with eventfd().

It allows to pass more LTP test cases:

eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01    1  TPASS  :  counter value matches required
eventfd01    2  TPASS  :  read failed with EAGAIN as expected
eventfd01    3  TPASS  :  counter value matches required
eventfd01    4  TPASS  :  write failed with EAGAIN as expected
eventfd01    5  TPASS  :  read failed with EINVAL as expected
eventfd01    6  TPASS  :  write failed with EINVAL as expected
eventfd01    7  TPASS  :  write failed with EINVAL as expected
eventfd01    8  TPASS  :  fd is set in readfds
eventfd01    9  TPASS  :  fd is not set in readfds
eventfd01   10  TPASS  :  fd is set in writefds
eventfd01   11  TPASS  :  fd is not set in writefds
eventfd01   12  TPASS  :  counter value write from child successful
eventfd01   13  TCONF  :  eventfd01.c:642: eventfd support is not available in AIO subsystem
eventfd01   14  TCONF  :  eventfd01.c:647: eventfd support is not available in AIO subsystem
eventfd01   15  TCONF  :  eventfd01.c:652: eventfd support is not available in AIO subsystem

Laurent Vivier (2):
  linux-user: call fd_trans_target_to_host_data() for write()
  linux-user: fix eventfd

 linux-user/syscall.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

-- 
2.9.3
