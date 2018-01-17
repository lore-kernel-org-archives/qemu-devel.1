Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuX-0005Ra-5Y
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuW-00008Q-AL
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuW-00007w-5H
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:56 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:31 +0100
Message-Id: <1516203816-19374-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 19/24] tilegx: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

It will be used to drop a bunch of ifdefs *-user/main.c that
set default cpu_model in favor of using type names directly.

For tilegx, *-user defaulted to bogus 'any', however
tilegx_cpu_class_by_name() is ignoring invalid values and always
returns TYPE_TILEGX_CPU, so use it for TARGET_DEFAULT_CPU_TYPE

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 target/tilegx/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 71cea04..67de53e 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -165,6 +165,7 @@ void tilegx_tcg_init(void);
 int cpu_tilegx_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_TILEGX_CPU, cpu_model)
+#define TARGET_DEFAULT_CPU_TYPE TYPE_TILEGX_CPU
 
 #define cpu_signal_handler cpu_tilegx_signal_handler
 
-- 
2.7.4
