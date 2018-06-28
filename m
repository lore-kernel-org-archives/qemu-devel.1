Received: from eggs.gnu.org ([2001:4830:134:3::10]:46138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNtw-0007xg-5b
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNtv-0000dN-D5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:20 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:45191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNtv-0000d5-7s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:19 -0400
Received: by mail-qk0-x234.google.com with SMTP id c198-v6so2255654qkg.12
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:47:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 00:46:46 -0300
Message-Id: <20180628034652.24152-7-f4bug@amsat.org>
In-Reply-To: <20180628034652.24152-1-f4bug@amsat.org>
References: <20180628034652.24152-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/12] linux-user/strace: Improve recvmsg()
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
index 9b477b7730..70e89d423c 100644
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
