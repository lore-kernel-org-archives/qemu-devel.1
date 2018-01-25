Received: from eggs.gnu.org ([2001:4830:134:3::10]:33571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehob-0003BF-3r
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoa-00034g-7T
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoa-00033y-04
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:40 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoY-0006tA-UL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:17 +0000
Message-Id: <1516887809-6265-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/21] vmstate: Add VMSTATE_UINT64_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

At the same time, move VMSTATE_UINT32_SUB_ARRAY
beside the other UINT32 definitions.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180119045438.28582-8-richard.henderson@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 88b55df..8c38894 100644
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
2.7.4
