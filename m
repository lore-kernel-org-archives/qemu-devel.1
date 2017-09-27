Received: from eggs.gnu.org ([2001:4830:134:3::10]:57496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0U-0005mD-Jw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0T-0007VZ-Ry
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ0T-0007VH-LU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 803D210C327
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:32:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:32:24 -0300
Message-Id: <20170927203225.30896-2-ehabkost@redhat.com>
In-Reply-To: <20170927203225.30896-1-ehabkost@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Both -nodefconfig and -no-user-config options do the same thing
today, we only need one variable to keep track of them.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 4fd01fda91..b347a97a5b 100644
--- a/vl.c
+++ b/vl.c
@@ -3093,7 +3093,6 @@ int main(int argc, char **argv, char **envp)
     const char *qtest_log = NULL;
     const char *pid_file = NULL;
     const char *incoming = NULL;
-    bool defconfig = true;
     bool userconfig = true;
     bool nographic = false;
     DisplayType display_type = DT_DEFAULT;
@@ -3194,8 +3193,6 @@ int main(int argc, char **argv, char **envp)
             popt = lookup_opt(argc, argv, &optarg, &optind);
             switch (popt->index) {
             case QEMU_OPTION_nodefconfig:
-                defconfig = false;
-                break;
             case QEMU_OPTION_nouserconfig:
                 userconfig = false;
                 break;
@@ -3203,7 +3200,7 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    if (defconfig && userconfig) {
+    if (userconfig) {
         if (qemu_read_default_config_file() < 0) {
             exit(1);
         }
-- 
2.13.5
