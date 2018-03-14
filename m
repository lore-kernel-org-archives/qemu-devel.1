Received: from eggs.gnu.org ([2001:4830:134:3::10]:53479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mI-0002fQ-KO
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mD-00019j-Iv
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:18 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com
	([104.47.40.105]:27552
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ew7mD-00018f-6b
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:13 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 14 Mar 2018 07:52:40 -0700
Message-Id: <1521039163-138-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] WHPX introduce changes for Windows Insider
 SDK 17110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

This change set fixes two breaking changes that were introduced in the
Windows Insider SDK 17110. First, a change to the WHvGetCapability function
decl to include the 'out' WrittenSizeInBytes. Second, changes to the
WHvSetPartitionProperty function decl and WHV_PARTITION_PROPERTY structure
to directly pass the PropertyCode at invocation.

Lastly, it introduces a major performance improvement in whpx_vcpu_post_run
using the VpContext exit structure rather than another round trip call to
WHvGetVirtualProcessorRegisters to synchronize vp state.

QEMU compiled against this SDK (17110+) is expected to work on all Windows
Insider Builds (17115+).

Thanks,
Justin Terry

Justin Terry (VM) (3):
  WHPX fix WHvGetCapability out WrittenSizeInBytes
  WHPX fix WHvSetPartitionProperty in PropertyCode
  WHPX improve vcpu_post_run perf

 configure              |  4 +++-
 target/i386/whpx-all.c | 46 ++++++++++++++--------------------------------
 2 files changed, 17 insertions(+), 33 deletions(-)

-- 
2.13.6
