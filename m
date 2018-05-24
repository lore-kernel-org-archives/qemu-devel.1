Received: from eggs.gnu.org ([2001:4830:134:3::10]:52866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRI-0000Mx-A6
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRC-0002zb-PS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRC-0002zE-LP
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:45:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5773B88842
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:49 +0200
Message-Id: <20180524154556.17876-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Vga 20180524 patches
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

The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd46=
6d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2018-05-22 09:43:58 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180524-pull-request

for you to fetch changes up to dbb2e4726c76dbffb39efe6623bf75d2ec1db8bc:

  MAINTAINERS: add vga entries (2018-05-24 10:42:13 +0200)

----------------------------------------------------------------
vga: catch depth 0
hw/display: add new bochs-display device
some cleanups.

----------------------------------------------------------------

Gerd Hoffmann (7):
  vga: catch depth 0
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
 hw/display/vga.c               |  23 ++-
 MAINTAINERS                    |  21 +++
 hw/display/Makefile.objs       |   1 +
 7 files changed, 478 insertions(+), 53 deletions(-)
 create mode 100644 include/hw/display/bochs-vbe.h
 create mode 100644 hw/display/bochs-display.c

--=20
2.9.3
