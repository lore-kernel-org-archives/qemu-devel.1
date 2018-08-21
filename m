Received: from eggs.gnu.org ([2001:4830:134:3::10]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4M-0001hX-V7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4C-0006Kg-LZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA47-000629-82
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id w11-v6so13895848wrc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:56 +0200
Message-Id: <1534870966-9287-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/74] vl: add -enable-sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 10 ++++++++++
 vl.c            |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5515dfa..d66ab1b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3953,6 +3953,16 @@ Dump json-encoded vmstate information for current machine type to file
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
diff --git a/vl.c b/vl.c
index 7055df3..d2af8ed 100644
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
-- 
1.8.3.1
