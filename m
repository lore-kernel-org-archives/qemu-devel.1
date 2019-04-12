Received: from eggs.gnu.org ([209.51.188.92]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEy4X-0003Td-R6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEy4W-0004Ps-Vc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:26:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 17:26:19 +0200
Message-Id: <20190412152619.23542-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800 and
 n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com

These machines depend on the deprecated bluetooth subsystem. In case we
finally decide to remove the bluetooth subsystem, we likely need to
remove the n800 and n810 machines, too, so mark them now as deprecated.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/nseries.c     | 3 +++
 qemu-deprecated.texi | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d..66e50b850c 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1309,6 +1309,9 @@ static void n8x0_init(MachineState *machine,
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
     int sdram_size =3D binfo->ram_size;
=20
+    warn_report("The n800 and n810 machines are deprecated. Please use a=
 "
+                "different Arm machine instead.");
+
     s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
=20
     /* Setup peripherals
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2219386769..4de7452fac 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -145,6 +145,12 @@ This machine type uses an unmaintained firmware, bro=
ken in lots of ways,
 and unable to start post-2004 operating systems. 40p machine type should=
 be
 used instead.
=20
+@subsection n800 and n810 (Arm) (since 4.1)
+
+These machines depend on the deprecated bluetooth subsystem. When the
+bluetooth subsystem will be removed, the n800 and n810 machines will be
+deleted, too. If possible, use a different Arm board instead.
+
 @section Device options
=20
 @subsection Block device options
--=20
2.21.0
