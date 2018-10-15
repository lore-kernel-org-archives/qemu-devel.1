Received: from eggs.gnu.org ([2001:4830:134:3::10]:52015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gBun5-0008Up-RP
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gBumz-00017e-LZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:20045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gBumy-00015F-Ra
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 00:47:33 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Mon, 15 Oct 2018 12:47:22 +0800
Message-Id: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v5 0/3] x86: QEMU side support on MSR based
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

KVM side has added the framework (kvm.git:d1d93fa90) to support MSR based features.
Here is the QEMU part, including data structure changes/expanding, referring
functions changes, and the implementations on 
KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl.

Changelog:
v5: Re-order patches. Complement feature MSR set routines.
v4:
	Re-organize patch set to conform to request of individually build pass.
	Add KVM capability check for KVM_GET_MSR_INDEX_LIST before fetch.
	Special treatment for MSR_IA32_ARCH_CAPABILITIES.RSBA.
	Use more convenient glib wrapper (g_strdup_printf) instead of native
(sprintf).
	
v3: patch 2&3 in v2 are corrupted. Re-format patches.
v2: coding style changes to pass ./scripts/checkpatch.pl.


Robert Hoo (3):
  kvm: Add support to KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS
    system ioctl
  x86: Data structure changes to support MSR based features
  x86: define a new MSR based feature word --
    FEATURE_WORDS_ARCH_CAPABILITIES

 include/sysemu/kvm.h |   2 +
 target/i386/cpu.c    | 217 +++++++++++++++++++++++++++++++++++++++------------
 target/i386/cpu.h    |   8 ++
 target/i386/kvm.c    |  91 +++++++++++++++++++++
 4 files changed, 266 insertions(+), 52 deletions(-)

-- 
1.8.3.1
