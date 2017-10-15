Received: from eggs.gnu.org ([2001:4830:134:3::10]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX3-00035T-9A
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX2-0007D4-Ci
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZX2-0007Cd-6Q
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:04 -0400
Date: Sun, 15 Oct 2017 06:24:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-25-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 24/26] isapc: Remove unnecessary migration
 compatibility code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Eduardo Habkost <ehabkost@redhat.com>

We don't touch isapc when we change guest ABI and add new entries
to PC_COMPAT_* or new PCMachineClass compat flags.  This means
isapc never guaranteed guest ABI and cross-QEMU-version live
migration compatibility.  There's no point in keeping code for
kvm-pv-eoi and APIC ID compatibility in pc_init_isa().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1a56465..9dbcbcd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -378,8 +378,6 @@ static void pc_compat_0_13(MachineState *machine)
 
 static void pc_init_isa(MachineState *machine)
 {
-    x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
-    enable_compat_apic_id_mode();
     pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
 }
 
-- 
MST
