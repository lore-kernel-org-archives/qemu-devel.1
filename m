Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651s-0001UP-QM
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651s-0005zw-4B
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:00 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d651r-0005zZ-Ud
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:00 -0400
Received: by mail-pg0-x243.google.com with SMTP id s62so797835pgc.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 17:53:59 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 May 2017 09:53:21 +0900
Message-Id: <4597992f624c015ceb51fedb4628b3fdb1e5bbaa.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 06/11] migration: Add VMSTATE_UINTTL_2DARRAY()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stafford Horne <shorne@gmail.com>

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
