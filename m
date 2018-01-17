Received: from eggs.gnu.org ([2001:4830:134:3::10]:55577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuV-0005PZ-AF
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuQ-0008TR-Dc
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuQ-0008Qt-7H
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:50 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:26 +0100
Message-Id: <1516203816-19374-15-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 14/24] sparc: cpu: add TARGET_DEFAULT_CPU_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Use default values from linux-user for TARGET_DEFAULT_CPU_TYPE.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9fde547..02c55ad 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -661,6 +661,12 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 #define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
 #define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
 
+#ifdef TARGET_SPARC64
+#define TARGET_DEFAULT_CPU_TYPE SPARC_CPU_TYPE_NAME("TI-UltraSparc-II")
+#else
+#define TARGET_DEFAULT_CPU_TYPE SPARC_CPU_TYPE_NAME("Fujitsu-MB86904")
+#endif
+
 #define cpu_signal_handler cpu_sparc_signal_handler
 #define cpu_list sparc_cpu_list
 
-- 
2.7.4
