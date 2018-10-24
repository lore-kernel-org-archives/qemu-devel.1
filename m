Received: from eggs.gnu.org ([2001:4830:134:3::10]:50868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFGFT-0003gc-CR
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFGFP-0007wR-Qq
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:18:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 11:18:34 +0100
Message-Id: <1540376314-5727-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configs/alpha: Remove unused
 CONFIG_PARALLEL_ISA switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

We don't use CONFIG_PARALLEL_ISA in any of our Makefiles, so this
is just a dead config option which can be removed.

Fixes: a4cb773928e047b137c6998209cf2eec857fac6b
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/alpha-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index bbe361f..61435cc 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_I82374=y
 CONFIG_I8254=y
 CONFIG_I8257=y
 CONFIG_PARALLEL=y
-CONFIG_PARALLEL_ISA=y
 CONFIG_FDC=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
-- 
1.8.3.1
