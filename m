Received: from eggs.gnu.org ([2001:4830:134:3::10]:42909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPC-0008DS-Fe
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmP6-0007Se-W6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:30 +0100
Message-Id: <20181211180352.19644-9-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/30] MAINTAINERS: Add nios2-related files to
 the Nios2 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

nios2_iic.c and the default-configs/nios2-softmmu.mak file are
currently "unmaintained" according to the get_maintainers.pl script.
Move them to the Nios2 section where they obviously belong to.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1542899500-23346-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 059c775a06..f5ef20d359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,7 +233,9 @@ M: Marek Vasut <marex@denx.de>
 S: Maintained
 F: target/nios2/
 F: hw/nios2/
+F: hw/intc/nios2_iic.c
 F: disas/nios2.c
+F: default-configs/nios2-softmmu.mak
 
 OpenRISC
 M: Stafford Horne <shorne@gmail.com>
-- 
2.19.2
