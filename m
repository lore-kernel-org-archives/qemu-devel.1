Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUf-0004Jr-EU
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUc-00034w-Ac
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:25 +0300
Message-Id: <f5cdcaeea2944e6664b5abcfce5c3eaee71ca761.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 22/23] MAINTAINERS: Update paths for AioContext
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

Moved by c2b38b2
("block: move AioContext, QEMUTimer, main-loop to libqemuutil")

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6822b23bf..e79ffb3f8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1175,8 +1175,8 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Fam Zheng <famz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
-F: async.c
-F: aio-*.c
+F: util/async.c
+F: util/aio-*.c
 F: block/io.c
 F: migration/block*
 F: include/block/aio.h
-- 
2.11.0
