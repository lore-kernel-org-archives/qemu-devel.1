Received: from eggs.gnu.org ([2001:4830:134:3::10]:52728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqanC-0005zF-Ly
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqanB-0001pX-Qh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqanB-0001o7-MQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 982B3EAE80
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:39:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:39:14 +0100
Message-Id: <20180227083919.12339-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Usb 20180227 patches
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

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180227-pull-request

for you to fetch changes up to 53735bef108c5ccddf0f8a65cde4da53a48dbd47:

  usb-mtp: Advertise SendObjectInfo for write support (2018-02-26 12:18:36 +0100)

----------------------------------------------------------------
usb: add mtp write support.

----------------------------------------------------------------

Bandan Das (5):
  usb-mtp: Add one more argument when building results
  usb-mtp: print parent path in IN_IGNORED trace fn
  usb-mtp: Support delete of mtp objects
  usb-mtp: Introduce write support for MTP objects
  usb-mtp: Advertise SendObjectInfo for write support

 hw/usb/dev-mtp.c | 471 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 441 insertions(+), 30 deletions(-)

-- 
2.9.3
