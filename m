Received: from eggs.gnu.org ([209.51.188.92]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDeX-0002z4-UJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDc5-0000SF-Ky
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:09:42 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  9 Jan 2019 14:08:41 +0100
Message-Id: <20190109130844.5172-4-laurent@vivier.eu>
In-Reply-To: <20190109130844.5172-1-laurent@vivier.eu>
References: <20190109130844.5172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/6] qom: Include qemu/fprintf-fn.h in cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Priit Laes <plaes@plaes.org>

From: Priit Laes <plaes@plaes.org>

QOM cpu.h uses fprintf_function which requires Qemu's
qemu/fprintf-fn.h header. Include it.

Signed-off-by: Priit Laes <plaes@plaes.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181226003722.31257-1-plaes@plaes.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qom/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1396f53e5b..6d1ba53d72 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/fprintf-fn.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
-- 
2.20.1
