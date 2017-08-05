Received: from eggs.gnu.org ([2001:4830:134:3::10]:56882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5g1-0006AA-0E
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1de5fy-00052o-G4
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:28:01 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1de5fy-0004y8-9K
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 16:27:58 -0400
Received: by mail-lf0-x241.google.com with SMTP id t128so3078172lff.3
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 13:27:55 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat,  5 Aug 2017 23:27:34 +0300
Message-Id: <1501964858-5159-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v4 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Unmask previously masked SHPC feature in _OSC method.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
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
2.7.4
