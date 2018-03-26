Received: from eggs.gnu.org ([2001:4830:134:3::10]:48528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0TPW-0005Sv-F6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0TPV-0004jz-LF
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:46 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0TPV-0004jT-Er
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:47:45 -0400
Received: by mail-pl0-x241.google.com with SMTP id g20-v6so797029plo.9
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 07:47:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Mar 2018 22:47:30 +0800
Message-Id: <20180326144730.6351-2-richard.henderson@linaro.org>
In-Reply-To: <20180326144730.6351-1-richard.henderson@linaro.org>
References: <20180326144730.6351-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/1] scripts/decodetree: Fix insnmask not marked
 as global in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

if '-w 16' was given as a cmdline args a local copy of insnmask
is set and not the global one.

Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20180319115846.9662-1-kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.14.3
