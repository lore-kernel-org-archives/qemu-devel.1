Received: from eggs.gnu.org ([2001:4830:134:3::10]:37235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hk-0008Fi-0N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hd-0000dn-2C
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs2hb-0000cK-M0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A12487A78
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 09:11:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 11:11:41 +0200
Message-Id: <20180821091148.32220-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Usb 20180821 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180821-pull-request

for you to fetch changes up to 15aa757d0523b9d6fb26ea1e5c967ba0619dce0a:

  dev-mtp: rename x-root to rootdir (2018-08-21 10:27:59 +0200)

----------------------------------------------------------------
usb: mtp write support, bugfixes.

----------------------------------------------------------------

Bandan Das (5):
  dev-mtp: add support for canceling transaction
  dev-mtp: fix buffer allocation for writing file contents
  dev-mtp: retry write for incomplete transfers
  dev-mtp: Add support for > 4GB file transfers
  dev-mtp: rename x-root to rootdir

Sebastian Bauer (1):
  ohci: Clear the interrupt counter for erroneous transfers

npes87184 (1):
  docs/usb2.txt: ehci has six ports

 docs/usb2.txt     |  4 +--
 hw/usb/dev-mtp.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++---------
 hw/usb/hcd-ohci.c |  3 ++
 3 files changed, 84 insertions(+), 16 deletions(-)

-- 
2.9.3
