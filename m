Received: from eggs.gnu.org ([2001:4830:134:3::10]:58618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJ5b-0000Fm-2Q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJ5Y-0000Y6-17
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:51:11 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:46541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJ5X-0000Wn-SP
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:51:07 -0400
Received: by mail-qt0-x22f.google.com with SMTP id h5-v6so10569866qtm.13
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 09:51:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 30 Jun 2018 13:50:57 -0300
Message-Id: <20180630165057.21632-1-f4bug@amsat.org>
In-Reply-To: <CABgObfazhaOHnDT_Le6aPd0_SNDXOcfQrnj+zU5mf-akmyjNZA@mail.gmail.com>
References: <CABgObfazhaOHnDT_Le6aPd0_SNDXOcfQrnj+zU5mf-akmyjNZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] !fixup 052f529eb3d07170b18b8d0920bc8c450e389a2f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This was in e9dd993d-875f-4173-f68e-e6b4e75e3aa1@amsat.org but I can't
find it on the list...

 tests/test-cutils.c    | 2 +-
 tests/test-qemu-opts.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index a6e5fe4984..d85c3e0f6d 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index fd4d848f66..43869cb754 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qapi/error.h"
-- 
2.18.0
