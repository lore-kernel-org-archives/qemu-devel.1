Received: from eggs.gnu.org ([209.51.188.92]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC4-0001L7-Je
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC3-0002UE-Qy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:36 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC3-0002Tg-K7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:35 -0500
Received: by mail-pg1-x52e.google.com with SMTP id i130so11979987pgd.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:35 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:18 -0800
Message-Id: <20190307185622.29026-9-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 08/12] decodetree: Add --static-decode option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Like --decode, but do not drop 'static' qualifier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index c4e8cb52f7..d6f94d902f 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -976,7 +976,8 @@ def main():
 
     decode_scope = 'static '
 
-    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
+    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
+                 'static-decode=']
     try:
         (opts, args) = getopt.getopt(sys.argv[1:], 'o:w:', long_opts)
     except getopt.GetoptError as err:
@@ -987,6 +988,8 @@ def main():
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
