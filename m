Received: from eggs.gnu.org ([2001:4830:134:3::10]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd9-0003bR-Ia
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd8-0005R6-Qu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd8-0005Pf-KE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd7-00041S-GK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:12 +0100
Message-Id: <20180622125713.15303-28-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/28] vl.c: Don't zero-initialize statics for
 serial_hds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

checkpatch reminds us that statics shouldn't be zero-initialized:

ERROR: do not initialise statics to 0 or NULL
#35: FILE: vl.c:157:
+static int num_serial_hds = 0;

ERROR: do not initialise statics to 0 or NULL
#36: FILE: vl.c:158:
+static Chardev **serial_hds = NULL;

I forgot to fix this in 6af2692e86f9fdfb3d; do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180426140253.3918-1-peter.maydell@linaro.org
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index b3426e03d09..d451f45dc59 100644
--- a/vl.c
+++ b/vl.c
@@ -151,8 +151,8 @@ QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
 int no_frame;
-static int num_serial_hds = 0;
-static Chardev **serial_hds = NULL;
+static int num_serial_hds;
+static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
 int win2k_install_hack = 0;
-- 
2.17.1
