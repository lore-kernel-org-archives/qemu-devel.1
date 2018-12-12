Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N7-0001N8-Ti
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N3-0000eP-7T
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N1-0000Ti-4S
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id r10so18077851wrs.10
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:00 +0100
Message-Id: <1544628195-37728-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/54] Remove QEMU_ARTIFICIAL macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The code that used it has already been removed a while ago with commit
dc41aa7d34989b552ef ("tcg: Remove GET_TCGV_* and MAKE_TCGV_*").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543937577-28256-8-git-send-email-thuth@redhat.com>
---
 include/qemu/compiler.h    | 6 ------
 scripts/checkpatch.pl      | 1 -
 scripts/cocci-macro-file.h | 1 -
 3 files changed, 8 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a1e50ed..2dffc66 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -36,12 +36,6 @@
 
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
index b4b3495..440d95d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -226,7 +226,6 @@ our $Attribute	= qr{
 			QEMU_NORETURN|
 			QEMU_WARN_UNUSED_RESULT|
 			QEMU_SENTINEL|
-			QEMU_ARTIFICIAL|
 			QEMU_PACKED|
 			GCC_FMT_ATTR
 		  }x;
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index 1cb0b4a..e485cdc 100644
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
