Received: from eggs.gnu.org ([209.51.188.92]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkA-0000P3-Bd
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgk9-0007M0-DV
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:06 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:41699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxgk8-0007Eb-U6
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:05 -0500
Received: by mail-pl1-x62c.google.com with SMTP id y5so2756119plk.8
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:30:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 23 Feb 2019 15:29:50 -0800
Message-Id: <20190223232954.7185-4-richard.henderson@linaro.org>
In-Reply-To: <20190223232954.7185-1-richard.henderson@linaro.org>
References: <20190223232954.7185-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] decodetree: Ensure build_tree does not
 include values outside insnmask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reproduced with "scripts/decodetree.py /dev/null".

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index ba203aeccd..fb9a0ab3ad 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -784,7 +784,7 @@ class Tree:
 
 def build_tree(pats, outerbits, outermask):
     # Find the intersection of all remaining fixedmask.
-    innermask = ~outermask
+    innermask = ~outermask & insnmask
     for i in pats:
         innermask &= i.fixedmask
 
-- 
2.17.2
