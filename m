Received: from eggs.gnu.org ([2001:4830:134:3::10]:39335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fo842-0003C3-7I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fo83x-0002W4-Lk
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:34469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fo83x-0002Nv-CU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:45 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Fri, 10 Aug 2018 22:06:26 +0800
Message-Id: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 0/3] x86: QEMU side support on MSR based
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
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

KVM side has added the framework (kvm.git:d1d93fa90) to support MSR based features.
Here is the QEMU part, including data structure changes/expanding, referring
functions changes, and the implementations on 
KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl.

Changelog:
v3: patch 2&3 in v2 are corrupted. Re-format patches.
v2: coding style changes to pass ./scripts/checkpatch.pl.
----------------
Robert Hoo (3):
  x86: Data structure changes to support MSR based features
  kvm: Add support to KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS
    system ioctl
  Change other funcitons referring to feature_word_info[]

 include/sysemu/kvm.h |   2 +
 target/i386/cpu.c    | 210 +++++++++++++++++++++++++++++++++++++--------------
 target/i386/cpu.h    |   5 ++
 target/i386/kvm.c    |  79 +++++++++++++++++++
 4 files changed, 238 insertions(+), 58 deletions(-)

-- 
1.8.3.1
