Received: from eggs.gnu.org ([2001:4830:134:3::10]:52266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95yz-00028M-4i
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95yw-0006sA-0O
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:03:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60706
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e95yv-0006s0-Qv
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:03:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9U93a4Y113433
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:36 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dx0vrgpxb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:03:27 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 09:03:25 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 10:03:17 +0100
In-Reply-To: <20171030090320.93625-1-borntraeger@de.ibm.com>
References: <20171030090320.93625-1-borntraeger@de.ibm.com>
Message-Id: <20171030090320.93625-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 1/4] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: David Hildenbrand <david@redhat.com>

For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
and the CPU model qmp interfaces didn't care about the actual type,
as that information was hidden.

This changed with CPU hotplug via device_add. Now the type is visible to
the user. Before we get that supported in a stable version, this is our
last chance to change it.

So change it from "s390-cpu" to "s390x-cpu", to match the architecture
name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171020115803.14093-1-david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 qapi-schema.json          | 4 ++--
 target/s390x/cpu-qom.h    | 2 +-
 target/s390x/cpu_models.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index a9dd043..1845795 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3159,12 +3159,12 @@
 # -> { "execute": "query-hotpluggable-cpus" }
 # <- {"return": [
 #      {
-#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
 #         "props": { "core-id": 1 }
 #      },
 #      {
 #         "qom-path": "/machine/unattached/device[0]",
-#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
 #         "props": { "core-id": 0 }
 #      }
 #    ]}
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 0510c49..b46217d 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -22,7 +22,7 @@
 
 #include "qom/cpu.h"
 
-#define TYPE_S390_CPU "s390-cpu"
+#define TYPE_S390_CPU "s390x-cpu"
 
 #define S390_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(S390CPUClass, (klass), TYPE_S390_CPU)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 9554f19..c4c37b3 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -286,7 +286,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
         details = "(migration-safe)";
     }
 
-    /* strip off the -s390-cpu */
+    /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s %s\n", name, scc->desc,
                       details);
@@ -390,7 +390,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     char *name = g_strdup(object_class_get_name(klass));
     S390CPUClass *scc = S390_CPU_CLASS(klass);
 
-    /* strip off the -s390-cpu */
+    /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     info = g_new0(CpuDefinitionInfo, 1);
     info->name = name;
-- 
2.9.4
