Received: from eggs.gnu.org ([2001:4830:134:3::10]:44297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVi-0004b4-Ri
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVh-0000ce-UN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVh-0000bY-IA
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD3958830D
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:29:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:43 +0200
Message-Id: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Usb 20181001 patches
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

The following changes since commit 07f426c35eddd79388a23d11cb278600d7e3831d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180926' into staging (2018-09-28 18:56:09 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20181001-pull-request

for you to fetch changes up to a60f39a4681b369bdcc78a9d1a1067d4a6bb8736:

  ohci: set effectively usb frame rate to 1kHz (2018-10-01 10:49:54 +0200)

----------------------------------------------------------------
usb: fixes for mtp, hub and ohci.

----------------------------------------------------------------

Bandan (2):
  usb-mtp: fix error conditions for write operation
  doc: replace x-root with rootdir for usb-mtp

Bandan Das (1):
  usb-mtp: reset ObjectInfo dataset size on cleanup

Gerd Hoffmann (1):
  usb-hub: clear suspend on detach

Miguel GAIO (1):
  ohci: set effectively usb frame rate to 1kHz

 hw/usb/dev-hub.c          | 4 ++++
 hw/usb/dev-mtp.c          | 9 ++++++---
 hw/usb/hcd-ohci.c         | 6 +++++-
 qemu-doc.texi             | 2 +-
 scripts/device-crash-test | 2 +-
 5 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.9.3
