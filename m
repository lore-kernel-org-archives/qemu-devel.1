Received: from eggs.gnu.org ([2001:4830:134:3::10]:42142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Ho-0000fb-6x
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Hj-0000Ow-5Q
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS8Hi-0000OK-VP
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D05E0883CD
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:21:45 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:21:20 +0100
Message-Id: <20171221212125.19075-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] vhost-user-test: Fixes & code clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

Sorry, I missed to fixup the feature mask in patch 4,
this is the only change in this v3.

The two changes in v2 are fixing the features mask
before the function rework, and reword of commit message
of patch "vhost-user-test: extract read-guest-mem test
from main loop" (Thanks Marc-Andr=C3=A9).

This series fixes two issues in vhost-user-test:
1. Setup virtqueues in all tests
2. Fix features mask for all but test_multiqueue()

The clean-ups comprises making read-guest-mem test consistent
with other tests by initializing the device in the qtest thread.
Also, some code factorization is done with regard to device
initialization so that all tests share the same init.

Maxime Coquelin (5):
  vhost-user-test: fix features mask
  vhost-user-test: extract read-guest-mem test from main loop
  vhost-user-test: setup virtqueues in all tests
  vhost-user-test: make features mask an init_virtio_dev() argument
  vhost-user-test: use init_virtio_dev in multiqueue test

 tests/vhost-user-test.c | 171 ++++++++++++++++++++++--------------------=
------
 1 file changed, 79 insertions(+), 92 deletions(-)

--=20
2.14.3
