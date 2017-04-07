Received: from eggs.gnu.org ([2001:4830:134:3::10]:40133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcG3-00086f-TQ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcG3-000575-2N
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:31 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcG2-00056k-Uo
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id c45so3675212qtb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 15:21:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  7 Apr 2017 19:20:16 -0300
Message-Id: <20170407222016.15308-5-f4bug@amsat.org>
In-Reply-To: <20170407222016.15308-1-f4bug@amsat.org>
References: <20170407222016.15308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/4] qga: improve error handling in
 transfer_memory_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

Michael should I use Signed-off-by instead of the Suggested-by (since it is your
code)?

 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index fc45102a1e..ca5a24b2c9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2128,6 +2128,9 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
             if (errno == ENOENT) {
                 result->response =
                     GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
+            } else {
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
             }
             goto out1;
         }
-- 
2.11.0
