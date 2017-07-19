Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVM-00080u-2Z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVL-0006Xf-20
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:44 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVK-0006XT-TB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:42 -0400
Received: by mail-qk0-x241.google.com with SMTP id q130so1003660qka.4
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:35:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:43 -1000
Message-Id: <20170719233455.8740-3-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 02/14] util/cacheinfo: Add missing include
 for ppc linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This include was forgotten when splitting cacheinfo.c out of
tcg/ppc/tcg-target.inc.c (see commit b255b2c8).

For a Centos7 host, the include path

	<signal.h>
	  <bits/sigcontext.h>
            <asm/sigcontext.h>
              <asm/elf.h>
	        <asm/auxvec.h>

implicitly pulls in the desired AT_* defines.
Not so for Debian Jessie.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170711015524.22936-1-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.13.3
