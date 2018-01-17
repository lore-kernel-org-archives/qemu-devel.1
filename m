Received: from eggs.gnu.org ([2001:4830:134:3::10]:55223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu9-00050S-U0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu6-0007zD-Ju
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpu6-0007yA-Cf
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:30 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:18 +0100
Message-Id: <1516203816-19374-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 06/24] microblaze: cpu: add
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
Cc: Laurent Vivier <laurent@vivier.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

For the later default is set to bogus 'any', and mb_cpu_class_by_name()
always returns TYPE_MICROBLAZE_CPU class regardless of cpu_model
value. So use this type for default.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
---
 target/microblaze/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 52b6b6a..f244efa 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -344,6 +344,7 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
+#define TARGET_DEFAULT_CPU_TYPE TYPE_MICROBLAZE_CPU
 
 #define cpu_signal_handler cpu_mb_signal_handler
 
-- 
2.7.4
