Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYEB-0007p6-6u
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYE7-0007o4-8e
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 31 Jan 2017 14:11:57 +0100
Message-Id: <1485868319-16151-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] ppc: Fix problems with duplicated CPU
 family types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

The following two patches fix two rather cosmetic than severe issues
that we currently have with registering the CPU "family" types:

1) In the 'query-cpu-definitions' QMP call, there are currently two
   conflicting "POWER8" entries in the results list.

2) When running QEMU with "-cpu ?" on POWER8E or POWER8NVL, you always
   get a wrong and confusing entry for the "POWER8" alias.

Please see the description of the first patch for more details.

Thomas Huth (2):
  ppc/kvm: Handle the "family" CPU via alias instead of registering new
    types
  vl: Print CPU help after we've registered the CPU accelerators

 target/ppc/kvm.c | 36 +++++++++++++++++++++++-------------
 vl.c             | 10 +++++-----
 2 files changed, 28 insertions(+), 18 deletions(-)

-- 
1.8.3.1
