Received: from eggs.gnu.org ([2001:4830:134:3::10]:55222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu9-00050Q-Tl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu5-0007xp-Em
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpu5-0007x9-8l
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:14 +0100
Message-Id: <1516203816-19374-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 02/24] alpha: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

With the later in mind set it to 'ev67', which is
what alpha_cpu_class_by_name() returns if user provided
a garbage (including default "any" cpu_model that *-user
targets set in catch all) in case of Alpha.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
---
 target/alpha/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 0a9ad35..c8dd560 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -472,6 +472,7 @@ void alpha_translate_init(void);
 
 #define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE ALPHA_CPU_TYPE_NAME("ev67")
 
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
-- 
2.7.4
