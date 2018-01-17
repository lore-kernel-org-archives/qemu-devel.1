Received: from eggs.gnu.org ([2001:4830:134:3::10]:55330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuF-00055z-9G
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuE-0008AP-IS
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuE-00089h-CH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:38 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:20 +0100
Message-Id: <1516203816-19374-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 08/24] moxie: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

With the later in mind set it to 'any', which is current
default for target.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Anthony Green <green@moxielogic.com>
---
 target/moxie/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index d37e6a5..9fabb93 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -124,6 +124,7 @@ int cpu_moxie_signal_handler(int host_signum, void *pinfo,
 
 #define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
 #define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE MOXIE_CPU_TYPE_NAME("any")
 
 #define cpu_signal_handler cpu_moxie_signal_handler
 
-- 
2.7.4
