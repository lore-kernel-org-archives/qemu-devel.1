Received: from eggs.gnu.org ([209.51.188.92]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthd-0003ro-Dp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthc-0006aW-DF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggthc-0006SA-6q
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 16:53:49 +0100
Message-Id: <20190108155354.8591-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Usb 20190108 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:

  Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20190108-pull-request

for you to fetch changes up to efce3175fd572e4d98af0b50ae9cb8d7b808f034:

  usb: move ehci_create_ich9_with_companions to hw/i386 (2019-01-08 12:43=
:41 +0100)

----------------------------------------------------------------
usb: generic sysbus ehci, bugfixes.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  hw/usb: fix mistaken de-initialization of CCID state

Hongbo Zhang (1):
  hw/usb: Add generic sys-bus EHCI controller

Jonathan Davies (1):
  usb: drop unnecessary usb_device_post_load checks

Li Qiang (1):
  usb: dev-mtp: fix memory leak in error path

Paolo Bonzini (1):
  usb: move ehci_create_ich9_with_companions to hw/i386

 hw/usb/hcd-ehci.h           |  1 +
 include/hw/usb.h            |  2 --
 hw/i386/pc_q35.c            | 53 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/usb/bus.c                |  6 -----
 hw/usb/ccid-card-emulated.c |  2 ++
 hw/usb/dev-mtp.c            |  1 +
 hw/usb/hcd-ehci-pci.c       | 53 ---------------------------------------=
------
 hw/usb/hcd-ehci-sysbus.c    | 17 +++++++++++++++
 8 files changed, 74 insertions(+), 61 deletions(-)

--=20
2.9.3
