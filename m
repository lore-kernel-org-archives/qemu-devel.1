Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaW-0000m7-Hr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaU-0006Q4-Ko
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:48 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaU-0006Pp-G6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:46 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so36635883qtg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:30:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Jun 2017 15:30:25 -0300
Message-Id: <20170613183025.5145-3-f4bug@amsat.org>
In-Reply-To: <20170613183025.5145-1-f4bug@amsat.org>
References: <20170613183025.5145-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] migration: remove duplicate typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>

    $ make docker-run-test-quick@centos6
    In file included from hw/net/vmxnet3.c:30:
    include/migration/register.h:18: error: redefinition of typedef ‘LoadStateHandler’
    include/migration/vmstate.h:32: note: previous declaration of ‘LoadStateHandler’ was here
    make: *** [hw/net/vmxnet3.o] Error 1
    tests/docker/Makefile.include:118: recipe for target 'docker-run' failed

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/migration/vmstate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f3f3c2af4d..342027def8 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -28,8 +28,8 @@
 #define QEMU_VMSTATE_H
 
 #include "migration/qjson.h"
+#include "migration/register.h"
 
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
-- 
2.11.0
