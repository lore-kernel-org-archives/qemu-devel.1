Received: from eggs.gnu.org ([2001:4830:134:3::10]:44554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkH-0003Us-J4
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkG-0002vM-NY
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1eiEkG-0002vD-HG
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:48 -0500
Received: by mail-wm0-x241.google.com with SMTP id b21so20016267wme.4
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 23:29:48 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun,  4 Feb 2018 15:28:22 +0800
Message-Id: <1517729303-32043-2-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/input/pckdb: put TYPE_I8042 into a
 single header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This allows the macro to be used elsewhere, for example,
when adding link property to vmmouse object.

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/input/pckbd.c | 2 +-
 hw/input/pckbd.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 hw/input/pckbd.h

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f82..d517938 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
 #include "sysemu/sysemu.h"
+#include "pckbd.h"
 
 /* debug PC keyboard */
 //#define DEBUG_KBD
@@ -480,7 +481,6 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
     qemu_register_reset(kbd_reset, s);
 }
 
-#define TYPE_I8042 "i8042"
 #define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
 
 typedef struct ISAKBDState {
diff --git a/hw/input/pckbd.h b/hw/input/pckbd.h
new file mode 100644
index 0000000..9cacd0a
--- /dev/null
+++ b/hw/input/pckbd.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_PCKCD_H
+#define QEMU_PCKCD_H
+
+#define TYPE_I8042 "i8042"
+
+#endif
-- 
2.7.4
