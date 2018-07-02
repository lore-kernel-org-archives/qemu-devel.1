Received: from eggs.gnu.org ([2001:4830:134:3::10]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2ya-00056T-GS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yZ-0003j5-PT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:00 -0400
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:36427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yZ-0003iw-KO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:59 -0400
Received: by mail-vk0-x232.google.com with SMTP id y9-v6so1097267vky.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:50:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:24 -0300
Message-Id: <20180702175030.18621-8-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/13] linux-user/strace: Improve recvmsg()
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 90cf7e338a..31093c3371 100644
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
2.18.0
