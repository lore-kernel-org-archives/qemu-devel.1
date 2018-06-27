Received: from eggs.gnu.org ([2001:4830:134:3::10]:56266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bp-0005od-1T
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bk-0007xO-1s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:32714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fY8bj-0007vT-ON
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:31 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 27 Jun 2018 19:27:19 +0800
Message-Id: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Add Icelake CPU model
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

The first patch adds support of IA32_PRED_CMD MSR (IBPB) and IA32_ARCH_CAPABILITIES MSR.
Other patches add CPUID bits feature words for new features, like PCONFIG,
WBNOINVD. The final patch defines Icelake-{Server,Client} CPU models.

Changelog:
v2
	Per Paolo's comment, remove unnecessary CPU vmstate check for write/read only
IA32_PRED_CMD and IA32_ARCH_CAPABILITIES MSRs.

Robert Hoo (5):
  i386: Add support for IA32_PRED_CMD and IA32_ARCH_CAPABILITIES MSRs
  i386: Add CPUID bit and feature words for IA32_ARCH_CAPABILITIES MSR
  i386: Add CPUID bit for PCONFIG
  i386: Add CPUID bit for WBNOINVD
  i386: Add new CPU model Icelake-{Server,Client}

 target/i386/cpu.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h |   7 ++++
 target/i386/kvm.c |  27 +++++++++++-
 3 files changed, 152 insertions(+), 4 deletions(-)

-- 
1.8.3.1
