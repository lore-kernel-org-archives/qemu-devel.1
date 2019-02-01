Received: from eggs.gnu.org ([209.51.188.92]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXyo-0002Lt-9V
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXye-0004cl-C3
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gpXyZ-0004ar-BI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:19 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Feb 2019 13:30:56 +0100
Message-Id: <20190201123100.27419-2-kraxel@redhat.com>
In-Reply-To: <20190201123100.27419-1-kraxel@redhat.com>
References: <20190201123100.27419-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] hw/display: Move Milkymist specific
 hardware out of common-obj list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The Milkymist specific hardware is only used by the LM32 target,
it is pointless to compile those objects in other targets.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190130120005.23123-2-philmd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 97acd5b6cb..5b770817c7 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -25,10 +25,10 @@ common-obj-$(CONFIG_BOCHS_DISPLAY) +=3D edid-region.o
 common-obj-$(CONFIG_BLIZZARD) +=3D blizzard.o
 common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
+obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
=20
-common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
+obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
 milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
 milkymist-tmu2.o-libs :=3D $(X11_LIBS)
=20
--=20
2.9.3
