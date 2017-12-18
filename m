Received: from eggs.gnu.org ([2001:4830:134:3::10]:44403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFO-0002gU-JF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFL-0004jj-IA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:38 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFL-0004il-BB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:35 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so5210906pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:19 -0800
Message-Id: <20171218173022.18418-7-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/9] vmstate: Add VMSTATE_UINT64_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

At the same time, move VMSTATE_UINT32_SUB_ARRAY
beside the other UINT32 definitions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/migration/vmstate.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 88b55df5ae..8c3889433c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -905,6 +905,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT32_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
 
+#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint32_t)
+
 #define VMSTATE_UINT32_2DARRAY(_f, _s, _n1, _n2)                      \
     VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, 0)
 
@@ -914,6 +917,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, 0)
 
+#define VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint64, uint64_t)
+
 #define VMSTATE_UINT64_2DARRAY(_f, _s, _n1, _n2)                      \
     VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, 0)
 
@@ -932,9 +938,6 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_INT32_ARRAY(_f, _s, _n)                               \
     VMSTATE_INT32_ARRAY_V(_f, _s, _n, 0)
 
-#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
-    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint32_t)
-
 #define VMSTATE_INT64_ARRAY_V(_f, _s, _n, _v)                         \
     VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_int64, int64_t)
 
-- 
2.14.3
