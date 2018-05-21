Received: from eggs.gnu.org ([2001:4830:134:3::10]:42934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQP-0002z2-2g
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQN-00016j-VC
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:57 +0100
Message-Id: <20180521140402.23318-23-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 22/27] vmstate.h: Provide VMSTATE_BOOL_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Provide a VMSTATE_BOOL_SUB_ARRAY to go with VMSTATE_UINT8_SUB_ARRAY
and friends.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df463fd33d..59fc75e418 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -870,6 +870,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_BOOL_ARRAY(_f, _s, _n)                               \
     VMSTATE_BOOL_ARRAY_V(_f, _s, _n, 0)
 
+#define VMSTATE_BOOL_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_bool, bool)
+
 #define VMSTATE_UINT16_ARRAY_V(_f, _s, _n, _v)                         \
     VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_uint16, uint16_t)
 
-- 
2.17.0
