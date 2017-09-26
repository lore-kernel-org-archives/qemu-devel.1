Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywe-0007ih-8k
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywb-0005Df-32
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywa-0005Cc-T7
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D63281DEA
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:03 -0300
Message-Id: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 0/6] device-crash-test: device_add test mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>

This series implements device_add testing on device-crash-test.
The new test mode will be enabled by default in addition to the
old test cases, but if only device_add testing is wanted, it can
be specified using the '-t' command-line option, e.g.:

  $ ./scripts/device-crash-test -t method=device_add

In comparison to the "-device" test cases, a full test run runs
reasonably quickly (17 seconds on my machine for testing all
hotpluggable devices on all 72 machine-types in
qemu-system-x86_64).  I believe it is a good candidate to be
eventually included on "make check".

TODO:
* Fix the QEMU crash found using '-t plug_all=1'
  (see patch 5/5 for details)
* Test non-x86 architectures
* Compare results with Thomas' HMP unit test
  ("tests: Add a device_add/del HMP test" patch").

Based-on: 20170926220319.12889-1-ehabkost@redhat.com
(Subject: [PATCH 0/4] qmp: query-device-type command)

Eduardo Habkost (6):
  device-crash-test: Make whitelist code a bit more flexible
  device-crash-test: Log detailed info on success too
  device-crash-test: Allow checkOneCase() to report multiple results
  device-crash-test: Exit immediately on fatal failures on quick mode
  device-crash-test: Basic device_add support
  device-crash-test: Multi-device device_add test

 scripts/device-crash-test | 132 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 38 deletions(-)

-- 
2.13.5
