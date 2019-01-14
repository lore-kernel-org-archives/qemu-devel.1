Received: from eggs.gnu.org ([209.51.188.92]:44773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4v-0005c7-Ot
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4t-0007VQ-NH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4r-0007Tt-NJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:41 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:05 +0100
Message-Id: <1547460140-1473-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/25] hw/input/ps2: Remove PS2State from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

PS2State is only used in "hw/input/ps2.h", there is no
need to expose it via "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the forward declaration
to "hw/input/ps2.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/input/ps2.h  | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 213aa16..b60455d 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -31,6 +31,8 @@
 #define PS2_MOUSE_BUTTON_SIDE   0x08
 #define PS2_MOUSE_BUTTON_EXTRA  0x10
=20
+typedef struct PS2State PS2State;
+
 /* ps2.c */
 void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg);
 void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 741935f..28a8b9e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -83,7 +83,6 @@ typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
-typedef struct PS2State PS2State;
 typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
--=20
1.8.3.1
