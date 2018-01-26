Received: from eggs.gnu.org ([2001:4830:134:3::10]:47700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBjA-0004Vy-0N
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBj6-00018I-T5
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:04 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com
	([104.47.34.49]:61546
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1efBj6-00017B-G5
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:00 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 26 Jan 2018 16:39:39 -0500
Message-Id: <20180126213944.7594-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/5] Enable TOPOEXT to support hyperthreading
 on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pixo@polepetko.eu
Cc: mtosatti@redhat.com, babu.moger@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

These series enable TOPOEXT feature on AMD CPU. These are required to support
hyperthreading on kvm guests. 

Stanislav Lanci posted few patches earlier. 
https://patchwork.kernel.org/patch/10040903/

Rebased his patches with few changes.
1. Spit the patches into two, separating cpuid functions 
   0x8000001D and 0x8000001E (Patch 2 and 3).
2. Removed the generic non-intel check and made a separate patch
   with some changes(Patch 5).
3. Fixed L3_N_SETS_AMD(from 4096 to 8192) based on CPUID_Fn8000001D_ECX_x03.

Added 2 more patches.
Patch 1. Fixes cache associativity.
Patch 4. Adds TOPOEXT feature on AMD EPYC CPU.

Babu Moger (3):
  target/i386: Fix instruction cache associativity for AMD
  target/i386: Enable TOPOEXT feature on AMD EPYC CPU
  target/i386: Remove generic SMT thread check

Stanislav Lanci (2):
  target/i386: Populate AMD Processor Cache Information
  target/i386: Add support for CPUID_8000_001E for AMD

 target/i386/cpu.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 target/i386/kvm.c |  29 +++++++++++++--
 2 files changed, 122 insertions(+), 11 deletions(-)

-- 
2.16.0
