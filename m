Received: from eggs.gnu.org ([2001:4830:134:3::10]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZvE-0005Vt-OO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZvD-00076x-Fg
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzZvD-00076g-A9
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  4 Oct 2017 00:00:24 -0300
Message-Id: <20171004030025.7866-2-ehabkost@redhat.com>
In-Reply-To: <20171004030025.7866-1-ehabkost@redhat.com>
References: <20171004030025.7866-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

Both -nodefconfig and -no-user-config options do the same thing
today, we only need one variable to keep track of them.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 3fed457921..ebea42e0ea 100644
--- a/vl.c
+++ b/vl.c
@@ -3111,7 +3111,6 @@ int main(int argc, char **argv, char **envp)
     const char *qtest_log = NULL;
     const char *pid_file = NULL;
     const char *incoming = NULL;
-    bool defconfig = true;
     bool userconfig = true;
     bool nographic = false;
     DisplayType display_type = DT_DEFAULT;
@@ -3213,8 +3212,6 @@ int main(int argc, char **argv, char **envp)
             popt = lookup_opt(argc, argv, &optarg, &optind);
             switch (popt->index) {
             case QEMU_OPTION_nodefconfig:
-                defconfig = false;
-                break;
             case QEMU_OPTION_nouserconfig:
                 userconfig = false;
                 break;
@@ -3222,7 +3219,7 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    if (defconfig && userconfig) {
+    if (userconfig) {
         if (qemu_read_default_config_file() < 0) {
             exit(1);
         }
-- 
2.13.5
