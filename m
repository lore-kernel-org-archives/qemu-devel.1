Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfYc1-00069f-Hu
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfYbw-0000iZ-Ij
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfYbw-0000ht-CU
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C1CEE9510
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 21:33:49 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed,  9 Aug 2017 23:33:35 +0200
Message-Id: <20170809213337.3013-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] tests/pxe-test: add testcase using
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
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

This implements a testcase for pxe-test using the vhost-user interface. Spawn a
vhost-user-bridge process and connect it to the qemu process.

changes v2->v3:
- fixed build on aarch64 by removing a flag for g_spawn_async() that is
  not even needed. Patch builds on my system for target aarch64 now

changes v1->v2:

- new patch 4/5. Necessary to make qtest_add_abrt_handler work. 
- get rid of hugepagefs specific code (mst)
- use htonl and INADDR_LOOPBACK to set remote address (Stefan Hajnoczi)
- add qtest abort handler (Stefan Hajnoczi)
- spawn vhost-user-bridge process with flag DO_NOT_REAP_CHILD and add a child
  watch function (Stefan Hajnoczi)
  Killing the vubr process manually at the end of the test and watching
  its termination with the child watch function. 
- clean up pxe-test-disk images 
- add Jason Wang to Cc

regards,
Jens


Jens Freimann (2):
  tests/vhost-user-bridge: disable debug output by default
  tests/pxe-test: add testcase using vhost-user-bridge

 tests/Makefile.include    |   4 +-
 tests/pxe-test.c          | 114 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/vhost-user-bridge.c |   2 +-
 3 files changed, 117 insertions(+), 3 deletions(-)

-- 
2.13.3
