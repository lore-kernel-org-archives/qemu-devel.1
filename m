Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG8-0007XJ-Ng
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOG7-0005L1-UH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOG7-0005KU-Jz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:34:31 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Jul 2018 18:34:51 +0200
Message-Id: <20180703163451.16936-8-laurent@vivier.eu>
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] linux-user/strace: Improve recvmsg() output
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
Message-Id: <20180628034652.24152-7-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index afe4db07f3..ff8bb19f5f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1107,7 +1107,7 @@
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvmsg
-{ TARGET_NR_recvmsg, "recvmsg" , NULL, NULL, NULL },
+{ TARGET_NR_recvmsg, "recvmsg" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_remap_file_pages
 { TARGET_NR_remap_file_pages, "remap_file_pages" , NULL, NULL, NULL },
-- 
2.17.1
