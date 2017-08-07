Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplX-0005Hb-5M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplS-0006Sy-Gv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1deplS-0006Sb-Ag
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:42 -0400
Date: Tue, 8 Aug 2017 00:40:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502142009-9370-2-git-send-email-mst@redhat.com>
References: <1502142009-9370-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502142009-9370-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandr Bezzubikov <zuban32s@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Aleksandr Bezzubikov <zuban32s@gmail.com>

Unmask previously masked SHPC feature in _OSC method.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b9c245c..98dd424 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1862,9 +1862,9 @@ static Aml *build_q35_osc_method(void)
 
     /*
      * Always allow native PME, AER (no dependencies)
-     * Never allow SHPC (no SHPC controller in this system)
+     * Allow SHPC (PCI bridges can have SHPC controller)
      */
-    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
+    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
 
     if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
     /* Unknown revision */
-- 
MST
