Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorwG-0003fa-MO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorwB-0003x3-HH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dorwB-0003vm-Bm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:15 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  4 Sep 2017 16:00:59 +0200
Message-Id: <1504533662-198084-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] cpu: rename cpu_parse_features() to
 cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>

function not just parses features but also converts CPU model
name to CPU type, rename it to reflect what it actualy does.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qom/cpu.h | 4 ++--
 qom/cpu.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 392ae75..a718daf 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -643,7 +643,7 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
 CPUState *cpu_create(const char *typename);
 
 /**
- * cpu_parse_features:
+ * cpu_parse_cpu_model:
  * @typename: The CPU base type or CPU type.
  * @cpu_model: The model string including optional parameters.
  *
@@ -652,7 +652,7 @@ CPUState *cpu_create(const char *typename);
  * Returns: type of CPU to create or prints error and terminates process
  *          if an error occurred.
  */
-const char *cpu_parse_features(const char *typename, const char *cpu_model);
+const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model);
 
 /**
  * cpu_generic_init:
diff --git a/qom/cpu.c b/qom/cpu.c
index 307d638..199ad57 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -66,7 +66,7 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-const char *cpu_parse_features(const char *typename, const char *cpu_model)
+const char *cpu_parse_cpu_model(const char *typename, const char *cpu_model)
 {
     ObjectClass *oc;
     CPUClass *cc;
@@ -99,7 +99,7 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
     /* TODO: all callers of cpu_generic_init() need to be converted to
      * call cpu_parse_features() only once, before calling cpu_generic_init().
      */
-    const char *cpu_type = cpu_parse_features(typename, cpu_model);
+    const char *cpu_type = cpu_parse_cpu_model(typename, cpu_model);
 
     assert(cpu_type);
     return cpu_create(cpu_type);
-- 
2.7.4
