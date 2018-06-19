Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzI-0005QC-0z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzH-0006JS-Aj
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:44 -0400
From: luc.michel@greensocs.com
Date: Tue, 19 Jun 2018 11:31:20 +0200
Message-Id: <20180619093124.24011-4-luc.michel@greensocs.com>
In-Reply-To: <20180619093124.24011-1-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v2 3/7] vmstate.h: Provide
 VMSTATE_UINT16_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

From: Luc MICHEL <luc.michel@greensocs.com>

Provide a VMSTATE_UINT16_SUB_ARRAY macro to save a uint16_t sub-array in
a VMState.

Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
---
 include/migration/vmstate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 42b946ce90..2b501d0466 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -923,6 +923,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT16_ARRAY(_f, _s, _n)                               \
     VMSTATE_UINT16_ARRAY_V(_f, _s, _n, 0)
 
+#define VMSTATE_UINT16_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint16, uint16_t)
+
 #define VMSTATE_UINT16_2DARRAY(_f, _s, _n1, _n2)                      \
     VMSTATE_UINT16_2DARRAY_V(_f, _s, _n1, _n2, 0)
 
-- 
2.17.1
