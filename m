Received: from eggs.gnu.org ([209.51.188.92]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBi-0005gS-9q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBg-0003o0-6q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:54 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEBe-0003jL-6J
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:50 -0500
Received: by mail-pf1-x431.google.com with SMTP id n125so9145724pfn.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:24:28 -0800
Message-Id: <20190228052432.32571-5-richard.henderson@linaro.org>
In-Reply-To: <20190228052432.32571-1-richard.henderson@linaro.org>
References: <20190228052432.32571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/8] decodetree: Ensure build_tree does not
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

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 33e32ee87f..e26d8253f2 100755
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
