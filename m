Received: from eggs.gnu.org ([2001:4830:134:3::10]:52859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjBI-0003Mh-DE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjBF-0000wD-5z
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:32:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:42133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fnjBE-0000vb-TP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:32:37 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  9 Aug 2018 19:32:26 +0800
Message-Id: <1533814349-34727-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 0/3] x86: QEMU side support on MSR based
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: robert.hu@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

KVM side has added the framework (kvm.git:d1d93fa90) to support MSR based features.
Here is the QEMU part, including data structure changes/expanding, referring
functions changes, and the implementations on 
KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl.

Robert Hoo (3):
  x86: Data structure changes to support MSR based features
  kvm: Add support to KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS
    system ioctl
  Change other funcitons referring to feature_word_info[]

 include/sysemu/kvm.h |   2 +
 target/i386/cpu.c    | 209 +++++++++++++++++++++++++++++++++++++--------------
 target/i386/cpu.h    |   5 ++
 target/i386/kvm.c    |  78 +++++++++++++++++++
 4 files changed, 236 insertions(+), 58 deletions(-)

-- 
1.8.3.1
