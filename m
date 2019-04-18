Received: from eggs.gnu.org ([209.51.188.92]:57184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGyEd-0000wp-Kp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGyEc-0007lg-6M
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGyEa-0007hh-3C
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:01:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Apr 2019 01:01:03 -0300
Message-Id: <20190418040103.15314-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

hppa_cpu_list() is dead code and is never called.  Delete it.

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/hppa/cpu.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..b3b1826209 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 }
 
-static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CPUListState *s = user_data;
-
-    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
-}
-
-void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
-{
-    CPUListState s = {
-        .file = f,
-        .cpu_fprintf = cpu_fprintf,
-    };
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
-    (*cpu_fprintf)(f, "Available CPUs:\n");
-    g_slist_foreach(list, hppa_cpu_list_entry, &s);
-    g_slist_free(list);
-}
-
 static void hppa_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
-- 
2.18.0.rc1.1.g3f1ff2140
