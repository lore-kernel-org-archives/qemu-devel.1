Received: from eggs.gnu.org ([2001:4830:134:3::10]:48404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9l-0003wp-Uo
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9i-0005kC-Gs
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gZc9i-0005da-4k
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:44:58 -0500
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 19 Dec 2018 21:44:39 +0800
Message-Id: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 0/2] Revert exposure of PCONFIG to guest
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

PCONFIG is not supposed to be exposed to guest. These 2 patches fix this.

Robert Hoo (2):
  i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model
  Revert "i386: Add CPUID bit for PCONFIG"

 target/i386/cpu.c | 5 ++---
 target/i386/cpu.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
1.8.3.1
