Received: from eggs.gnu.org ([2001:4830:134:3::10]:58965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dtqlZ-0001Hj-8u
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dtqlW-0000xE-7Q
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:46:53 -0400
Received: from goliath.siemens.de ([192.35.17.28]:46657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dtqlV-0000wl-TN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:46:50 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77c55c6c-3397-5a32-6276-6b88f13fa531@siemens.com>
Date: Mon, 18 Sep 2017 09:46:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] seccomp: Fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

vl.c includes seccomp.h, thus requires the related CFLAGS as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index d9cf7ad791..4f1488d65d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -61,7 +61,7 @@ bt-host.o-cflags := $(BLUEZ_CFLAGS)
 
 common-obj-y += dma-helpers.o
 common-obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SECCOMP_CFLAGS)
 common-obj-y += tpm.o
 
 common-obj-$(CONFIG_SLIRP) += slirp/
-- 
2.12.3
