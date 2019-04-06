Received: from eggs.gnu.org ([209.51.188.92]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hCcZg-0001Br-LL
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hCcZc-0000s3-Cc
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:05:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:37372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hCcZZ-0000o0-Pn
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:04:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id e6so4088823pgc.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 21:04:50 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Sat,  6 Apr 2019 09:34:22 +0530
Message-Id: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH 4/4] Header cleanups: Removed unwanted includes
 from cpu-common.h
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
