Received: from eggs.gnu.org ([2001:4830:134:3::10]:59415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBU-0006Lk-HC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBT-00045q-OW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBT-000452-Ku
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D2B77D83A
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:19 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D03EF63F34
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:00 +0200
Message-Id: <20180531171606.21604-9-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/53] target/i386/kvm.c: Remove compatibility
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

From: Peter Maydell <peter.maydell@linaro.org>

Now we've updated our copy of the kernel headers we can remove the
compatibility shim that handled KVM_HINTS_REALTIME not being defined.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180525132755.21839-7-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8eae654991..44f70733e7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -47,11 +47,6 @@
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
