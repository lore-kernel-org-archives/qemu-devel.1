Received: from eggs.gnu.org ([2001:4830:134:3::10]:45573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSr-0007hG-AG
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSo-00028m-34
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQKSn-000258-My
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 23 Nov 2018 18:02:03 -0500
Message-Id: <20181123230206.12629-2-cota@braap.org>
In-Reply-To: <20181123230206.12629-1-cota@braap.org>
References: <20181123230206.12629-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/4] qht-bench: document -p flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Which we forgot to do in bd224fce60 ("qht-bench: add -p flag
to precompute hash values", 2018-09-26).

Signed-off-by: Emilio G. Cota <cota@braap.org>
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
2.17.1
