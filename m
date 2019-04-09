Received: from eggs.gnu.org ([209.51.188.92]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDt7O-0000no-B1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDt7K-0005Jx-2R
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:57:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDt7H-0005IW-PW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:56:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id k19so9554679pgh.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:56:53 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue,  9 Apr 2019 21:26:35 +0530
Message-Id: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel]  [PATCH 0/4] Header cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

Removed unwanted includes from cpu-common.h
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 include/exec/cpu-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index cef8b88a2a..a3594f3f50 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,8 +7,6 @@
 #include "exec/hwaddr.h"
 #endif
 
-#include "qemu/bswap.h"
-#include "qemu/queue.h"
 #include "qemu/fprintf-fn.h"
 
 /**
-- 
2.17.1
