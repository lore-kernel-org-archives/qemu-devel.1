Received: from eggs.gnu.org ([2001:4830:134:3::10]:60323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gt-0003IR-Er
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gs-0008HK-Nm
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:03 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2gs-0008GG-Fw
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:02 -0400
Received: by mail-lf0-x243.google.com with SMTP id y15so1361495lfd.5
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:16:02 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:15:39 +0300
Message-Id: <1500761743-1669-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/6] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Unmask previously masked SHPC feature in _OSC method.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade..0d99585 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1850,7 +1850,7 @@ static Aml *build_q35_osc_method(void)
      * Always allow native PME, AER (no dependencies)
      * Never allow SHPC (no SHPC controller in this system)
      */
-    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
+    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
 
     if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
     /* Unknown revision */
-- 
2.7.4
