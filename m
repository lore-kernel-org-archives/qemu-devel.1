Received: from eggs.gnu.org ([2001:4830:134:3::10]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKd-0006Yo-Hs
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKa-0003Jq-QU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsuKa-0003JN-Lf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A92D40241C6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 18:27:39 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Aug 2018 12:27:36 -0600
Message-ID: <153504858585.3676.10222732707932789866.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] vfio: Fix coverity, postcopy,
 and error path issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3392fbee4e435658733bbe9aab23392660558b59:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-23 12:28:17 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180823.1

for you to fetch changes up to 154304cd6e99e4222ed762976f9d9aca33c094d3:

  postcopy: Synchronize usage of the balloon inhibitor (2018-08-23 10:45:58 -0600)

----------------------------------------------------------------
VFIO fixes 2018-08-23

 - Fix coverity reported issue with use of realpath (Alex Williamson)

 - Cleanup file descriptor in error path (Alex Williamson)

 - Fix postcopy use of new balloon inhibitor (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (3):
      vfio/pci: Handle subsystem realpath() returning NULL
      vfio/pci: Fix failure to close file descriptor on error
      postcopy: Synchronize usage of the balloon inhibitor

 hw/vfio/common.c         |  1 +
 hw/vfio/pci.c            |  2 +-
 migration/postcopy-ram.c | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)
