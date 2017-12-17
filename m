Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQjrZ-00043A-Ih
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQjrU-0007R0-Mo
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:05:01 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:28:05 +0300
Message-Id: <8908b72ecbfba7ee66f995529e5a9f0eaebefe22.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 60/61] i386/pc: move vmmouse.c to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

It's a x86-only device, so it does not make sense to keep it
in the shared misc folder.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/Makefile.objs        | 1 +
 hw/{input =3D> i386}/vmmouse.c | 0
 hw/input/Makefile.objs       | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/{input =3D> i386}/vmmouse.c (100%)

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 1548ad1ad0..fd279e7584 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -6,6 +6,7 @@ obj-y +=3D x86-iommu.o intel_iommu.o
 obj-y +=3D amd_iommu.o
 obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) +=3D vmport.o
+obj-$(CONFIG_VMMOUSE) +=3D vmmouse.o
=20
 obj-y +=3D kvmvapic.o
 obj-y +=3D acpi-build.o
diff --git a/hw/input/vmmouse.c b/hw/i386/vmmouse.c
similarity index 100%
rename from hw/input/vmmouse.c
rename to hw/i386/vmmouse.c
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index 7715d7230d..636f794b6b 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -6,7 +6,6 @@ common-obj-$(CONFIG_PL050) +=3D pl050.o
 common-obj-y +=3D ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) +=3D stellaris_input.o
 common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
-common-obj-$(CONFIG_VMMOUSE) +=3D vmmouse.o
=20
 common-obj-$(CONFIG_VIRTIO) +=3D virtio-input.o
 common-obj-$(CONFIG_VIRTIO) +=3D virtio-input-hid.o
--=20
2.11.0
