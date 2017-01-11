Received: from eggs.gnu.org ([2001:4830:134:3::10]:45275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgQ-000373-1y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgP-0003KY-9Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:42 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgO-0003KE-S9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id l2so324570wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:40 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:02 +0100
Message-Id: <1484163327-111841-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] stubs: remove unused stub for serial_hd
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
1.8.3.1
