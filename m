Received: from eggs.gnu.org ([209.51.188.92]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBz-0001Da-MM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBy-0002Oi-TO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:31 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:37203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yBy-0002No-Lx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:30 -0500
Received: by mail-pf1-x431.google.com with SMTP id s22so12132580pfh.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:14 -0800
Message-Id: <20190307185622.29026-5-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/12] decodetree: Ensure build_tree does
 not include values outside insnmask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
