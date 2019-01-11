Received: from eggs.gnu.org ([209.51.188.92]:35859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghwi8-0002ll-92
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghwi7-0000JU-K0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:18:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ghwi7-0000JE-FA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:18:55 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 11 Jan 2019 14:18:32 +0100
Message-Id: <20190111131836.107549-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>, Maran Wilson <maran.wilson@oracle.com>

This patch series is based on "[RFC v2 0/4] QEMU changes to do PVH boot" =
and
provides a PVH option rom that can be used with SeaBIOS to boot uncompres=
sed
kernel using the x86/HVM direct boot ABI.

Patches 1 and 2 are to prepare the PVH option rom, moving common function=
s in a
new header.  Patch 3 adds the new PVH option rom and patch 4 uses it when=
 we
are booting an uncompressed kernel using the x86/HVM direct boot ABI.

Stefano Garzarella (4):
  linuxboot_dma: remove duplicate definitions of FW_CFG
  linuxboot_dma: move common functions in a new header
  optionrom: add new PVH option rom
  hw/i386/pc: use PVH option rom

 hw/i386/pc.c                      |   4 +
 pc-bios/optionrom/Makefile        |   5 +-
 pc-bios/optionrom/linuxboot_dma.c | 110 +++-------------
 pc-bios/optionrom/optrom.h        | 109 ++++++++++++++++
 pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++
 pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++
 pc-bios/optionrom/pvh_main.c      | 117 +++++++++++++++++
 7 files changed, 541 insertions(+), 96 deletions(-)
 create mode 100644 pc-bios/optionrom/optrom.h
 create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
 create mode 100644 pc-bios/optionrom/pvh.S
 create mode 100644 pc-bios/optionrom/pvh_main.c

--=20
2.20.1
