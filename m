Received: from eggs.gnu.org ([209.51.188.92]:38133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEeLa-0005l8-Mc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEeLZ-0006yF-P9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hEeLZ-0006xp-HT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 11 Apr 2019 20:22:40 +0200
Message-Id: <20190411182240.5957-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1] hw/input: Add a CONFIG_PS2 switch for
 the ps2.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>

ps2.c only needs to be compiled if we are building pckbd.c or pl050.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/Kconfig       | 5 +++++
 hw/input/Makefile.objs | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index e2e66f0858..316573f782 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -8,10 +8,15 @@ config LM832X
 config PCKBD
     bool
     default y
+    select PS2
     depends on ISA_BUS
=20
 config PL050
     bool
+    select PS2
+
+config PS2
+    bool
=20
 config STELLARIS_INPUT
     bool
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index c8b00f71ec..6db5ee0e71 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -3,7 +3,7 @@ common-obj-y +=3D hid.o
 common-obj-$(CONFIG_LM832X) +=3D lm832x.o
 common-obj-$(CONFIG_PCKBD) +=3D pckbd.o
 common-obj-$(CONFIG_PL050) +=3D pl050.o
-common-obj-y +=3D ps2.o
+common-obj-$(CONFIG_PS2) +=3D ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) +=3D stellaris_input.o
 common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
=20
--=20
2.21.0
