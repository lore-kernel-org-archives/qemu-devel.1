Received: from eggs.gnu.org ([2001:4830:134:3::10]:54438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAUya-0006DW-8u
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAUyW-0008Sf-A4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:24:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAUyW-0008SP-3k
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD19585A07
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 05:24:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 16 May 2017 07:24:39 +0200
Message-Id: <20170516052439.16214-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] fix mingw build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 crypto/random-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 0eddb915b7..92eed0ee78 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -23,7 +23,7 @@
 #include "crypto/random.h"
 
 #ifdef _WIN32
-#include <Wincrypt.h>
+#include <wincrypt.h>
 static HCRYPTPROV hCryptProv;
 #else
 static int fd; /* a file handle to either /dev/urandom or /dev/random */
-- 
2.9.3
