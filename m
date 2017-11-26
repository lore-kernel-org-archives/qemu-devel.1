Received: from eggs.gnu.org ([2001:4830:134:3::10]:56760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xl-000726-Ew
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xi-0002qc-PN
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:45 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:00 -0600
Message-Id: <fb1f88744224be27bff1f3d6fcc177efecc159f0.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 02/17] i2c: start trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 Makefile.objs       | 1 +
 hw/i2c/trace-events | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 hw/i2c/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..984ae8ecba 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -155,6 +155,7 @@ trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
 trace-events-subdirs += hw/xen
 trace-events-subdirs += hw/ide
+trace-events-subdirs += hw/i2c
 trace-events-subdirs += ui
 trace-events-subdirs += audio
 trace-events-subdirs += net
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
new file mode 100644
index 0000000000..9284b1fbad
--- /dev/null
+++ b/hw/i2c/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.txt for syntax documentation.
-- 
2.11.0
