Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5Vu-0004Yz-Mt
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5Vr-0005h5-KB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:14 -0400
Received: from mail-co1nam03on0041.outbound.protection.outlook.com
	([104.47.40.41]:23447
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dy5Vr-0005g4-D1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:11 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:16:12 -0700
Message-ID: <cb22f944e30ac70b6c6659e7ea7554f49d58b058.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 24/47] hw/mips: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
List-ID: <qemu-devel.nongnu.org>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
---
V2:
 - Split hw patch into individual directories

 hw/mips/boston.c        | 4 ++--
 hw/mips/mips_fulong2e.c | 4 ++--
 hw/mips/mips_jazz.c     | 4 ++--
 hw/mips/mips_malta.c    | 4 ++--
 hw/mips/mips_mipssim.c  | 4 ++--
 hw/mips/mips_r4k.c      | 6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 776ee283e1..ee82968ea7 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -353,7 +353,7 @@ static const void *boston_fdt_filter(void *opaque, cons=
t void *fdt_orig,
=20
     err =3D fdt_open_into(fdt_orig, fdt, fdt_sz);
     if (err) {
-        fprintf(stderr, "unable to open FDT\n");
+        error_report("unable to open FDT");
         return NULL;
     }
=20
@@ -361,7 +361,7 @@ static const void *boston_fdt_filter(void *opaque, cons=
t void *fdt_orig,
             ? machine->kernel_cmdline : " ";
     err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     if (err < 0) {
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
         return NULL;
     }
=20
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 75318680e1..34710a466c 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -143,7 +143,7 @@ static int64_t load_kernel (CPUMIPSState *env)
                                      initrd_offset, ram_size - initrd_offs=
et);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
+            error_report("qemu: could not load initial ram disk '%s'",
                     loaderparams.initrd_filename);
             exit(1);
         }
@@ -342,7 +342,7 @@ static void mips_fulong2e_init(MachineState *machine)
=20
     isa_bus =3D vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0));
     if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
+        error_report("vt82c686b_init error");
         exit(1);
     }
=20
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7e6626dc88..6c91a940be 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -271,10 +271,10 @@ static void mips_jazz_init(MachineState *machine,
             sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
             break;
         } else if (is_help_option(nd->model)) {
-            fprintf(stderr, "qemu: Supported NICs: dp83932\n");
+            error_report("qemu: Supported NICs: dp83932");
             exit(1);
         } else {
-            fprintf(stderr, "qemu: Unsupported NIC: %s\n", nd->model);
+            error_report("qemu: Unsupported NIC: %s", nd->model);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bcf89..d457adfa69 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -856,8 +856,8 @@ static int64_t load_kernel (void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index a092072e2a..a3d9406610 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -101,8 +101,8 @@ static int64_t load_kernel(void)
                 initrd_offset, loaderparams.ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4ef9d..e54ce918a7 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -121,8 +121,8 @@ static int64_t load_kernel(void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -246,7 +246,7 @@ void mips_r4k_init(MachineState *machine)
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_len, mips_rom / sector_len,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory.\n");
+            error_report("qemu: Error registering flash memory.");
 	}
     } else if (!qtest_enabled()) {
         /* not fatal */
--=20
2.11.0
