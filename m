Received: from eggs.gnu.org ([2001:4830:134:3::10]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1N-0001Pk-So
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1I-0004gf-Qr
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1I-0004fd-KN
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35D034075171
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E98DF1008596
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:39:56 +0100
Message-Id: <20180207124009.12376-8-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/20] Include qmp-commands.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-7-armbru@redhat.com>
---
 block.c                    | 1 -
 blockjob.c                 | 1 -
 hw/acpi/acpi-stub.c        | 1 -
 hw/ppc/spapr.c             | 1 -
 hw/s390x/s390-stattrib.c   | 1 -
 hw/smbios/smbios-stub.c    | 1 -
 hw/xen/xen-common.c        | 1 -
 include/sysemu/arch_init.h | 1 -
 qga/guest-agent-core.h     | 2 +-
 qga/main.c                 | 1 +
 stubs/dump.c               | 1 -
 ui/cocoa.m                 | 1 -
 12 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 2a8bc276c7..a97f709252 100644
--- a/block.c
+++ b/block.c
@@ -39,7 +39,6 @@
 #include "qemu/notify.h"
 #include "qemu/coroutine.h"
 #include "block/qapi.h"
-#include "qmp-commands.h"
 #include "qemu/timer.h"
 #include "qapi-event.h"
 #include "qemu/cutils.h"
diff --git a/blockjob.c b/blockjob.c
index d766fdc4ce..081f1d2b91 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -34,7 +34,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
-#include "qmp-commands.h"
 #include "qemu/timer.h"
 #include "qapi-event.h"
=20
diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index 7dfc8af316..4c9d081ed4 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qmp-commands.h"
 #include "hw/acpi/acpi.h"
=20
 void acpi_table_add(const QemuOpts *opts, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876be56..659be6b746 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,7 +74,6 @@
 #include "hw/compat.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "qmp-commands.h"
=20
 #include <libfdt.h>
=20
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 2902f54f11..c6c06b2780 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "cpu.h"
-#include "qmp-commands.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/s390x/storage-attributes.h"
diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
index 61becef4ae..d3a385441a 100644
--- a/hw/smbios/smbios-stub.c
+++ b/hw/smbios/smbios-stub.c
@@ -23,7 +23,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qmp-commands.h"
 #include "hw/smbios/smbios.h"
=20
 void smbios_entry_add(QemuOpts *opts, Error **errp)
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 632a938dcc..78c18f34a7 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -10,7 +10,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/xen/xen_backend.h"
-#include "qmp-commands.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
 #include "migration/misc.h"
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index f999bfd3be..4b88f99060 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
=20
-#include "qmp-commands.h"
 #include "qemu/option.h"
=20
 enum {
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 3e8a4acff2..6f4d214cb9 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -12,7 +12,7 @@
  */
 #include "qapi/qmp/dispatch.h"
 #include "qemu-common.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-types.h"
=20
 #define QGA_READ_COUNT_DEFAULT 4096
=20
diff --git a/qga/main.c b/qga/main.c
index 57083ca10c..804cc4c1a0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -23,6 +23,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
+#include "qga-qmp-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
diff --git a/stubs/dump.c b/stubs/dump.c
index d9ee23f1eb..8e5032c3af 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/dump-arch.h"
-#include "qmp-commands.h"
=20
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks=
)
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 6be9848391..19e1e827d2 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -31,7 +31,6 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
-#include "qmp-commands.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
 #include <Carbon/Carbon.h>
--=20
2.13.6
