Received: from eggs.gnu.org ([209.51.188.92]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBn-0005lo-Fk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBi-0003qF-Bj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEBg-0003n9-9u
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:54 -0500
Received: by mail-pl1-x642.google.com with SMTP id g37so6350525plb.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:24:32 -0800
Message-Id: <20190228052432.32571-9-richard.henderson@linaro.org>
In-Reply-To: <20190228052432.32571-1-richard.henderson@linaro.org>
References: <20190228052432.32571-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 8/8] decodetree: Add --static-decode option
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

Like --decode, but do not drop 'static' qualifier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 4596a9da02..68979b73a0 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -980,7 +980,8 @@ def main():
 
     decode_scope = 'static '
 
-    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
+    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
+                 'static-decode=']
     try:
         (opts, args) = getopt.getopt(sys.argv[1:], 'o:w:', long_opts)
     except getopt.GetoptError as err:
@@ -991,6 +992,8 @@ def main():
         elif o == '--decode':
             decode_function = a
             decode_scope = ''
+        elif o == '--static-decode':
+            decode_function = a
         elif o == '--translate':
             translate_prefix = a
             translate_scope = ''
-- 
2.17.2
