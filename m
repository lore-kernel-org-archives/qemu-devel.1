Received: from eggs.gnu.org ([209.51.188.92]:36866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC8-0001PO-8Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC7-0002XT-CM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:42649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC7-0002WK-5K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:39 -0500
Received: by mail-pf1-x433.google.com with SMTP id n74so12130511pfi.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:39 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:21 -0800
Message-Id: <20190307185622.29026-12-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 11/12] decodetree: Prefix extract function
 names with decode_function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This makes it easier to name Formats within multiple decode files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index eef32f695f..f8df89e072 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -312,7 +312,8 @@ class Format(General):
     """Class representing an instruction format"""
 
     def extract_name(self):
-        return 'extract_' + self.name
+        global decode_function
+        return decode_function + '_extract_' + self.name
 
     def output_extract(self):
         output('static void ', self.extract_name(), '(',
-- 
2.17.2
