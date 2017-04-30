Received: from eggs.gnu.org ([2001:4830:134:3::10]:60429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3W-0001y9-JA
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3V-0006Ys-RV
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:06 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3V-0006YT-LT
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:05 -0400
Received: by mail-pf0-x241.google.com with SMTP id o68so6703874pfj.2
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:15:05 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:20 +0900
Message-Id: <a7a36b48f9e4c9f971556a7b71c056d2b25a41f0.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 06/11] migration: Add VMSTATE_UINTTL_2DARRAY()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

In openRISC we are implementing the shadow registers as a 2d array.
Using this target long method rather than direct 32-bit alternatives is
consistent with the rest of our vm state serialization logic.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/migration/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index f3d5dfc..a40bd35 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -18,6 +18,8 @@
     VMSTATE_UINT64_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
+    VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
@@ -37,6 +39,8 @@
     VMSTATE_UINT32_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
+    VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
@@ -48,5 +52,8 @@
     VMSTATE_UINTTL_EQUAL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
+#define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
+    VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, 0)
+
 
 #endif
-- 
2.9.3
