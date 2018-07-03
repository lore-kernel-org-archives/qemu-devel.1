Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG7-0007WW-Ul
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG4-0005JI-0f
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOG3-0005Is-Mi
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:50 +0200
Message-Id: <20180703163451.16936-7-laurent@vivier.eu>
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] linux-user/strace: Improve
 capget()/capset() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180628034652.24152-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2bc5ba04d4..afe4db07f3 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -59,10 +59,10 @@
 { TARGET_NR_cacheflush, "cacheflush" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_capget
-{ TARGET_NR_capget, "capget" , NULL, NULL, NULL },
+{ TARGET_NR_capget, "capget" , "%s(%p,%p)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_capset
-{ TARGET_NR_capset, "capset" , NULL, NULL, NULL },
+{ TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_chdir
 { TARGET_NR_chdir, "chdir" , NULL, print_chdir, NULL },
-- 
2.17.1
