Received: from eggs.gnu.org ([2001:4830:134:3::10]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJFA1-0006Op-KG
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJF9x-0004Y9-Gp
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJF9x-0004Wv-6c
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99AD740200A7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:25:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 May 2018 11:25:09 +0200
Message-Id: <20180517092513.735-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] display: add new bochs-display device
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



Gerd Hoffmann (4):
  vga: move bochs vbe defines to header file
  display: add new bochs-display device
  bochs-display: add dirty tracking support
  bochs-display: add pcie support

 hw/display/vga_int.h           |  35 +---
 include/hw/display/bochs-vbe.h |  64 ++++++++
 hw/display/bochs-display.c     | 362 +++++++++++++++++++++++++++++++++++++++++
 hw/display/vga-pci.c           |  13 --
 hw/display/Makefile.objs       |   1 +
 5 files changed, 429 insertions(+), 46 deletions(-)
 create mode 100644 include/hw/display/bochs-vbe.h
 create mode 100644 hw/display/bochs-display.c

-- 
2.9.3
