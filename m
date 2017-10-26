Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hWn-0006g9-ET
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hWi-0004NC-GC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1e7hWi-0004Kj-9u
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B78E25C40
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:44:46 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Thu, 26 Oct 2017 14:44:23 +0200
Message-Id: <20171026124425.17957-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [v3 0/2] tests/pxe-test: add testcase using
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
Cc: mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

This implements a testcase for pxe-test using the vhost-user interface. Spawn a
vhost-user-bridge process and connect it to the qemu process

v2->v3:
 * rebase to current master
 * run test with slow test cases, as it takes a bit of time

Jens Freimann (2):
  tests/vhost-user-bridge: disable debug output by default
  tests/pxe-test: add testcase using vhost-user-bridge

 tests/Makefile.include    |   4 +-
 tests/pxe-test.c          | 111 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/vhost-user-bridge.c |   2 +-
 3 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.13.6
