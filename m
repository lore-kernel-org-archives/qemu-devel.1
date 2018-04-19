Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANO-0004ex-O1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANN-00064r-Tt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:30 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANN-00064P-M5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:29 -0400
Received: by mail-wr0-x241.google.com with SMTP id o15-v6so14509463wro.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:56 +0100
Message-Id: <20180419135901.30035-39-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v2 38/43] osdep: disable glib-compat.h include
 with QEMU_NO_GLIB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

To ease the cross-compilation of tests that do not use glib.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/osdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 41658060a7..fabaf73007 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -104,7 +104,9 @@ extern int daemon(int, int);
 #include "sysemu/os-posix.h"
 #endif
 
+#ifndef QEMU_NO_GLIB
 #include "glib-compat.h"
+#endif
 #include "qemu/typedefs.h"
 
 /*
-- 
2.17.0
