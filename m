Received: from eggs.gnu.org ([2001:4830:134:3::10]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChQ-00065I-34
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChP-0000WX-6x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUChP-0000Vq-0V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:23 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  4 Dec 2018 16:32:57 +0100
Message-Id: <1543937577-28256-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1543937577-28256-1-git-send-email-thuth@redhat.com>
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v2 7/7] Remove QEMU_ARTIFICIAL macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

The code that used it has already been removed a while ago with commit
dc41aa7d34989b552ef ("tcg: Remove GET_TCGV_* and MAKE_TCGV_*").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/compiler.h    | 6 ------
 scripts/checkpatch.pl      | 1 -
 scripts/cocci-macro-file.h | 1 -
 3 files changed, 8 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 1593bca..261842b 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -28,12 +28,6 @@
 
 #define QEMU_SENTINEL __attribute__((sentinel))
 
-#if QEMU_GNUC_PREREQ(4, 3)
-#define QEMU_ARTIFICIAL __attribute__((always_inline, artificial))
-#else
-#define QEMU_ARTIFICIAL
-#endif
-
 #if defined(_WIN32)
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 60f6f89..a892a6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -202,7 +202,6 @@ our $Attribute	= qr{
 			QEMU_NORETURN|
 			QEMU_WARN_UNUSED_RESULT|
 			QEMU_SENTINEL|
-			QEMU_ARTIFICIAL|
 			QEMU_PACKED|
 			GCC_FMT_ATTR
 		  }x;
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index 9f2e72e..7e200a1 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -23,7 +23,6 @@
 #define QEMU_NORETURN __attribute__ ((__noreturn__))
 #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
 #define QEMU_SENTINEL __attribute__((sentinel))
-#define QEMU_ARTIFICIAL __attribute__((always_inline, artificial))
 #define QEMU_PACKED __attribute__((gcc_struct, packed))
 
 #define cat(x,y) x ## y
-- 
1.8.3.1
