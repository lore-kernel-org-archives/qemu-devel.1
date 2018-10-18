Received: from eggs.gnu.org ([2001:4830:134:3::10]:48305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y2-Lz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyO-0006So-Vf
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyN-0006Ou-MQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id y16so35120422wrw.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:52 +0200
Message-Id: <1539894735-14232-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/48] hyperv_testdev: drop unnecessary includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 915d74e..7291fb1 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -13,13 +13,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
-#include <linux/kvm.h>
-#include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
-#include "sysemu/kvm.h"
 #include "target/i386/hyperv.h"
-#include "kvm_i386.h"
 
 typedef struct TestSintRoute {
     QLIST_ENTRY(TestSintRoute) le;
-- 
1.8.3.1
