Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxzh-0006Zw-OD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxzf-0007BI-Hi
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Jul 2018 08:43:47 +0200
Message-Id: <20180705064348.3162-2-kraxel@redhat.com>
In-Reply-To: <20180705064348.3162-1-kraxel@redhat.com>
References: <20180705064348.3162-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] vga: set default_display for all
 machines using cirrus.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>, Gerd Hoffmann <kraxel@redhat.com>

Explicitly set MachineClass->default_display to "cirrus" for all machine
types (alpha, mips, old i386 versions) which use cirrus today, so they
don't depend on cirrus being the default display device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/alpha/dp264.c     | 1 +
 hw/i386/pc_piix.c    | 2 +-
 hw/mips/mips_malta.c | 1 +
 hw/mips/mips_r4k.c   | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 80b987f7fb..668e6d099f 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -182,6 +182,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->is_default = 1;
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
+    mc->default_display = "cirrus";
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..bcf866ee34 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -566,7 +566,7 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_2_machine_options(m);
     m->hw_version = "2.1.0";
-    m->default_display = NULL;
+    m->default_display = "cirrus";
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_1);
     pcmc->smbios_uuid_encoded = false;
     pcmc->enforce_aligned_dimm = false;
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 3467451482..998971c53a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1242,6 +1242,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 16;
     mc->is_default = 1;
+    mc->default_display = "cirrus";
 #ifdef TARGET_MIPS64
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
 #else
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index d5725d0555..c4c7ee8aa5 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -295,6 +295,7 @@ static void mips_machine_init(MachineClass *mc)
     mc->desc = "mips r4k platform";
     mc->init = mips_r4k_init;
     mc->block_default_type = IF_IDE;
+    mc->default_display = "cirrus";
 #ifdef TARGET_MIPS64
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
 #else
-- 
2.9.3
