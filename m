Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBhUD-0006N5-UT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBhUA-0008AB-54
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:03:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 15:02:53 +0100
Message-Id: <20180426140253.3918-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] vl.c: Don't zero-initialize statics for
 serial_hds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

checkpatch reminds us that statics shouldn't be zero-initialized:

ERROR: do not initialise statics to 0 or NULL
#35: FILE: vl.c:157:
+static int num_serial_hds = 0;

ERROR: do not initialise statics to 0 or NULL
#36: FILE: vl.c:158:
+static Chardev **serial_hds = NULL;

I forgot to fix this in 6af2692e86f9fdfb3d; do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I wouldn't bother with this except that I forgot to fold
it in when applying the serial-limits patchset.

 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 616956adf1..6d8b869dad 100644
--- a/vl.c
+++ b/vl.c
@@ -154,8 +154,8 @@ QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
 int no_frame;
-static int num_serial_hds = 0;
-static Chardev **serial_hds = NULL;
+static int num_serial_hds;
+static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
 Chardev *sclp_hds[MAX_SCLP_CONSOLES];
-- 
2.17.0
