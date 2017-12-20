Received: from eggs.gnu.org ([2001:4830:134:3::10]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAg-0007S8-3O
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAe-0006f6-4l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:46 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:24:07 -0800
Message-ID: <3bdb3868489a26cef25bccf2cd19f065141a1060.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 14/29] hw/mips: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org
---
V2:
 - Split hw patch into individual directories

 hw/mips/boston.c        |  4 ++--
 hw/mips/mips_fulong2e.c | 13 ++++++-------
 hw/mips/mips_jazz.c     |  4 ++--
 hw/mips/mips_malta.c    | 16 +++++++---------
 hw/mips/mips_mipssim.c  | 11 +++++------
 hw/mips/mips_r4k.c      | 18 ++++++++----------
 6 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1cb4b6aca2..d91a477191 100644
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
index 725e25a134..f68c625666 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -120,7 +120,7 @@ static int64_t load_kernel (CPUMIPSState *env)
                            (uint64_t *)&kernel_low, (uint64_t *)&kernel_hi=
gh,
                            0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -134,17 +134,16 @@ static int64_t load_kernel (CPUMIPSState *env)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD_P=
AGE_MASK;
             if (initrd_offset + initrd_size > ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s'\=
n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_filena=
me,
                                      initrd_offset, ram_size - initrd_offs=
et);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -338,7 +337,7 @@ static void mips_fulong2e_init(MachineState *machine)
=20
     isa_bus =3D vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0));
     if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
+        error_report("vt82c686b_init error");
         exit(1);
     }
=20
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 0d2c0683ba..596f3c210e 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -268,10 +268,10 @@ static void mips_jazz_init(MachineState *machine,
             sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
             break;
         } else if (is_help_option(nd->model)) {
-            fprintf(stderr, "qemu: Supported NICs: dp83932\n");
+            error_report("Supported NICs: dp83932");
             exit(1);
         } else {
-            fprintf(stderr, "qemu: Unsupported NIC: %s\n", nd->model);
+            error_report("Unsupported NIC: %s", nd->model);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37f19428d6..7ca8ba2086 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -812,7 +812,7 @@ static int64_t load_kernel (void)
                            NULL, (uint64_t *)&kernel_entry, NULL,
                            (uint64_t *)&kernel_high, big_endian, EM_MIPS, =
1, 0);
     if (kernel_size < 0) {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -846,9 +846,8 @@ static int64_t load_kernel (void)
             initrd_offset =3D (loaderparams.ram_low_size - initrd_size - 1=
31072
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
             if (kernel_high >=3D initrd_offset) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s'\=
n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_filena=
me,
@@ -856,8 +855,8 @@ static int64_t load_kernel (void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -1034,9 +1033,8 @@ void mips_malta_init(MachineState *machine)
=20
     /* allocate RAM */
     if (ram_size > (2048u << 20)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d MB, maximum 20=
48 MB\n",
-                ((unsigned int)ram_size / (1 << 20)));
+        error_report("Too much memory for this machine: %dMB, maximum 2048=
MB",
+                     ((unsigned int)ram_size / (1 << 20)));
         exit(1);
     }
=20
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index e5d3654586..e0ba5efc84 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -78,7 +78,7 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -92,17 +92,16 @@ static int64_t load_kernel(void)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD_P=
AGE_MASK;
             if (initrd_offset + initrd_size > loaderparams.ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s'\=
n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_filena=
me,
                 initrd_offset, loaderparams.ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 244bd41813..4c17e32559 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -98,7 +98,7 @@ static int64_t load_kernel(void)
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000)
             entry =3D (int32_t)entry;
     } else {
-        error_report("qemu: could not load kernel '%s': %s",
+        error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
@@ -112,9 +112,8 @@ static int64_t load_kernel(void)
         if (initrd_size > 0) {
             initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) & INITRD_P=
AGE_MASK;
             if (initrd_offset + initrd_size > ram_size) {
-                fprintf(stderr,
-                        "qemu: memory too small for initial ram disk '%s'\=
n",
-                        loaderparams.initrd_filename);
+                error_report("memory too small for initial ram disk '%s'",
+                             loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size =3D load_image_targphys(loaderparams.initrd_filena=
me,
@@ -122,8 +121,8 @@ static int64_t load_kernel(void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -196,9 +195,8 @@ void mips_r4k_init(MachineState *machine)
=20
     /* allocate RAM */
     if (ram_size > (256 << 20)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d MB, maximum 25=
6 MB\n",
-                ((unsigned int)ram_size / (1 << 20)));
+        error_report("Too much memory for this machine: %dMB, maximum 256M=
B",
+                     ((unsigned int)ram_size / (1 << 20)));
         exit(1);
     }
     memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_si=
ze);
@@ -239,7 +237,7 @@ void mips_r4k_init(MachineState *machine)
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_len, mips_rom / sector_len,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory.\n");
+            error_report("Error registering flash memory.");
 	}
     } else if (!qtest_enabled()) {
         /* not fatal */
--=20
2.14.1
