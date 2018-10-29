Received: from eggs.gnu.org ([2001:4830:134:3::10]:51401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDki-0003SH-Qj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkd-00062d-Sk
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gHDkd-00062L-NG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BBF0B4EF
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 20:03:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 21:02:47 +0100
Message-Id: <20181029200250.24029-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Usb 20181029 patches
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

The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20181029-pull-request

for you to fetch changes up to 7dea29e4af17fc1d27478de9f8ea38144deac54a:

  hw: ccid-card-emulated: cleanup resource when realize in error path (2018-10-29 10:46:07 +0100)

----------------------------------------------------------------
usb: fixes for ohci and smart card emulation.

----------------------------------------------------------------

Li Qiang (3):
  usb: ohci: make num_ports to an unsinged integer
  hw: ccid-card-emulated: introduce clean_event_notifier
  hw: ccid-card-emulated: cleanup resource when realize in error path

 hw/usb/ccid-card-emulated.c | 27 +++++++++++++++++++++------
 hw/usb/hcd-ohci.c           |  6 +++---
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.9.3
