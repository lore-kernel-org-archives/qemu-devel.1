Received: from eggs.gnu.org ([2001:4830:134:3::10]:42295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCb-0006Ih-KQ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCa-00071R-S6
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Oct 2017 09:20:42 -0300
Message-Id: <20171024122045.30072-2-f4bug@amsat.org>
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
References: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] tpm: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

else file including "sysemu/tpm.h" fails to compile:

  In file included from qemu/stubs/tpm.c:2:0:
  qemu/include/sysemu/tpm.h:36:19: error: implicit declaration of function ‘object_resolve_path_type’ [-Werror=implicit-function-declaration]
       Object *obj = object_resolve_path_type("", TYPE_TPM_TIS, NULL);
                     ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
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
