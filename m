Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuH-000595-DU
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuB-00087P-Tg
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuB-00085f-Nm
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:35 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:15 +0100
Message-Id: <1516203816-19374-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 03/24] cris: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

With the later in mind set it to 'crisv32', which is
what cris_cpu_class_by_name() returns if user provided
"any" cpu_model including default that *-user targets
set in catch all in case of Cris.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
---
 target/cris/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index b64fa35..8feabb4 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -271,6 +271,7 @@ enum {
 
 #define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
 #define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
+#define TARGET_DEFAULT_CPU_TYPE CRIS_CPU_TYPE_NAME("crisv32")
 
 #define cpu_signal_handler cpu_cris_signal_handler
 
-- 
2.7.4
