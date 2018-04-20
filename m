Received: from eggs.gnu.org ([2001:4830:134:3::10]:43386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPN-0006LF-N9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPM-0007rE-TL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPM-0007mN-Mc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:47 +0100
Message-Id: <20180420145249.32435-12-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/13] superio: Don't use MAX_SERIAL_PORTS for
 serial port limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The superio device has a limit on the number of serial
ports it supports which is really only there because
it has a fixed-size array serial[]. This limit isn't
related particularly to the global MAX_SERIAL_PORTS limit,
so use a different #define for it.

(In practice the users of superio only ever want 2 serial ports.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/superio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index f9ba29aa30..345f006081 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -22,13 +22,15 @@
 #define ISA_SUPERIO_CLASS(klass) \
     OBJECT_CLASS_CHECK(ISASuperIOClass, (klass), TYPE_ISA_SUPERIO)
 
+#define SUPERIO_MAX_SERIAL_PORTS 4
+
 typedef struct ISASuperIODevice {
     /*< private >*/
     ISADevice parent_obj;
     /*< public >*/
 
     ISADevice *parallel[MAX_PARALLEL_PORTS];
-    ISADevice *serial[MAX_SERIAL_PORTS];
+    ISADevice *serial[SUPERIO_MAX_SERIAL_PORTS];
     ISADevice *floppy;
     ISADevice *kbc;
     ISADevice *ide;
-- 
2.17.0
