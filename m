Received: from eggs.gnu.org ([2001:4830:134:3::10]:55215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu9-000509-MM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu5-0007xU-03
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpu4-0007wk-Qd
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:28 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:16 +0100
Message-Id: <1516203816-19374-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 04/24] lm32: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model).
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

LM32 however doesn't have working default in *-user targets
which defaults to catch all 'any'. So I arbitraraly picked
'lm32-basic' cpu model to serve as the default.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Michael Walle <michael@walle.cc>
---
 target/lm32/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 2279594..65f58f5 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -259,6 +259,7 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 
 #define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
 #define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE LM32_CPU_TYPE_NAME("lm32-basic")
 
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
-- 
2.7.4
