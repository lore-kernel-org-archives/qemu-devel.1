Received: from eggs.gnu.org ([2001:4830:134:3::10]:54264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dYUfK-0003w1-Cr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dYUfH-0000SN-AO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dYUfH-0000Qy-3X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 810C0883AC
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 09:56:04 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Fri, 21 Jul 2017 11:55:49 +0200
Message-Id: <20170721095553.10717-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, stefanha@redhat.com

This implements a testcase for pxe-test using the vhost-user interface. Spawn a
vhost-user-bridge process and connect it to the qemu process.

To make the testcase work we need to apply a few patches before the actual testcase:
- Patch 1 disables debug output of vhost-user-bridge
- Patch 2 fixes passing a file descriptor to -netdev.  This was broken since the
  mcast option was introduced. 
- Patch 3 makes sure we stop processing vhost-user messages when recvmsg returns 0.

regards,
Jens

Jens Freimann (4):
  tests/vhost-user-bridge: disable debug output by default
  net: fix -netdev socket,fd= for UDP sockets
  libvhost-user: quit when no more data received
  tests/pxe-test: add testcase using vhost-user-bridge

 contrib/libvhost-user/libvhost-user.c |   4 +-
 net/socket.c                          |  37 +++++----
 tests/Makefile.include                |   4 +-
 tests/pxe-test.c                      | 140 +++++++++++++++++++++++++++++++++-
 tests/vhost-user-bridge.c             |   2 +-
 5 files changed, 164 insertions(+), 23 deletions(-)

-- 
2.9.4
