Received: from eggs.gnu.org ([2001:4830:134:3::10]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEO8-0000f7-Pq
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEO4-00053J-9J
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEO4-000535-4C
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 386BD804BAAD
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:22 +0200
Message-Id: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Disable tests when device is not compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

The following changes since commit 235c82acca0491465e94be3cae2583b42d37c859:

  Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180823' into staging (2018-08-25 13:08:57 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/check/20180827

for you to fetch changes up to ee1f6c812b3240420dff07a3860060b7d4abfe09:

  check: Move wdt_ib700 test to common (2018-08-27 11:27:07 +0200)

----------------------------------------------------------------
check/next for 20180827

Hi

This are the patches that are reviewed to disable tests when devices
are not compiled in.  I will stop now until the changes to qtest are
finished.

Later, Juan.

----------------------------------------------------------------
Juan Quintela (9):
      configure: We don't want to clean configuration files
      check: Only test isa-testdev when it is compiled in
      check: Only test usb-xhci-nec when it is compiled in
      x86_64-softmmu: Configuration is identical to i386-softmmu
      check: Only test ivshm when it is compiled in
      check: Only test boot-serial when sga is compiled in
      check: Move VMXNET3 test to common
      check: Move endianess test to common
      check: Move wdt_ib700 test to common

 Makefile                           |  3 +-
 default-configs/x86_64-softmmu.mak | 67 +-------------------------------------
 tests/Makefile.include             | 41 +++++++++--------------
 3 files changed, 19 insertions(+), 92 deletions(-)
