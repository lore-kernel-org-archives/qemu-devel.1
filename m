Received: from eggs.gnu.org ([209.51.188.92]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHOVG-0004r8-5v
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 04:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHONu-00074i-9y
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:56:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hHONu-000744-4p
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6DBA308AA1F
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 07:56:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 Apr 2019 09:56:23 +0200
Message-Id: <20190419075625.24251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

First patch fixes a problem with ohci_die(), second patch moves PCI code =
into
a separate file, so that the sysbus OHCI device can also be used without
the dependency on the PCI code.

v2: Split the patch into two patches, one for the ohci_die() fix and one
    for the PCI code movement.

Thomas Huth (2):
  hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
    ohci_die()
  hw/usb/hcd-ohci: Move PCI-related code into a separate file

 hw/sh4/Kconfig        |   2 +-
 hw/usb/Kconfig        |   6 +-
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c     | 219 ++++--------------------------------------
 hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
 6 files changed, 293 insertions(+), 202 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-pci.c
 create mode 100644 hw/usb/hcd-ohci.h

--=20
2.21.0
