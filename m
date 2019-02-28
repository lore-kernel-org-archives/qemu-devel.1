Received: from eggs.gnu.org ([209.51.188.92]:51515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnx-0001rG-MW
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnw-0007q8-9m
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnv-0007ek-OA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:53 +0100
Message-Id: <1551356875-30676-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] MAINTAINERS: Clean up the RISC-V TCG
 backend section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The e-mail address mjc@sifive.com of Michael is not valid anymore.
Commit 7d04ac38959f8115f2a02 removed the entry already from the main
RISC-V section, but apparently forgot to remove it from the TCG
backend section, too.

Fixes: 7d04ac38959f8115f2a029d81db1c8aac179aa95
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a6db6c..a4c7ebf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2254,7 +2254,6 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 RISC-V
-M: Michael Clark <mjc@sifive.com>
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
-- 
1.8.3.1
