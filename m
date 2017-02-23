Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgvVI-0000hk-40
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgvVF-0006ne-0X
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgvVE-0006n1-RL
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:20 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A74DC04B95D
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 15:40:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Feb 2017 16:40:11 +0100
Message-Id: <1487864414-25485-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] usb patch queue
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

  Hi,

usb patch queue, with cleanups and a ohci fix.

please pull,
  Gerd

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96=
ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-usb-20170223-1

for you to fetch changes up to 4f72b8d2a6f5777fa1af2cf5184843e4cb06f182:

  xhci: properties cleanup (2017-02-23 16:18:03 +0100)

----------------------------------------------------------------
usb: ohci bugfix, switch core to unrealize, xhci property cleanup

----------------------------------------------------------------
Gerd Hoffmann (1):
      xhci: properties cleanup

Li Qiang (1):
      usb: ohci: fix error return code in servicing td

Marc-Andr=C3=A9 Lureau (1):
      usb: replace handle_destroy with unrealize

 hw/usb/bus.c                  |  9 +++++----
 hw/usb/dev-audio.c            |  4 ++--
 hw/usb/dev-bluetooth.c        |  4 ++--
 hw/usb/dev-hid.c              |  4 ++--
 hw/usb/dev-hub.c              |  4 ++--
 hw/usb/dev-network.c          |  4 ++--
 hw/usb/dev-smartcard-reader.c |  4 ++--
 hw/usb/dev-uas.c              |  4 ++--
 hw/usb/dev-wacom.c            |  4 ++--
 hw/usb/hcd-ohci.c             |  2 +-
 hw/usb/hcd-xhci.c             | 29 ++++++++++++++++++++++++++---
 hw/usb/host-libusb.c          |  4 ++--
 hw/usb/redirect.c             |  4 ++--
 include/hw/usb.h              |  5 -----
 14 files changed, 52 insertions(+), 33 deletions(-)
