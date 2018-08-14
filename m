Received: from eggs.gnu.org ([2001:4830:134:3::10]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdv6-0004cE-Op
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtt-0006dH-QO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtt-0006ag-H6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtr-0007DS-AO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:45 +0100
Message-Id: <20180814181815.23348-16-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/45] vmstate.h: Provide
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

From: Luc Michel <luc.michel@greensocs.com>

Provide a VMSTATE_UINT16_SUB_ARRAY macro to save a uint16_t sub-array in
a VMState.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180727095421.386-5-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 42b946ce902..2b501d04669 100644
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
2.18.0
