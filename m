Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlMk-0005fq-O2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlMh-0000Bh-Lj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:57:34 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlMh-0000BX-HO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:57:31 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so15105220qta.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 19:57:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Jul 2017 23:57:03 -0300
Message-Id: <20170711025703.24194-4-f4bug@amsat.org>
In-Reply-To: <20170711025703.24194-1-f4bug@amsat.org>
References: <20170711025703.24194-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/3] xen/pt: add comments about !x86 archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Anthony Perard <anthony.perard@citrix.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anoob Soman <anoob.soman@citrix.com>, Juergen Gross <jgross@suse.com>, Anthony Xu <anthony.xu@intel.com>, Paul Durrant <paul.durrant@citrix.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/xen/xen_pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 375efa68f6..21c32b0991 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -58,7 +58,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
-#include "hw/i386/pc.h"
+#include "hw/i386/pc.h" /* TODO check !x86 */
 #include "hw/xen/xen_backend.h"
 #include "xen_pt.h"
 #include "qemu/range.h"
@@ -687,7 +687,7 @@ static const MemoryListener xen_pt_io_listener = {
     .priority = 10,
 };
 
-static void
+static void /* TODO check !x86 */
 xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
                                       XenHostPCIDevice *dev)
 {
-- 
2.13.2
