Received: from eggs.gnu.org ([2001:4830:134:3::10]:43603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjk-00043Y-Mm
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjj-0007jY-Ue
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evrjj-0007iS-PI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:35 -0400
Date: Tue, 13 Mar 2018 23:45:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520977432-187679-16-git-send-email-mst@redhat.com>
References: <1520977432-187679-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520977432-187679-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/22] qemu-options-wrapper.h: fix include patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

qemu-options.def is included from build directory
not from source directory.
Use include <> accordingly: include "" means
look in the current (source) directory search first.

cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qemu-options-wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 13bfea0..ec4cb8c 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -29,7 +29,7 @@
 #error "qemu-options-wrapper.h included with no option defined"
 #endif
 
-#include "qemu-options.def"
+#include <qemu-options.def>
 
 #undef DEF
 #undef DEFHEADING
-- 
MST
