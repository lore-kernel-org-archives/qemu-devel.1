Received: from eggs.gnu.org ([2001:4830:134:3::10]:57522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0W-0005mU-CC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ0V-0007WT-Eu
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ0V-0007Vz-9g
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:32:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64F9DC09839C
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:32:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:32:25 -0300
Message-Id: <20170927203225.30896-3-ehabkost@redhat.com>
In-Reply-To: <20170927203225.30896-1-ehabkost@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-options: Deprecate -nodefconfig
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

Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
have no default config files that would be disabled using
-nodefconfig.  Update documentation and document -nodefconfig as
deprecated.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 39225ae6c3..bc52e79184 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4069,24 +4069,25 @@ output to stdout. This can be later used as input file for @code{-readconfig} op
 ETEXI
 DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig,
     "-nodefconfig\n"
-    "                do not load default config files at startup\n",
+    "                do not load default config files at startup (deprecated)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -nodefconfig
 @findex -nodefconfig
-Normally QEMU loads configuration files from @var{sysconfdir} and @var{datadir} at startup.
-The @code{-nodefconfig} option will prevent QEMU from loading any of those config files.
+This option was used to disable loading of config files from @var{sysconfdir}
+and @var{datadir}, but it is deprecated as QEMU doesn't load any config files
+from @var{datadir} anymore.  To disable loading of config files from
+@var{sysconfdir}, use @code{-no-user-config} instead.
 ETEXI
 DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
     "-no-user-config\n"
-    "                do not load user-provided config files at startup\n",
+    "                do not load default user-provided config files at startup\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -no-user-config
 @findex -no-user-config
 The @code{-no-user-config} option makes QEMU not load any of the user-provided
-config files on @var{sysconfdir}, but won't make it skip the QEMU-provided config
-files from @var{datadir}.
+config files on @var{sysconfdir}.
 ETEXI
 DEF("trace", HAS_ARG, QEMU_OPTION_trace,
     "-trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
-- 
2.13.5
