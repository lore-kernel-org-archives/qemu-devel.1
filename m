Received: from eggs.gnu.org ([2001:4830:134:3::10]:34027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fHmxc-00040g-Vq
	for qemu-devel@nongnu.org; Sun, 13 May 2018 05:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fHmxc-0003tu-A1
	for qemu-devel@nongnu.org; Sun, 13 May 2018 05:06:32 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Sun, 13 May 2018 11:06:13 +0200
Message-Id: <20180513090613.27960-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro for
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org, Stefan Weil <sw@weilnetz.de>

It now prevents compiler warnings (enabled with -Wimplicit-fallthrough=
or -Wextra) as intended.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

I suggest to add and use a similar macro QEMU_FALLTHROUGH()
for the rest of the code and can provide a patch if that's
fine for everyone.

Regards
Stefan

 disas/libvixl/vixl/globals.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disas/libvixl/vixl/globals.h b/disas/libvixl/vixl/globals.h
index 61dc9f7f7e..33c4231d91 100644
--- a/disas/libvixl/vixl/globals.h
+++ b/disas/libvixl/vixl/globals.h
@@ -112,6 +112,8 @@ inline void USE(T1, T2, T3, T4) {}
 // C++11(201103L).
 #if __has_warning("-Wimplicit-fallthrough") && __cplusplus >= 201103L
   #define VIXL_FALLTHROUGH() [[clang::fallthrough]] //NOLINT
+#elif defined(__GNUC__)
+  #define VIXL_FALLTHROUGH() __attribute__((fallthrough))
 #else
   #define VIXL_FALLTHROUGH() do {} while (0)
 #endif
-- 
2.11.0
