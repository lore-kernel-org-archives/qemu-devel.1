Received: from eggs.gnu.org ([209.51.188.92]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC6-0001Nl-Tz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC6-0002W9-5n
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:38 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC5-0002VP-VJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:38 -0500
Received: by mail-pf1-x42b.google.com with SMTP id g6so12126497pfh.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:37 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:20 -0800
Message-Id: <20190307185622.29026-11-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/12] decodetree: Allow +- to begin a
 number initializing a field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 57d4c9297e..eef32f695f 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -589,7 +589,7 @@ def parse_generic(lineno, is_format, name, toks):
             continue
 
         # 'Foo=number' sets an argument field to a constant value
-        if re_fullmatch(re_ident + '=[0-9]+', t):
+        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
             (fname, value) = t.split('=')
             value = int(value)
             flds = add_field(lineno, flds, fname, ConstField(value))
-- 
2.17.2
