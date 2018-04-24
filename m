Received: from eggs.gnu.org ([2001:4830:134:3::10]:36624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DM-0007La-M4
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DL-00074o-PR
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:52 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DL-00071c-Gi
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:51 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Tue, 24 Apr 2018 18:58:27 +0100
Message-ID: <1524592709-6553-15-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/16] os-posix: cleanup: Replace fprintf with
 error_report in remaining call sites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v8: Remove one remaining spurious "\n"
v7: New patch
---
 os-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 0f59566..a2ba50d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -129,7 +129,7 @@ void os_set_proc_name(const char *s)
         exit(1);
     }
 #else
-    fprintf(stderr, "Change of process name not supported by your OS\n");
+    error_report("Change of process name not supported by your OS");
     exit(1);
 #endif
 }
@@ -243,7 +243,7 @@ static void change_root(void)
 {
     if (chroot_dir) {
         if (chroot(chroot_dir) < 0) {
-            fprintf(stderr, "chroot failed\n");
+            error_report("chroot failed");
             exit(1);
         }
         if (chdir("/")) {
-- 
2.1.4
