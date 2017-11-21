Received: from eggs.gnu.org ([2001:4830:134:3::10]:56315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eH2Gr-00020I-Cj
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eH2Go-0001yG-8W
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:43:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1eH2Go-0001xj-2t
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:42:58 -0500
From: Yoni Bettan <ybettan@redhat.com>
Date: Tue, 21 Nov 2017 08:41:06 +0200
Message-Id: <20171121064106.13721-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoni Bettan <ybettan@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

        * it was added on 2008 902b3d5c392bb6f48ef340ad8ecc3311705d2800
          when introduced cache-utils.[ch]
        * since then cache-utils.[ch] were removed but **envp was left
          behind

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 linux-user/main.c | 2 +-
 vl.c              | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index aa02f25b85..ca5628c1ca 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4233,7 +4233,7 @@ static int parse_args(int argc, char **argv)
     return optind;
 }
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
     struct target_pt_regs regs1, *regs = &regs1;
     struct image_info info1, *info = &info1;
diff --git a/vl.c b/vl.c
index 1ad1c04637..9667756ccc 100644
--- a/vl.c
+++ b/vl.c
@@ -35,10 +35,10 @@
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
 #include <SDL.h>
-int qemu_main(int argc, char **argv, char **envp);
+int qemu_main(int argc, char **argv);
 int main(int argc, char **argv)
 {
-    return qemu_main(argc, argv, NULL);
+    return qemu_main(argc, argv);
 }
 #undef main
 #define main qemu_main
@@ -3088,7 +3088,7 @@ static void register_global_properties(MachineState *ms)
     user_register_global_props();
 }
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
     int i;
     int snapshot, linux_boot;
-- 
2.13.6
