Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqq-0005GI-6t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwql-0007UU-51
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwqk-0007TC-CY
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 295D030012FC
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:50:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  6 Dec 2018 17:49:53 +0100
Message-Id: <1544114998-1513-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 0/5] Make more tests independent of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, eblake@redhat.com

We should avoid and finally get rid of the global_qtest variable in
our tests, since it causes trouble when running tests in parallel,
e.g. migration tests. Here are some more small patches to make some
tests independent of this variable.

Thomas Huth (5):
  tests/boot-serial: Get rid of global_qtest variable
  tests/test-filter: Make tests independent of global_qtest
  tests/machine-none: Make test independent of global_qtest
  tests/prom-env: Make test independent of global_qtest
  tests/pxe: Make test independent from global_qtest

 tests/boot-serial-test.c       | 13 +++++++------
 tests/machine-none-test.c      |  7 ++++---
 tests/prom-env-test.c          | 17 ++++++++---------
 tests/pxe-test.c               |  7 ++++---
 tests/test-filter-mirror.c     |  9 +++++----
 tests/test-filter-redirector.c | 16 +++++++++-------
 6 files changed, 37 insertions(+), 32 deletions(-)

-- 
1.8.3.1
