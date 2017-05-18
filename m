Received: from eggs.gnu.org ([2001:4830:134:3::10]:57494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBl-0000pp-QB
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBg-0006vA-TC
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPBg-0006uv-K4
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C56315552
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:34 +0200
Message-Id: <20170518172543.32694-3-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/11] migration: Remove unneeded includes of
 migration/vmstate.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/core/qdev.c                   | 1 -
 include/hw/acpi/memory_hotplug.h | 1 -
 include/hw/acpi/pcihp.h          | 1 -
 include/hw/pci/shpc.h            | 1 -
 include/net/net.h                | 1 -
 target/alpha/cpu.c               | 1 -
 target/hppa/cpu.c                | 1 -
 target/s390x/cpu.c               | 1 -
 target/tilegx/cpu.c              | 1 -
 9 files changed, 9 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 71ff95f..0ce45a2 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -37,7 +37,6 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "qapi-event.h"
-#include "migration/vmstate.h"
=20
 bool qdev_hotplug =3D false;
 static bool qdev_hot_added =3D false;
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_ho=
tplug.h
index db8ebc9..77c6576 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -3,7 +3,6 @@
=20
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
-#include "migration/vmstate.h"
 #include "hw/acpi/aml-build.h"
=20
 /**
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 04528b7..8a65f99 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -28,7 +28,6 @@
 #define HW_ACPI_PCIHP_H
=20
 #include "hw/acpi/acpi.h"
-#include "migration/vmstate.h"
 #include "hw/hotplug.h"
=20
 #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index b208554..71e836b 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -3,7 +3,6 @@
=20
 #include "qemu-common.h"
 #include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "hw/hotplug.h"
 #include "hw/pci/pci.h"
=20
diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..ba663bd 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -6,7 +6,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu/option.h"
 #include "net/queue.h"
-#include "migration/vmstate.h"
 #include "qapi-types.h"
=20
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b4f9798..8186c9d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu-common.h"
-#include "migration/vmstate.h"
 #include "exec/exec-all.h"
=20
=20
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1d791d0..30299e9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -22,7 +22,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu-common.h"
-#include "migration/vmstate.h"
 #include "exec/exec-all.h"
=20
=20
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a1bf2ba..e820e63 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -32,7 +32,6 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/visitor.h"
-#include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index d90e38e..4532639 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "linux-user/syscall_defs.h"
 #include "exec/exec-all.h"
=20
--=20
2.9.3
