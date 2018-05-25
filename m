Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClG-0006Ja-Lr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClF-0000sI-VS
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fMClF-0000qz-P8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:27:55 +0100
Message-Id: <20180525132755.21839-7-peter.maydell@linaro.org>
In-Reply-To: <20180525132755.21839-1-peter.maydell@linaro.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] target/i386/kvm.c: Remove compatibility
 shim for KVM_HINTS_REALTIME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Now we've updated our copy of the kernel headers we can remove the
compatibility shim that handled KVM_HINTS_REALTIME not being defined.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/kvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c2699f2f44..a36d986522 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -48,11 +48,6 @@
 #include "exec/memattrs.h"
 #include "trace.h"
 
-/* Work around this kernel header constant changing its name */
-#ifndef KVM_HINTS_REALTIME
-#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
-#endif
-
 //#define DEBUG_KVM
 
 #ifdef DEBUG_KVM
-- 
2.17.0
