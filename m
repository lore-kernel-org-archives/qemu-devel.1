Received: from eggs.gnu.org ([2001:4830:134:3::10]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cly1Q-0002dD-Rv
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cly1M-0003ec-05
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cly1L-0003eR-Q8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:19 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  9 Mar 2017 13:22:14 +0000
Message-Id: <20170309132216.23482-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] migration/postcopy: Disable shared RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: pbonzini@redhat.com, lvivier@redhat.com, pasic@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Disable postcopy migration when there's shared RAM, we're
still figuring out the details.  Without this patch
there's a chance it might appear to succeed in some
cases.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

v2
  Make sure user-only build works (Halil)

Dr. David Alan Gilbert (2):
  RAMBlocks: qemu_ram_is_shared
  postcopy: Check for shared memory

 exec.c                    |  5 +++++
 include/exec/cpu-common.h |  1 +
 migration/postcopy-ram.c  | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

-- 
2.9.3
