Received: from eggs.gnu.org ([2001:4830:134:3::10]:57955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcy-0000jy-Gh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcx-0008Vz-QN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAcx-0008Vr-Jv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A317585547
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:27 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUt001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:27 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:52 +0100
Message-Id: <20170116165916.8575-9-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/32] stubs: remove unused stub for serial_hd
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
 stubs/Makefile.objs     | 1 -
 stubs/get-next-serial.c | 4 ----
 2 files changed, 5 deletions(-)
 delete mode 100644 stubs/get-next-serial.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c4df915..5b3e7c6 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -15,7 +15,6 @@ stub-obj-y += fdset-find-fd.o
 stub-obj-y += fdset-get-fd.o
 stub-obj-y += fdset-remove-fd.o
 stub-obj-y += gdbstub.o
-stub-obj-y += get-next-serial.o
 stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
diff --git a/stubs/get-next-serial.c b/stubs/get-next-serial.c
deleted file mode 100644
index 6ff6a6d..0000000
--- a/stubs/get-next-serial.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-
-CharDriverState *serial_hds[0];
-- 
2.9.3
