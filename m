Received: from eggs.gnu.org ([2001:4830:134:3::10]:50195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOne9-00065D-B1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOne8-0002Nx-Ac
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOne8-0002NO-3P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBF5F401EF1D
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 17:15:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-107.ams2.redhat.com
	[10.36.117.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AAC9217B400
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 17:15:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  1 Jun 2018 19:15:19 +0200
Message-Id: <20180601171521.1770-2-pbonzini@redhat.com>
In-Reply-To: <20180601171521.1770-1-pbonzini@redhat.com>
References: <20180601171521.1770-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/56] bsd-user: include "exec/exec-all.h" which
 provides mmap_lock/unlock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 20cd29d145..17f4cd80aa 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -21,6 +21,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "bsd-mman.h"
+#include "exec/exec-all.h"
 
 //#define DEBUG_MMAP
 
-- 
2.17.0
