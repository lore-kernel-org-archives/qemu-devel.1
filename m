Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA7-0007TL-Ew
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA6-0005cL-EG
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:59 -0500
Received: from mail.kernel.org ([198.145.29.136]:47928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA6-0005cD-8V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:58 -0500
Date: Tue, 10 Jan 2017 07:39:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-14-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/41] doc/pcie: correct command line examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

Nit picking: Multi-function PCI Express Root Ports should mean that
'addr' property is mandatory, and slot is optional because it defaults
to 0, and 'chassis' is mandatory for 2nd & 3rd root port because it
defaults to 0 too.

Bonus: fix a typo(2->3)
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/pcie.txt b/docs/pcie.txt
index 9fb20aa..5bada24 100644
--- a/docs/pcie.txt
+++ b/docs/pcie.txt
@@ -110,18 +110,18 @@ Plug only PCI Express devices into PCI Express Ports.
           -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
           -device <dev>,bus=root_port1
 2.2.2 Using multi-function PCI Express Root Ports:
-      -device ioh3420,id=root_port1,multifunction=on,chassis=x,slot=y[,bus=pcie.0][,addr=z.0] \
-      -device ioh3420,id=root_port2,chassis=x1,slot=y1[,bus=pcie.0][,addr=z.1] \
-      -device ioh3420,id=root_port3,chassis=x2,slot=y2[,bus=pcie.0][,addr=z.2] \
-2.2.2 Plugging a PCI Express device into a Switch:
+      -device ioh3420,id=root_port1,multifunction=on,chassis=x,addr=z.0[,slot=y][,bus=pcie.0] \
+      -device ioh3420,id=root_port2,chassis=x1,addr=z.1[,slot=y1][,bus=pcie.0] \
+      -device ioh3420,id=root_port3,chassis=x2,addr=z.2[,slot=y2][,bus=pcie.0] \
+2.2.3 Plugging a PCI Express device into a Switch:
       -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
       -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]          \
       -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]] \
       -device <dev>,bus=downstream_port1
 
 Notes:
-  - (slot, chassis) pair is mandatory and must be
-     unique for each PCI Express Root Port.
+  - (slot, chassis) pair is mandatory and must be unique for each
+    PCI Express Root Port. slot defaults to 0 when not specified.
   - 'addr' parameter can be 0 for all the examples above.
 
 
-- 
MST
