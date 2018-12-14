Received: from eggs.gnu.org ([2001:4830:134:3::10]:58973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0006HW-VN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007iY-3c
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1B-0007bV-QU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:01 -0500
Received: by mail-ot1-x32f.google.com with SMTP id a11so4088722otr.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:20 -0600
Message-Id: <20181214031923.29527-31-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/32] qht-bench: document -p flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Which we forgot to do in bd224fce60 ("qht-bench: add -p flag
to precompute hash values", 2018-09-26).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qht-bench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2089e2bed1..636750d39f 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -72,6 +72,7 @@ static const char commands_string[] =
     " -n = number of threads\n"
     "\n"
     " -o = offset at which keys start\n"
+    " -p = precompute hashes\n"
     "\n"
     " -g = set -s,-k,-K,-l,-r to the same value\n"
     " -s = initial size hint\n"
-- 
2.17.2
