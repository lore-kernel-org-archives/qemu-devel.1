Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DaH-0005zE-J5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DaE-00028h-45
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:13 -0400
Received: from mail-by2nam03on0070.outbound.protection.outlook.com
	([104.47.42.70]:44096
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e5DaD-00028F-Mi
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:10 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 19 Oct 2017 09:17:59 -0700
Message-ID: <106b49578902e1e7ec8a05c3b638f02cd95737ca.1508390588.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508390588.git.alistair.francis@xilinx.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/46] hw/sparc*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

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
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V2:
 - Split hw patch into individual directories

 hw/sparc/leon3.c     | 16 +++++++---------
 hw/sparc/sun4m.c     | 16 +++++++---------
 hw/sparc64/niagara.c |  4 ++--
 hw/sparc64/sun4u.c   | 10 +++++-----
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816bf94..b69d69c515 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -144,9 +145,8 @@ static void leon3_generic_hw_init(MachineState *machine=
)
=20
     /* Allocate RAM */
     if ((uint64_t)ram_size > (1UL << 30)) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d, maximum 1G\n"=
,
-                (unsigned int)(ram_size / (1024 * 1024)));
+        error_report("Too much memory for this machine: %d, maximum 1G",
+                     (unsigned int)(ram_size / (1024 * 1024)));
         exit(1);
     }
=20
@@ -172,19 +172,18 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
     }
=20
     if (bios_size > prom_size) {
-        fprintf(stderr, "qemu: could not load prom '%s': file too big\n",
-                filename);
+        error_report("could not load prom '%s': file too big", filename);
         exit(1);
     }
=20
     if (bios_size > 0) {
         ret =3D load_image_targphys(filename, 0x00000000, bios_size);
         if (ret < 0 || ret > prom_size) {
-            fprintf(stderr, "qemu: could not load prom '%s'\n", filename);
+            error_report("could not load prom '%s'", filename);
             exit(1);
         }
     } else if (kernel_filename =3D=3D NULL && !qtest_enabled()) {
-        fprintf(stderr, "Can't read bios image %s\n", filename);
+        error_report("Can't read bios image %s", filename);
         exit(1);
     }
     g_free(filename);
@@ -197,8 +196,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, &entry, NULL=
, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         if (bios_size <=3D 0) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e1bdd4828d..1ce0b0a407 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -261,8 +261,7 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               KERNEL_LOAD_ADDR,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
=20
@@ -273,8 +272,8 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               INITRD_LOAD_ADDR,
                                               RAM_size - INITRD_LOAD_ADDR)=
;
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -688,7 +687,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("could not load prom '%s'", bios_name);
         exit(1);
     }
 }
@@ -754,10 +753,9 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size,
=20
     /* allocate RAM */
     if ((uint64_t)RAM_size > max_mem) {
-        fprintf(stderr,
-                "qemu: Too much memory for this machine: %d, maximum %d\n"=
,
-                (unsigned int)(RAM_size / (1024 * 1024)),
-                (unsigned int)(max_mem / (1024 * 1024)));
+        error_report("Too much memory for this machine: %d, maximum %d",
+                     (unsigned int)(RAM_size / (1024 * 1024)),
+                     (unsigned int)(max_mem / (1024 * 1024)));
         exit(1);
     }
     dev =3D qdev_create(NULL, "memory");
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 9a8d6109d4..b267b2dbda 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -153,8 +153,8 @@ static void niagara_init(MachineState *machine)
             dinfo->is_default =3D 1;
             rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, =
-1);
         } else {
-            fprintf(stderr, "qemu: could not load ram disk '%s'\n",
-                    blk_bs(blk)->filename);
+            error_report("could not load ram disk '%s'",
+                         blk_bs(blk)->filename);
             exit(1);
         }
     }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8282651aeb..780c695cf9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -165,8 +166,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         }
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         /* load initrd above kernel */
@@ -178,8 +178,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                                *initrd_addr,
                                                RAM_size - *initrd_addr);
             if ((int)*initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -326,7 +326,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("could not load prom '%s'", bios_name);
         exit(1);
     }
 }
--=20
2.11.0
