Received: from eggs.gnu.org ([2001:4830:134:3::10]:47212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywii-0002QT-Vf
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywih-0006Gz-UD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywih-0006Gh-OP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:11 +0200
Message-Id: <1506935300-132598-30-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 29/38] sparc: cleanup cpu type name composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
List-ID: <qemu-devel.nongnu.org>

introduce SPARC_CPU_TYPE_NAME macro and use it to
construct cpu type names.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
macro will also be used in follow up patches to define
default cpu types per board

CC: mark.cave-ayland@ilande.co.uk
CC: atar4qemu@gmail.com
---
 target/sparc/cpu.h | 3 +++
 target/sparc/cpu.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 1598f65..7aa45c9 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -658,6 +658,9 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
 #endif
 
+#define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
+#define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_sparc_signal_handler
 #define cpu_list sparc_cpu_list
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index beab90f..f09ba50 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -712,7 +712,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
 
 static char *sparc_cpu_type_name(const char *cpu_model)
 {
-    char *name = g_strdup_printf("%s-" TYPE_SPARC_CPU, cpu_model);
+    char *name = g_strdup_printf(SPARC_CPU_TYPE_NAME("%s"), cpu_model);
     char *s = name;
 
     /* SPARC cpu model names happen to have whitespaces,
-- 
2.7.4
