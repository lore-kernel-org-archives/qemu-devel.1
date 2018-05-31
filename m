Received: from eggs.gnu.org ([2001:4830:134:3::10]:41751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUz-0000xH-01
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUy-0006bN-8C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUy-0006a3-2C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0002yB-Vr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:55 +0100
Message-Id: <20180531142357.904-24-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/25] vmstate.h: Provide VMSTATE_BOOL_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Provide a VMSTATE_BOOL_SUB_ARRAY to go with VMSTATE_UINT8_SUB_ARRAY
and friends.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180521140402.23318-23-peter.maydell@linaro.org
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
2.17.1
