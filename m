Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA8-0000dA-OU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA7-0005bT-IN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA7-0005Yj-Bn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:51 -0400
Message-Id: <20180817051853.23792-8-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 7/9] vl: add -enable-sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 vl.c            |  3 +++
 qemu-options.hx | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/vl.c b/vl.c
index 16b913f9d5..5f4e24f29b 100644
--- a/vl.c
+++ b/vl.c
@@ -3959,6 +3959,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_enable_sync_profile:
+                qsp_enable();
+                break;
             case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
diff --git a/qemu-options.hx b/qemu-options.hx
index ea4edb4938..466a61d384 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3963,6 +3963,16 @@ Dump json-encoded vmstate information for current machine type to file
 in @var{file}
 ETEXI
 
+DEF("enable-sync-profile", 0, QEMU_OPTION_enable_sync_profile,
+    "-enable-sync-profile\n"
+    "                enable synchronization profiling\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -enable-sync-profile
+@findex -enable-sync-profile
+Enable synchronization profiling.
+ETEXI
+
 STEXI
 @end table
 ETEXI
-- 
2.17.1
