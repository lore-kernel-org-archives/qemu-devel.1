Received: from eggs.gnu.org ([209.51.188.92]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7XV-0006WB-4m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7XU-0007OF-8O
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gx7XS-00077H-9L
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id c8so1667770wrs.4
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:54:25 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 09:54:14 +0000
Message-Id: <20190222095421.28938-3-alex.bennee@linaro.org>
In-Reply-To: <20190222095421.28938-1-alex.bennee@linaro.org>
References: <20190222095421.28938-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/9] .travis.yml: split debug builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

The builds are reaching the magic 50 minute limit with regularity so
lets split them up. Rather than doing a full debug build on both just
enable debug tcg for linux-user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 866a1872b1..36ed7ec3f9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,7 +86,12 @@ matrix:
 
 
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg"
+        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+
+
+    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    - env:
+        - CONFIG="--enable-debug-tcg --disable-system"
 
 
     - env:
-- 
2.20.1
