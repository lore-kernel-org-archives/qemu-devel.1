Received: from eggs.gnu.org ([2001:4830:134:3::10]:56509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1eL2Ql-0007XC-Cm
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 02:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1eL2Qi-0007Sv-9u
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 02:41:47 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <felix.yzg@gmail.com>) id 1eL2Qi-0007S5-4t
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 02:41:44 -0500
Received: by mail-pl0-x243.google.com with SMTP id x22so7549930pln.11
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 23:41:43 -0800 (PST)
From: FelixYao <felix.yzg@gmail.com>
Date: Sat,  2 Dec 2017 15:41:30 +0800
Message-Id: <1512200490-50021-1-git-send-email-felix.yzg@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] main loop: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, FelixYao <felix.yzg@gmail.com>

hi Paolo Bonzini:

Those codes seem useless, Could it be removed?

Signed-off-by: FelixYao <felix.yzg@gmail.com>
---
 vl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/vl.c b/vl.c
index 1ad1c04..5bed4c2 100644
--- a/vl.c
+++ b/vl.c
@@ -2995,10 +2995,6 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 
     sz = QEMU_ALIGN_UP(sz, 8192);
     ram_size = sz;
-    if (ram_size != sz) {
-        error_report("ram size too large");
-        exit(EXIT_FAILURE);
-    }
 
     /* store value for the future use */
     qemu_opt_set_number(opts, "size", ram_size, &error_abort);
-- 
1.8.3.1
