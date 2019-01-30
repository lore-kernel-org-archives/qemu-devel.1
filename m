Received: from eggs.gnu.org ([209.51.188.92]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOS-0004v4-QG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-00077v-Lp
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-000749-E1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:18 +0100
Message-Id: <20190130073426.11525-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Usb 20190130 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f4=
0e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90129' into staging (2019-01-29 12:00:19 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20190130-pull-request

for you to fetch changes up to 49f9e8d660d41cbe325d554e742d7100d59a7abf:

  usb-mtp: replace the homebrew write with qemu_write_full (2019-01-30 06=
:47:52 +0100)

----------------------------------------------------------------
usb: xhci: fix iso transfers.
usb: mtp: break up writes, bugfixes.
usb: fix lgpl info in headers.
usb: hid: unique serials.

----------------------------------------------------------------

Bandan Das (3):
  usb-mtp: Reallocate buffer in multiples of MTP_WRITE_BUF_SZ
  usb-mtp: breakup MTP write into smaller chunks
  usb-mtp: replace the homebrew write with qemu_write_full

Gerd Hoffmann (1):
  usb: assign unique serial numbers to hid devices

Li Qiang (1):
  usb: dev-mtp: close fd in usb_mtp_object_readdir()

Thomas Huth (1):
  hw/usb: Fix LGPL information in the file headers

Yuri Benditovich (2):
  usb: XHCI shall not halt isochronous endpoints
  usb: implement XHCI underrun/overrun events

 hw/usb/hcd-ehci.h        |   4 +-
 hw/usb/hcd-xhci.h        |   1 +
 hw/core/machine.c        |   3 +
 hw/usb/combined-packet.c |   4 +-
 hw/usb/dev-hid.c         |  26 ++++----
 hw/usb/dev-mtp.c         | 168 +++++++++++++++++++++++++++++------------=
------
 hw/usb/hcd-ehci-pci.c    |   4 +-
 hw/usb/hcd-ehci-sysbus.c |   4 +-
 hw/usb/hcd-ehci.c        |   5 +-
 hw/usb/hcd-xhci.c        |  22 ++++++-
 10 files changed, 153 insertions(+), 88 deletions(-)

--=20
2.9.3
