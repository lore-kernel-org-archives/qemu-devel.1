Received: from eggs.gnu.org ([2001:4830:134:3::10]:35702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMd-0008P6-15
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMc-000097-9R
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Oct 2017 18:33:57 -0300
Message-Id: <20171023213359.23025-2-f4bug@amsat.org>
In-Reply-To: <20171023213359.23025-1-f4bug@amsat.org>
References: <20171023213359.23025-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] tpm: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

else files including "sysemu/tpm.h" fail to compile:

  In file included from qemu/stubs/tpm.c:2:0:
  qemu/include/sysemu/tpm.h:36:19: error: implicit declaration of function ‘object_resolve_path_type’ [-Werror=implicit-function-declaration]
       Object *obj = object_resolve_path_type("", TYPE_TPM_TIS, NULL);
                     ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/tpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index c8afa179e5..d7a2bd8556 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -13,6 +13,7 @@
 #define QEMU_TPM_H
 
 #include "qemu/option.h"
+#include "qom/object.h"
 
 typedef struct TPMState TPMState;
 
-- 
2.15.0.rc1
