Received: from eggs.gnu.org ([2001:4830:134:3::10]:50121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqHCr-0002LA-VK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqHCm-0008GJ-Vr
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqHCm-0008Fo-PS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:39:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95657C05AA5B
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:39:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 21 Mar 2017 11:39:49 +0100
Message-Id: <1490092792-30957-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

We currently do not test HMP commands automatically yet, so if they
break, we do not notice this until somebody runs into the problem
(like the "info qtree" problem that we recently had on qemu-system-ppc64).
So let's add a simple tester that runs some HMP commands to check if they
can crash or abort QEMU.

Note: Three boards are currently still blacklisted in the third patch.
I've added the problems to our BiteSizeTasks wiki page, so I hope they
will get fixed by GSoC students or somebody else soon. Once the problems
are fixed, the blacklisting can be removed in the tester, too.

Thomas Huth (3):
  libqtest: Ignore QMP events when parsing the response for HMP commands
  libqtest: Add a generic function to run a callback function for every
    machine
  tests: Add a tester for HMP commands

 tests/Makefile.include |   2 +
 tests/libqtest.c       |  36 +++++++++++
 tests/libqtest.h       |   8 +++
 tests/pc-cpu-test.c    |  95 +++++++++++------------------
 tests/qom-test.c       |  36 ++---------
 tests/test-hmp.c       | 160 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 248 insertions(+), 89 deletions(-)
 create mode 100644 tests/test-hmp.c

-- 
1.8.3.1
