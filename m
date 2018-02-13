Received: from eggs.gnu.org ([2001:4830:134:3::10]:41749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHT-0004AU-Jf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHQ-0007cB-Bs
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:51 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHQ-0007c1-5a
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:48 -0500
Received: by mail-wm0-x241.google.com with SMTP id j21so12973716wmh.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:17 +0100
Message-Id: <1518523252-49106-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/48] build-sys: check static linking of UBSAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180208162343.30809-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a53562..913e148 100755
--- a/configure
+++ b/configure
@@ -5306,7 +5306,15 @@ fi
 ##########################################
 # checks for sanitizers
 
-write_c_skeleton
+# we could use a simple skeleton for flags checks, but this also
+# detect the static linking issue of ubsan, see also:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
+cat > $TMPC << EOF
+#include <stdint.h>
+int main(void) {
+  return INT32_MIN / -1;
+}
+EOF
 
 have_asan=no
 have_ubsan=no
-- 
1.8.3.1
