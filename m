Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgU-00039y-Sr
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgU-0005VJ-7K
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:46 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgU-0005Uk-3r
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:46 -0500
Received: by mail-qt0-x243.google.com with SMTP id s39so10007562qth.7
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:21 -0300
Message-Id: <20180124130126.20871-7-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] linux-user/strace: improve recvmsg()
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 947ff04eab..ae6dc8fecf 100644
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
2.15.1
