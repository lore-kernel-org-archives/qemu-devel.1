Received: from eggs.gnu.org ([2001:4830:134:3::10]:34218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS1-0001Gb-An
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS0-0005Mt-JY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:21 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS0-0005Me-Fg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so710574qtl.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:48 -0300
Message-Id: <20170718003159.10200-21-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 20/31] util/cacheinfo: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This include was forgotten when splitting cacheinfo.c out of
tcg/ppc/tcg-target.inc.c (see commit b255b2c8).

While compiling on powerpc:

      CC      util/cacheinfo.o
    qemu/util/cacheinfo.c: In function 'arch_cache_info':
    qemu/util/cacheinfo.c:137:33: error: 'AT_ICACHEBSIZE' undeclared (first use in this function)
             *isize = qemu_getauxval(AT_ICACHEBSIZE);
                                     ^
    qemu/util/cacheinfo.c:137:33: note: each undeclared identifier is reported only once for each function it appears in
    qemu/util/cacheinfo.c:140:33: error: 'AT_DCACHEBSIZE' undeclared (first use in this function)
             *dsize = qemu_getauxval(AT_DCACHEBSIZE);
                                     ^
    qemu/rules.mak:66: recipe for target 'util/cacheinfo.o' failed
    make: *** [util/cacheinfo.o] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 util/cacheinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 6253049533..593940f27b 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -129,6 +129,7 @@ static void arch_cache_info(int *isize, int *dsize)
 }
 
 #elif defined(_ARCH_PPC) && defined(__linux__)
+# include "elf.h"
 
 static void arch_cache_info(int *isize, int *dsize)
 {
-- 
2.13.2
