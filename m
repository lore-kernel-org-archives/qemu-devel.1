Received: from eggs.gnu.org ([2001:4830:134:3::10]:36712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cmFBs-00040B-6E
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cmFBn-0003zv-5X
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:42:20 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cmFBm-0003xU-Us
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:42:15 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so4249200wma.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 23:42:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Mar 2017 07:42:18 +0000
Message-Id: <20170310074218.5372-1-alex.bennee@linaro.org>
In-Reply-To: <20170303131113.25898-3-pbonzini@redhat.com>
References: <20170303131113.25898-3-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! qemu-timer: do not include
 sysemu/cpus.h from util/qemu-timer.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "open list:PowerPC" <qemu-ppc@nongnu.org>

---
 hw/ppc/pnv.c             | 1 +
 target/alpha/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09f0d22def..3fa722af82 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/cpus.h"
 #include "hw/hw.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 055286a7b8..df5d695344 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "sysemu/cpus.h"
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
-- 
2.11.0
