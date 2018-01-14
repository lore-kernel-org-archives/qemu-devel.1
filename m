Received: from eggs.gnu.org ([2001:4830:134:3::10]:41299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqg-00082K-GM
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqf-0001AB-K8
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41920
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eafqf-00017w-E9
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:09 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 14 Jan 2018 10:47:49 +0000
Message-Id: <20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 09/11] pci: add trace-events support for
 hw/pci-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
---
 Makefile.objs            | 1 +
 hw/pci-host/trace-events | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 hw/pci-host/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index c8b1bba593..6aa793ce4f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -149,6 +149,7 @@ trace-events-subdirs += hw/i386/xen
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/pci
+trace-events-subdirs += hw/pci-host
 trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
new file mode 100644
index 0000000000..9284b1fbad
--- /dev/null
+++ b/hw/pci-host/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.txt for syntax documentation.
-- 
2.11.0
