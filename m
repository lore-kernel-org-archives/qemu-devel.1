Received: from eggs.gnu.org ([2001:4830:134:3::10]:52272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000qD-Bt
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000FY-05
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-0000B2-Fg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id v13so18110137wrw.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:45 +0100
Message-Id: <1544628195-37728-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/54] compiler.h: Add an explicit check for the
 compiler version
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

The questions about our minimum compiler requirement pops up every
couple of months, and we then have to recall the details each time.
So let's document this in a proper way, by adding a comment and
check for the right compiler version to our compiler.h header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543574620-17506-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 6b92710..6f32ec2 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,6 +22,14 @@
 # define QEMU_GNUC_PREREQ(maj, min) 0
 #endif
 
+/*
+ * We need at least GCC 4.1 for atomics support. Clang also supports these,
+ * and reports itself as GCC 4.2, so it passes this check, too.
+ */
+#if !QEMU_GNUC_PREREQ(4, 1)
+#error QEMU needs a compiler that is compatible with GCC v4.1 or newer
+#endif
+
 #define QEMU_NORETURN __attribute__ ((__noreturn__))
 
 #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
-- 
1.8.3.1
