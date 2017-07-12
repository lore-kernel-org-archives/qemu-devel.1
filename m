Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVE9l-0000If-Qy
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVE9g-0002k8-Vv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dVE9g-0002iV-Pi
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3FF15F7B6
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:41:58 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed, 12 Jul 2017 11:41:46 +0200
Message-Id: <20170712094149.23069-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/3] tests/pxe-testt: add testcase using
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
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

This implements a testcase for pxe-test using the vhost-user interface. Spawn a
vhost-user-bridge process and connect it to the qemu process.

It is send as an RFC because: 
 - Patch 3/3: there must be cleaner way to do this.
 - Does Patch 1/3 make sense or should I just redirect all output to /dev/null? 
 - don't hardcode port numbers in qemu cmdline, create socket and pass 
    fd to -netdev (need to figure out how to do this)

Jens Freimann (3):
  tests/vhost-user-bridge: disable debug output by default
  tests/pxe-test: add testcase using vhost-user-bridge
  libvhost-user: quit when no more data received

 contrib/libvhost-user/libvhost-user.c |  12 +++-
 contrib/libvhost-user/libvhost-user.h |   1 +
 tests/Makefile.include                |   4 +-
 tests/pxe-test.c                      | 106 +++++++++++++++++++++++++++++++++-
 tests/vhost-user-bridge.c             |   2 +-
 5 files changed, 121 insertions(+), 4 deletions(-)

-- 
2.9.4
