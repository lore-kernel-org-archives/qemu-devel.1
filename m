Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpW-00048Q-39
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dbEpU-0002OE-7r
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:02 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dbEpT-0002Nb-W4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:38:00 -0400
Received: by mail-lf0-x244.google.com with SMTP id y15so11400961lfd.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:37:59 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sat, 29 Jul 2017 02:37:49 +0300
Message-Id: <1501285073-2215-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Unmask previously masked SHPC feature in _OSC method.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade..2ab32f9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1848,9 +1848,9 @@ static Aml *build_q35_osc_method(void)
 
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
