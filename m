Received: from eggs.gnu.org ([209.51.188.92]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlVb-0002c0-Ex
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlQA-0003tl-3T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:04:52 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 22:04:32 +0100
Message-Id: <20190204210433.26088-3-philmd@redhat.com>
In-Reply-To: <20190204210433.26088-1-philmd@redhat.com>
References: <20190204210433.26088-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] hw/unicore32/puv3: Drop useless inclusion
 of "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

In 47973a2dbf we split the last generic chipset out of the PC
board, but forgot to remove the include of "hw/i386/pc.h".
Since it is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/unicore32/puv3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 830fe3face..b42e600f74 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -15,7 +15,6 @@
 #include "ui/console.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
-#include "hw/i386/pc.h"
 #include "sysemu/qtest.h"
=20
 #undef DEBUG_PUV3
--=20
2.20.1
