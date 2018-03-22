Received: from eggs.gnu.org ([2001:4830:134:3::10]:36869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBo-0000M9-RR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBn-00066H-Ee
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:24 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1eyyBm-000656-Ts
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:23 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Mar 2018 13:14:53 +0200
Message-Id: <cb7dcdf3685e430783b24cce3a3cbd3aaa997cb7.1521717086.git.berto@igalia.com>
In-Reply-To: <cover.1521717086.git.berto@igalia.com>
References: <cover.1521717086.git.berto@igalia.com>
In-Reply-To: <cover.1521717086.git.berto@igalia.com>
References: <cover.1521717086.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12 v3 2/2] iotests: Update 186 after
 commit ac64273c66ab136c44043259162
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Alberto Garcia <berto@igalia.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/186.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index ec75c0fc60..5020162826 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -404,7 +404,7 @@ Testing: -drive if=floppy
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      /machine/unattached/device[13]
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -412,7 +412,7 @@ Testing: -drive if=floppy,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      /machine/unattached/device[13]
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
-- 
2.11.0
