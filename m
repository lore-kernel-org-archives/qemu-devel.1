Received: from eggs.gnu.org ([2001:4830:134:3::10]:51277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAQ5u-0000Kq-Jf
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAQ5p-0005mr-M9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:12:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 May 2017 21:11:49 -0300
Message-Id: <20170516001150.11508-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] oslib: strip trailing '\n' from error_setg()
 string argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

spotted by Coccinelle script scripts/coccinelle/err-bad-newline.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4d9189e9ef..7ca02f0103 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -447,7 +447,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     /* touch pages simultaneously */
     if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
         error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
-            "pages available to allocate guest RAM\n");
+            "pages available to allocate guest RAM");
     }
 
     ret = sigaction(SIGBUS, &oldact, NULL);
-- 
2.11.0
