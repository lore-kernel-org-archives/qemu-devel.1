Received: from eggs.gnu.org ([2001:4830:134:3::10]:52356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7E2D-0002jX-Jc
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7E2A-0002Ct-9h
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7E2A-0002Bo-0d
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9P5Dxpc045554
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:15:13 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtayda643-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:15:13 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 01:15:11 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 01:14:57 -0400
In-Reply-To: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508908500-25274-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] tpm: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Commit c37cacabf22 moved tpm_cleanup() in the main loop exit, however thi=
s
function is not available when compiling with --disable-tpm.

Provides necessary stubs to keep code clean of #ifdef'fery.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20171023102903.256AF7456A0@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 MAINTAINERS         |  1 +
 Makefile.objs       |  2 +-
 stubs/Makefile.objs |  1 +
 stubs/tpm.c         | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 stubs/tpm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1217542..2650063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1544,6 +1544,7 @@ TPM
 M: Stefan Berger <stefanb@linux.vnet.ibm.com>
 S: Maintained
 F: tpm.c
+F: stubs/tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
diff --git a/Makefile.objs b/Makefile.objs
index d4f973a..285c6f3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -62,7 +62,7 @@ bt-host.o-cflags :=3D $(BLUEZ_CFLAGS)
 common-obj-y +=3D dma-helpers.o
 common-obj-y +=3D vl.o
 vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
-common-obj-y +=3D tpm.o
+common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-$(CONFIG_SLIRP) +=3D slirp/
=20
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c759479..8cfe343 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -28,6 +28,7 @@ stub-obj-y +=3D runstate-check.o
 stub-obj-y +=3D set-fd-handler.o
 stub-obj-y +=3D slirp.o
 stub-obj-y +=3D sysbus.o
+stub-obj-y +=3D tpm.o
 stub-obj-y +=3D trace-control.o
 stub-obj-y +=3D uuid.o
 stub-obj-y +=3D vm-stop.o
diff --git a/stubs/tpm.c b/stubs/tpm.c
new file mode 100644
index 0000000..c18aac1
--- /dev/null
+++ b/stubs/tpm.c
@@ -0,0 +1,33 @@
+/*
+ * TPM stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "sysemu/tpm.h"
+#include "qmp-commands.h"
+
+int tpm_init(void)
+{
+    return 0;
+}
+
+void tpm_cleanup(void)
+{
+}
+
+TPMInfoList *qmp_query_tpm(Error **errp)
+{
+    return NULL;
+}
+
+TpmTypeList *qmp_query_tpm_types(Error **errp)
+{
+    return NULL;
+}
+
+TpmModelList *qmp_query_tpm_models(Error **errp)
+{
+    return NULL;
+}
--=20
2.5.5
