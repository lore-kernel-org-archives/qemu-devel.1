Received: from eggs.gnu.org ([208.118.235.92]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTmx-0005Lg-HX
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTmw-0005Ye-PN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:01:43 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 18:58:42 +0100
Message-Id: <20190104175847.6290-12-philmd@redhat.com>
In-Reply-To: <20190104175847.6290-1-philmd@redhat.com>
References: <20190104175847.6290-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/16] typedefs: Remove PS2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

PS2State is only used in "hw/input/ps2.h", there is no
need to expose it via "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/input/ps2.h  | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 213aa16aa3..b60455d4f6 100644
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
index 927b340bb4..181f8fa68e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -82,7 +82,6 @@ typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
-typedef struct PS2State PS2State;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QemuDmaBuf QemuDmaBuf;
--=20
2.17.2
