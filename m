Received: from eggs.gnu.org ([2001:4830:134:3::10]:60890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYH-0006qO-FS
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYG-0000fK-MB
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:02 -0300
Message-Id: <20180528232719.4721-5-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/21] memory: Do not include
 "exec/ioport.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Code change produced with:
    $ git grep '#include "exec/ioport.h"' memory.c | \
      cut -d: -f-1 | \
      xargs egrep -Li "(portio|cpu_(in|out).\()" | \
      xargs sed -i.bak '/#include "exec\/ioport.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/memory.c b/memory.c
index fc7f9b782b..7ead90f8cd 100644
--- a/memory.c
+++ b/memory.c
@@ -19,7 +19,6 @@
 #include "cpu.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
-#include "exec/ioport.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-- 
2.17.0
