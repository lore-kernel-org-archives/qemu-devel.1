Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTd-00005C-Q4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTY-0003Lv-Ro
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:44:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Feb 2018 13:44:45 +0100
Message-Id: <1518439489-2724-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Re-enable and extend the m48t59 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

This patch series fixes the currently disabled m48t59 test and
enables it for ppc, too.

Thomas Huth (4):
  tests/m48t59: Fix and re-enable the test for sparc
  tests/m48t59: Make the test independent of global_qtest
  tests/Makefile: Derive check-qtest-ppc64-y from check-qtest-ppc-y
  tests/m48t59: Add the m48t59 test on ppc, too

 tests/Makefile.include |  19 ++++----
 tests/m48t59-test.c    | 123 +++++++++++++++++++++++++++----------------------
 2 files changed, 76 insertions(+), 66 deletions(-)

-- 
1.8.3.1
