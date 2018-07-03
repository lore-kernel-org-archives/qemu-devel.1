Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJX-0008ED-9Y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJW-0001OR-JA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:59 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:32801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJW-0001OI-Ec
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:58 -0400
Received: by mail-qt0-x232.google.com with SMTP id l10-v6so1935664qtj.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:33:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  3 Jul 2018 12:33:36 -0300
Message-Id: <20180703153346.9050-3-f4bug@amsat.org>
In-Reply-To: <20180703153346.9050-1-f4bug@amsat.org>
References: <20180703153346.9050-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/12] linux-user/strace: Improve
 capget()/capset() output
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
2.18.0
