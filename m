Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fadkd-0001hI-OW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fadkY-0007OK-JZ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:07:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:53501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fadkY-0007Nl-8s
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:06:58 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed,  4 Jul 2018 17:06:34 +0800
Message-Id: <1530695199-27601-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 0/5] Add Icelake CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

This patch set defines the new guest CPU models of Icelake.

The first patch defines new indices for IA32_PRED_CMD MSR (IBPB) and IA32_ARCH_CAPABILITIES MSR.
Other patches add CPUID bits feature words for new features, like PCONFIG,
WBNOINVD. The final patch defines Icelake-{Server,Client} CPU models.

Changelog:
v3
	Remove ARCH_CAPABILITIES from Icelake CPU model, at present. Going to
compose a separate patch to do 1) qemu set ARCH_CAPABILITES MSR with some default
value. 2) expand current CPU feature expression frame work from CPUID features
only to MSR bit included as well.
	Fix some patch format error and update some trivial patch descrptions.
v2
	Per Paolo's comment, remove unnecessary CPU vmstate check for write/read only
IA32_PRED_CMD and IA32_ARCH_CAPABILITIES MSRs.

Robert Hoo (5):
  i386: Add new MSR indices for IA32_PRED_CMD and IA32_ARCH_CAPABILITIES
  i386: Add CPUID bit and feature words for IA32_ARCH_CAPABILITIES MSR
  i386: Add CPUID bit for PCONFIG
  i386: Add CPUID bit for WBNOINVD
  i386: Add new CPU model Icelake-{Server,Client}

 target/i386/cpu.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h |   6 +++
 2 files changed, 124 insertions(+), 3 deletions(-)

-- 
1.8.3.1
