Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG5b-00009J-Js
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG5W-0006Nj-Pl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:23 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTG5W-0006N9-II
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:49:18 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:49:15 +0100
Message-Id: <20170116224915.19430-2-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20170116224915.19430-1-glaubitz@physik.fu-berlin.de>
References: <20170116224915.19430-1-glaubitz@physik.fu-berlin.de>
Subject: [Qemu-devel] [PATCH] linux-user: Update m68k syscall definitions to
 match Linux 4.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 linux-user/m68k/syscall_nr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
index 4b50fb29b6..d239551b34 100644
--- a/linux-user/m68k/syscall_nr.h
+++ b/linux-user/m68k/syscall_nr.h
@@ -376,3 +376,6 @@
 #define TARGET_NR_userfaultfd           373
 #define TARGET_NR_membarrier            374
 #define TARGET_NR_mlock2                375
+#define TARGET_NR_copy_file_range       376
+#define TARGET_NR_preadv2               377
+#define TARGET_NR_pwritev2              378
-- 
2.11.0
