Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLw-0005I6-RN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLt-0004dk-HF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLr-0004YC-Fn
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:47 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:10 -0200
Message-Id: <20181211180129.7661-6-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/24] Deprecate HMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

Since we're deprecating the QMP `cpu-add`, let's deprecate its HMP
equivalent, too.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181030123526.26415-3-kchamart@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hmp.c           | 2 ++
 hmp-commands.hx | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7828f93a39..43ae9ec61a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2372,6 +2372,8 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict)
     int cpuid;
     Error *err = NULL;
 
+    error_report("cpu_add is deprecated, please use device_add instead");
+
     cpuid = qdict_get_int(qdict, "id");
     qmp_cpu_add(cpuid, &err);
     hmp_handle_error(mon, &err);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index db0c681f74..ba71558c25 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1849,14 +1849,16 @@ ETEXI
         .name       = "cpu-add",
         .args_type  = "id:i",
         .params     = "id",
-        .help       = "add cpu",
+        .help       = "add cpu (deprecated, use device_add instead)",
         .cmd        = hmp_cpu_add,
     },
 
 STEXI
 @item cpu-add @var{id}
 @findex cpu-add
-Add CPU with id @var{id}
+Add CPU with id @var{id}.  This command is deprecated, please
++use @code{device_add} instead. For details, refer to
+'docs/cpu-hotplug.rst'.
 ETEXI
 
     {
-- 
2.18.0.rc1.1.g3f1ff2140
