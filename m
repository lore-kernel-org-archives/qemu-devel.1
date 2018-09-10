Received: from eggs.gnu.org ([208.118.235.92]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzFvr-0003fP-2z
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzFvI-0006EB-4R
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzFvH-0006Df-Up
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DFAB805A6D9
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 06:43:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Sep 2018 08:43:38 +0200
Message-Id: <20180910064340.30745-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

So we have a boot display when using a vgpu as primary display.

Gerd Hoffmann (2):
  stubs: add ramfb
  hw/vfio/display: add ramfb support

 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/display.c             | 12 ++++++++++++
 hw/vfio/pci.c                 | 15 +++++++++++++++
 stubs/ramfb.c                 | 13 +++++++++++++
 stubs/Makefile.objs           |  1 +
 5 files changed, 43 insertions(+)
 create mode 100644 stubs/ramfb.c

-- 
2.9.3
