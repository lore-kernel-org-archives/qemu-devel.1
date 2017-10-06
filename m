Received: from eggs.gnu.org ([2001:4830:134:3::10]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Sct-0005qc-Gj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Sco-0006UV-O2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0Sco-0006T7-IC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:25:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB47CC0587F5
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 13:25:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 10:25:02 -0300
Message-Id: <20171006132502.9191-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] isapc: Remove unnecessary migration
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

We don't touch isapc when we change guest ABI and add new entries
to PC_COMPAT_* or new PCMachineClass compat flags.  This means
isapc never guaranteed guest ABI and cross-QEMU-version live
migration compatibility.  There's no point in keeping code for
kvm-pv-eoi and APIC ID compatibility in pc_init_isa().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9ff79b1fd9..31646e63c4 100644
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
2.13.6
