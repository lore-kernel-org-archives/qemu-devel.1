Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQx-0007sP-QZ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQu-0002BM-Ja
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKQu-0002BA-Cx
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D49C17AC7A
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:10:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:47 +0200
Message-Id: <20170529130956.20297-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] usb patch queue
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

Here comes the usb patch queue.  As usual some bugfixes, legacy options
and hmp commands are deprecated, xhci is splitted so nec-xhci can have
its own config option.

please pull,
  Gerd

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-usb-20170529-1

for you to fetch changes up to 3bfecee2cb71f21cd39d6183f18b446c01917573:

  ehci: fix frame timer invocation. (2017-05-29 14:19:16 +0200)

----------------------------------------------------------------
usb: depricate legacy options and hmp commands
usb: fixes for ehci and hub, split xhci variants

----------------------------------------------------------------
Gerd Hoffmann (5):
      ehci: fix overflow in frame timer code
      xhci: split into multiple files
      xhci: add CONFIG_USB_XHCI_NEC option
      usb: don't wakeup during coldplug
      ehci: fix frame timer invocation.

Ladi Prosek (1):
      usb-hub: set PORT_STAT_C_SUSPEND on host-initiated wake-up

Thomas Huth (3):
      usb: Deprecate the legacy -usbdevice option
      usb: Deprecate HMP commands usb_add and usb_del
      usb: Simplify the parameter parsing of the legacy usb serial device

 hw/usb/hcd-xhci.h       | 226 ++++++++++++++++++++++++++++++++++++++++++=
+++
 hw/usb/core.c           |   8 ++
 hw/usb/dev-hub.c        |  15 ++-
 hw/usb/dev-serial.c     |  21 +----
 hw/usb/hcd-ehci.c       |  15 ++-
 hw/usb/hcd-xhci-nec.c   |  63 +++++++++++++
 hw/usb/hcd-xhci.c       | 238 +-----------------------------------------=
------
 vl.c                    |   8 ++
 default-configs/pci.mak |   1 +
 hmp-commands.hx         |   6 +-
 hw/usb/Makefile.objs    |   1 +
 qemu-options.hx         |   9 +-
 12 files changed, 348 insertions(+), 263 deletions(-)
 create mode 100644 hw/usb/hcd-xhci.h
 create mode 100644 hw/usb/hcd-xhci-nec.c
