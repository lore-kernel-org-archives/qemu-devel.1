Received: from eggs.gnu.org ([2001:4830:134:3::10]:52629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJggT-0006KA-Q6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJggP-0006Yk-Sx
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:48:41 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com
	([40.107.4.95]:35744
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fJggP-0006XS-8g
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:48:37 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Fri, 18 May 2018 17:48:08 +0300
Message-Id: <1526654888-9754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180517162342.4330-3-viktor.prutyanov@virtuozzo.com>
References: <20180517162342.4330-3-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] fixup! dump: use system context in Windows dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Fix building issues for targets other than x86_64

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 Makefile.target | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 6ae2609..5be6d18 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -138,7 +138,9 @@ obj-y += hw/
 obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
+ifeq ($(TARGET_NAME), x86_64)
 obj-y += win_dump.o
+endif
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
-- 
2.7.4
