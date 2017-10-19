Received: from eggs.gnu.org ([2001:4830:134:3::10]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NJ-0000kz-Ul
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NF-0003Bh-TC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e54NF-0003BI-NR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93A5761470
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:32:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Oct 2017 14:31:56 +0800
Message-Id: <20171019063200.19048-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] migration: fixes and cleanups for ram
 state init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

I saw some leaks during ram setup, so trying to fix them.  Since at
it, I cleaned up the ram init phase a bit along with ram cleanup.

Please review.  Thanks,

Peter Xu (4):
  migration: provide ram_state_init()
  migration: provide ram_state_cleanup
  migration: clean up xbzrle cache init/destroy
  migration: new ram_init_bitmaps()

 migration/ram.c | 194 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 128 insertions(+), 66 deletions(-)

-- 
2.13.5
