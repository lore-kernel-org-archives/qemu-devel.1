Received: from eggs.gnu.org ([2001:4830:134:3::10]:53306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV7-0005w9-Rk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV7-0007uB-5p
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLAV7-0007tn-1M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92A1240122BA
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 16:51:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 May 2018 18:50:52 +0200
Message-Id: <20180522165058.15404-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] display: add new bochs-display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

v2:
 - add header guards to include/hw/display/bochs-vbe.h
 - return error code from bochs_display_get_mode.
 - add MAINTAINER entries for vga.

Gerd Hoffmann (6):
  vga: move bochs vbe defines to header file
  vga-pci: use PCI_VGA_MMIO_SIZE
  hw/display: add new bochs-display device
  bochs-display: add dirty tracking support
  bochs-display: add pcie support
  MAINTAINERS: add vga entries

 hw/display/vga_int.h           |  35 +---
 include/hw/display/bochs-vbe.h |  69 ++++++++
 hw/display/bochs-display.c     | 363 +++++++++++++++++++++++++++++++++++=
++++++
 hw/display/vga-pci.c           |  19 +--
 MAINTAINERS                    |  21 +++
 hw/display/Makefile.objs       |   1 +
 6 files changed, 460 insertions(+), 48 deletions(-)
 create mode 100644 include/hw/display/bochs-vbe.h
 create mode 100644 hw/display/bochs-display.c

--=20
2.9.3
