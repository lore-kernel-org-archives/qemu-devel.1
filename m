Received: from eggs.gnu.org ([2001:4830:134:3::10]:37176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1extRO-0006oY-Nn
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1extRM-0004it-7W
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:59:02 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:40784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1extRM-0004gm-12
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:59:00 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Mon, 19 Mar 2018 12:58:46 +0100
Message-Id: <20180319115846.9662-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PATCH] scripts/decodetree: Fix insnmask not marked as
 global in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

if '-w 16' was given as a cmdline args a local copy of insnmask
is set and not the global one.

Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 scripts/decodetree.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 41301c84aa..277f9a9bba 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -972,6 +972,7 @@ def main():
     global input_file
     global insnwidth
     global insntype
+    global insnmask
 
     decode_function = 'decode'
     decode_scope = 'static '
-- 
2.16.2
