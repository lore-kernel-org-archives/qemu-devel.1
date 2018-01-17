Received: from eggs.gnu.org ([2001:4830:134:3::10]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuC-00053D-Tb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuC-00088F-7Z
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuC-00086E-1j
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:36 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:22 +0100
Message-Id: <1516203816-19374-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 10/24] openrisc: cpu: add
 TARGET_DEFAULT_CPU_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Take default type from linux-user and use it as
TARGET_DEFAULT_CPU_TYPE, which should work for *-user targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index cc22dc8..8d1a87e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -394,6 +394,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE OPENRISC_CPU_TYPE_NAME("or1200")
 
 #include "exec/cpu-all.h"
 
-- 
2.7.4
