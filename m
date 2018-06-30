Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96U-0004aj-PD
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96T-0002z8-QV
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:26 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96T-0002x4-J0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:25 -0400
Received: by mail-wr0-x235.google.com with SMTP id f16-v6so10646417wrm.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:34 +0200
Message-Id: <20180630061040.6018-42-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/47] cutils: Do not include "qemu/units.h"
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

All files using "qemu/units.h" definitions already include it directly,
we can now remove it from "qemu/cutils.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Message-Id: <20180625124238.25339-41-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cutils.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 056e662..cdb0f0d 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -2,7 +2,6 @@
 #define QEMU_CUTILS_H
 
 #include "qemu/fprintf-fn.h"
-#include "qemu/units.h"
 
 /**
  * pstrcpy:
-- 
1.8.3.1
