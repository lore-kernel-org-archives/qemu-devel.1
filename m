Received: from eggs.gnu.org ([2001:4830:134:3::10]:50992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDd-0003Px-8k
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDc-0004v2-71
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:37 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDc-0004uo-1e
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:36 -0500
Received: by mail-pl0-x244.google.com with SMTP id z5so22529991plo.10
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:42 -0800
Message-Id: <20171229063145.29167-36-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 35/38] qom: Add MMU_DEBUG_LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

This lets us tell bottom levels of virtual memory translation
routines that the access is from within QEMU itself and bypass
certain tests.

Cc: Andreas Färber <afaerber@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index c2fa151228..d5361ffd0e 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -64,7 +64,8 @@ typedef uint64_t vaddr;
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
     MMU_DATA_STORE = 1,
-    MMU_INST_FETCH = 2
+    MMU_INST_FETCH = 2,
+    MMU_DEBUG_LOAD = 3
 } MMUAccessType;
 
 typedef struct CPUWatchpoint CPUWatchpoint;
-- 
2.14.3
