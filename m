Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dW5Cd-00044Z-BP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dW5Ca-00060p-6F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dW5Ca-00060U-0P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 085DBC0C4282
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 18:20:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 14 Jul 2017 20:20:06 +0200
Message-Id: <20170714182012.4595-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170714182012.4595-1-marcandre.lureau@redhat.com>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/8] stubs: add vmcoreinfo_get() stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Common dump code may call vmcoreinfo_get() which is not available on
all targets.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 stubs/vmcoreinfo.c  | 9 +++++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 stubs/vmcoreinfo.c

diff --git a/stubs/vmcoreinfo.c b/stubs/vmcoreinfo.c
new file mode 100644
index 0000000000..a994153832
--- /dev/null
+++ b/stubs/vmcoreinfo.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+
+#include "hw/acpi/vmcoreinfo.h"
+
+bool vmcoreinfo_get(VMCoreInfoState *vis, uint64_t *paddr, uint32_t *siz=
e,
+                    Error **errp)
+{
+    return false;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bfd74..3bedc73252 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -36,6 +36,7 @@ stub-obj-y +=3D qmp_pc_dimm_device_list.o
 stub-obj-y +=3D target-monitor-defs.o
 stub-obj-y +=3D target-get-monitor-def.o
 stub-obj-y +=3D pc_madt_cpu_entry.o
+stub-obj-y +=3D vmcoreinfo.o
 stub-obj-y +=3D vmgenid.o
 stub-obj-y +=3D xen-common.o
 stub-obj-y +=3D xen-hvm.o
--=20
2.13.1.395.gf7b71de06
