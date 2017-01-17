Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSx-0003s8-9T
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSv-0001Ar-B8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTZSv-0001AQ-29
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:45 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39523C04B30E
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:30:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 17:30:32 -0200
Message-Id: <20170117193033.23178-3-ehabkost@redhat.com>
In-Reply-To: <20170117193033.23178-1-ehabkost@redhat.com>
References: <20170117193033.23178-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] stubs: acpi_table_add() stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Create a stub to avoid an #ifdef in do_acpitable_option().

The stub should never be called because -acpitable is defined as
arch-specific in qemu-options.hx.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch_init.c         | 2 --
 stubs/acpi.c        | 7 +++++++
 stubs/Makefile.objs | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 stubs/acpi.c

diff --git a/arch_init.c b/arch_init.c
index 9647c8d337..0416d84211 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -237,7 +237,6 @@ void audio_init(void)
 
 void do_acpitable_option(const QemuOpts *opts)
 {
-#ifdef TARGET_I386
     Error *err = NULL;
 
     acpi_table_add(opts, &err);
@@ -245,7 +244,6 @@ void do_acpitable_option(const QemuOpts *opts)
         error_reportf_err(err, "Wrong acpi table provided: ");
         exit(1);
     }
-#endif
 }
 
 int kvm_available(void)
diff --git a/stubs/acpi.c b/stubs/acpi.c
new file mode 100644
index 0000000000..65ef2d7086
--- /dev/null
+++ b/stubs/acpi.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi.h"
+
+void acpi_table_add(const QemuOpts *opts, Error **errp)
+{
+    abort(); /* must never be called */
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 83ddcad3c3..18236935d5 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -51,3 +51,4 @@ stub-obj-y += ipmi.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
 stub-obj-y += smbios.o
+stub-obj-y += acpi.o
-- 
2.11.0.259.g40922b1
