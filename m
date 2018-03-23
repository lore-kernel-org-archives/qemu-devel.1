Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNV-0007IY-2M
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNQ-00058u-Sl
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNNQ-00058j-OA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:04 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Mar 2018 22:08:17 +0800
Message-Id: <20180323140821.28957-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Temporarily disable OOB for 2.12 since it break (a lot of) things.
Luckily it's only a switch so not so hard. Meanwhile, revert all new
tests that checks against it.

Tests done: all target builds and "make check" passed, but only on
x86_64 host.  It can pass all "raw" iotests, but some "qcow2" iotests
are still failing.  I can even reproduce many of the qcow2 fails even
before the whole OOB series, so I suppose that's something already
exists so I'll ignore.

More tests are really welcomed.  Thanks,

Peter

Peter Xu (4):
  Revert "monitor: enable IO thread for (qmp & !mux) typed"
  Revert "tests: qmp-test: add oob test"
  Revert "tests: qmp-test: verify command batching"
  tests: partly revert "qmp: introduce QMPCapability"

 monitor.c        |  5 +--
 tests/qmp-test.c | 97 +-------------------------------------------------------
 2 files changed, 2 insertions(+), 100 deletions(-)

-- 
2.14.3
