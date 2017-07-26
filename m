Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2g-0004r8-G1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2f-0006c5-J7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:30 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2f-0006bx-Dr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:29 -0400
Received: by mail-ua0-x241.google.com with SMTP id w45so15063022uac.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 18:40:08 -0300
Message-Id: <20170726214010.420-3-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-1-f4bug@amsat.org>
References: <20170726214010.420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 2/4] fdt: check fdt_required condition
 can be satisfied _after_ testing libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 063de32773..0d5bdb3ae9 100755
--- a/configure
+++ b/configure
@@ -3558,15 +3558,6 @@ for target in $target_list; do
   esac
 done
 
-if test "$fdt_required" = "yes"; then
-  if test "$fdt" = "no"; then
-    error_exit "fdt disabled but some requested targets require it." \
-      "You can turn off fdt only if you also disable all the system emulation" \
-      "targets which need it (by specifying a cut down --target-list)."
-  fi
-  fdt=yes
-fi
-
 if test "$fdt" != "no" ; then
   fdt_libs="-lfdt"
   # explicitly check for libfdt_env.h as it is missing in some stable installs
@@ -3603,6 +3594,15 @@ EOF
   fi
 fi
 
+if test "$fdt_required" = "yes"; then
+  if test "$fdt" = "no"; then
+    error_exit "fdt disabled but some requested targets require it." \
+      "You can turn off fdt only if you also disable all the system emulation" \
+      "targets which need it (by specifying a cut down --target-list)."
+  fi
+  fdt=yes
+fi
+
 libs_softmmu="$libs_softmmu $fdt_libs"
 
 ##########################################
-- 
2.13.3
