Received: from eggs.gnu.org ([2001:4830:134:3::10]:41816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyW-0008MF-0J
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyS-0001Fu-Ut
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clJyS-0001Fn-P2
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7D673D940
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 18:36:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  7 Mar 2017 18:36:35 +0000
Message-Id: <20170307183637.21245-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migration/postcopy: Disable shared RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: pbonzini@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Disable postcopy migration when there's shared RAM, we're
still figuring out the details.  Without this patch
there's a chance it might appear to succeed in some
cases.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dr. David Alan Gilbert (2):
  RAMBlocks: qemu_ram_is_shared
  postcopy: Check for shared memory

 exec.c                    |  5 +++++
 include/exec/cpu-common.h |  1 +
 migration/postcopy-ram.c  | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

-- 
2.9.3
