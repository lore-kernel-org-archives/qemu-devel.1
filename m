Received: from eggs.gnu.org ([2001:4830:134:3::10]:36136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ8K-0000FM-HJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ8J-0000Cc-GK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fkQ8J-0000CK-8y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id d17-v6so4284828pgv.10
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:35:55 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 31 Jul 2018 01:35:24 -0700
Message-Id: <1533026124-6740-4-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] hmp: add hmp for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           |  6 ++++++
 hmp.h           |  1 +
 3 files changed, 21 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 91dfe51c37..9d54ecbe4e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1042,6 +1042,20 @@ Set maximum speed to @var{value} (in bytes) for migrations.
 ETEXI
 
     {
+        .name       = "migrate_set_max_cpu_throttle",
+        .args_type  = "value:i",
+        .params     = "value",
+        .help       = "set maximum cpu throttle  for migrations.",
+        .cmd        = hmp_migrate_set_max_cpu_throttle,
+    },
+
+STEXI
+@item hmp_migrate_set_max_cpu_throttle @var{value}
+@findex migrate_set_max_cpu_throttle
+Set maximum cpu throttle to @var{value}  for migrations.
+ETEXI
+
+    {
         .name       = "migrate_set_downtime",
         .args_type  = "value:T",
         .params     = "value",
diff --git a/hmp.c b/hmp.c
index 2aafb50e8e..4ee9af7165 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1574,6 +1574,12 @@ void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict)
     qmp_migrate_set_speed(value, NULL);
 }
 
+void hmp_migrate_set_max_cpu_throttle(Monitor *mon, const QDict *qdict)
+{
+    int64_t value = qdict_get_int(qdict, "value");
+    qmp_migrate_set_max_cpu_throttle(value, NULL);
+}
+
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
 {
     const char *cap = qdict_get_str(qdict, "capability");
diff --git a/hmp.h b/hmp.h
index 33354f1bdd..e57f7e4005 100644
--- a/hmp.h
+++ b/hmp.h
@@ -73,6 +73,7 @@ void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
 void hmp_migrate_pause(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_speed(Monitor *mon, const QDict *qdict);
+void hmp_migrate_set_max_cpu_throttle(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_cache_size(Monitor *mon, const QDict *qdict);
-- 
2.11.0
