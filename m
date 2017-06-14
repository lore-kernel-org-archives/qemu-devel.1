Received: from eggs.gnu.org ([2001:4830:134:3::10]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dKytJ-00043x-B2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dKytG-0003gI-1X
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:22:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:57825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dKytF-0003dC-Ot
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:22:41 -0400
Date: Wed, 14 Jun 2017 11:22:32 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170614032232.GA1330@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] About remove the TCG related code in
 hw/i386/kvmvapic.c!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, yang.zhong@intel.com

Hello Paolo,

About you below A20 fixed patch has been merged in QEMU latest release,

commit bbfa326fc8028e275eddf8c9965c2a1b59405b2e
target/i386: enable A20 automatically in system management mod 

I also disabled the kvmvapic rom with below patch and use qemu command to verify your patch

#disable kvmapic rom patch
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 1ef56f8..72c5bd6 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -440,7 +440,7 @@ static const VMStateDescription vmstate_apic_common = {
 static Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
-                    true),
+                    false),
     DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
                      false),
     DEFINE_PROP_END_OF_LIST(),

#the pure tcg to boot image
./qemu-system-x86_64 -m 2G -smp cpus=4,cores=4,threads=1,sockets=1 -drive format=raw,file=eywa.img,index=0,media=disk -nographic -serial stdio -nodefaults

The image can be booted up normally now.

This verification show the TCG related code in kvmvapic.c file are NOT useful, my plan is to delete those TCG code in kvmvapic.c file, what's your comments?  Many thanks!


Regards,

Yang
