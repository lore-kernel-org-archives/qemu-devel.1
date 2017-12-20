Received: from eggs.gnu.org ([2001:4830:134:3::10]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAF-00072w-JD
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAE-0005pu-6r
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:28:19 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:23:33 -0800
Message-ID: <1546392ef788add26efe65e71b5ddf94a86e9f85.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/29] hw/intc: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr,
"\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Acked-by: Cornelia Huck <cohuck@redhat.com> (s390x part)
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V2:
 - Split hw patch into individual directories

 hw/intc/arm_gic_kvm.c   | 12 ++++++------
 hw/intc/omap_intc.c     |  4 ++--
 hw/intc/openpic.c       |  1 +
 hw/intc/openpic_kvm.c   |  8 ++++----
 hw/intc/s390_flic_kvm.c |  4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index ae095d08a3..a5478d3e20 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -316,12 +316,12 @@ static void kvm_arm_gic_put(GICState *s)
     num_cpu =3D ((reg & 0xe0) >> 5) + 1;
=20
     if (num_irq < s->num_irq) {
-            fprintf(stderr, "Restoring %u IRQs, but kernel supports max %d=
\n",
-                    s->num_irq, num_irq);
+            error_report("Restoring %u IRQs, but kernel supports max %d",
+                         s->num_irq, num_irq);
             abort();
     } else if (num_cpu !=3D s->num_cpu) {
-            fprintf(stderr, "Restoring %u CPU interfaces, kernel only has =
%d\n",
-                    s->num_cpu, num_cpu);
+            error_report("Restoring %u CPU interfaces, kernel only has %d"=
,
+                         s->num_cpu, num_cpu);
             /* Did we not create the VCPUs in the kernel yet? */
             abort();
     }
@@ -411,8 +411,8 @@ static void kvm_arm_gic_get(GICState *s)
     s->num_cpu =3D ((reg & 0xe0) >> 5) + 1;
=20
     if (s->num_irq > GIC_MAXIRQ) {
-            fprintf(stderr, "Too many IRQs reported from the kernel: %d\n"=
,
-                    s->num_irq);
+            error_report("Too many IRQs reported from the kernel: %d",
+                         s->num_irq);
             abort();
     }
=20
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 6844c1aa83..7fc239715a 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -539,8 +539,8 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
         /* TODO: Make a bitmap (or sizeof(char)map) of access privileges
          * for every register, see Chapter 3 and 4 for privileged mode.  *=
/
         if (value & 1)
-            fprintf(stderr, "%s: protection mode enable attempt\n",
-                            __func__);
+            error_report("%s: protection mode enable attempt",
+                          __func__);
         return;
=20
     case 0x50:	/* INTC_IDLE */
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9159a06f07..aa18b392e9 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -34,6 +34,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fa83420254..60c784ae86 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -150,8 +150,8 @@ static void kvm_openpic_region_add(MemoryListener *list=
ener,
=20
     ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
-        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+        error_report("%s: %s %" PRIx64 "", __func__,
+                     strerror(errno), reg_base);
     }
 }
=20
@@ -184,8 +184,8 @@ static void kvm_openpic_region_del(MemoryListener *list=
ener,
=20
     ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
-        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+        error_report("%s: %s %" PRIx64 "", __func__,
+                     strerror(errno), reg_base);
     }
 }
=20
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index d208cb81c4..e710bfdcda 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -83,7 +83,7 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
     rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
-        fprintf(stderr, "flic: couldn't enable pfault\n");
+        error_report("flic: couldn't enable pfault");
     }
 }
=20
@@ -97,7 +97,7 @@ static void flic_disable_wait_pfault(KVMS390FLICState *fl=
ic)
     rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
-        fprintf(stderr, "flic: couldn't disable pfault\n");
+        error_report("flic: couldn't disable pfault");
     }
 }
=20
--=20
2.14.1
