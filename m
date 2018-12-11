Received: from eggs.gnu.org ([2001:4830:134:3::10]:43024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPG-0008Es-4V
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPC-0007XB-ET
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:52 +0100
Message-Id: <20181211180352.19644-31-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/30] Fixes i386 xchgq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, "fabrice.desclaux@cea.fr" <fabrice.desclaux@cea.fr>

From: "fabrice.desclaux@cea.fr" <fabrice.desclaux@cea.fr>

As "xchg" reads and writes both operands, the "+m" is required to avoid
undefined behavior on -O2 compilation.

Signed-off-by: Fabrice Desclaux <fabrice.desclaux@cea.fr>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <03506cf0-a204-f619-8ee4-4990a5e69af5@cea.fr>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/tcg/i386/test-i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index a29b41e764..18d5609665 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -1137,7 +1137,7 @@ void test_xchg(void)
     TEST_XCHG(xchgb, "b", "+q");
 
 #if defined(__x86_64__)
-    TEST_XCHG(xchgq, "", "=m");
+    TEST_XCHG(xchgq, "", "+m");
 #endif
     TEST_XCHG(xchgl, "k", "+m");
     TEST_XCHG(xchgw, "w", "+m");
-- 
2.19.2
