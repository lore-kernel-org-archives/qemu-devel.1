Received: from eggs.gnu.org ([2001:4830:134:3::10]:58014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVZ-0001b9-Ed
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVW-0001y6-R3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fnjVW-0001xT-I8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:34 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  9 Aug 2018 19:53:26 +0800
Message-Id: <1533815609-37245-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 0/3] x86: QEMU side support on MSR based
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

Changelog:
v2: coding style changes to pass ./scripts/checkpatch.pl.
----------------
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
