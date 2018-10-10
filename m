Received: from eggs.gnu.org ([2001:4830:134:3::10]:57906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQg-00018k-Mw
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQc-000179-KJ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQc-00016Y-8O
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id z25-v6so14363105wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:54:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 Oct 2018 23:53:52 +0200
Message-Id: <20181010215355.16221-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] pci: Add missing include and remove
 unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Michael, these are obvious cleanups patches.

I might ressurect David's old series later:
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg05277.html

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  hw/pci-bridge/xio3130: Remove unused functions
  hw/pci-bridge/ioh3420: Remove unuseful header
  hw/pci: Add missing include

 hw/pci-bridge/ioh3420.h            |  6 ------
 hw/pci-bridge/xio3130_downstream.h | 11 -----------
 hw/pci-bridge/xio3130_upstream.h   | 10 ----------
 include/hw/pci/pci_bus.h           |  2 ++
 hw/pci-bridge/ioh3420.c            |  2 +-
 hw/pci-bridge/xio3130_downstream.c | 28 +---------------------------
 hw/pci-bridge/xio3130_upstream.c   | 24 +-----------------------
 7 files changed, 5 insertions(+), 78 deletions(-)
 delete mode 100644 hw/pci-bridge/ioh3420.h
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h

-- 
2.19.1
