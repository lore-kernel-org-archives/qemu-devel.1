Received: from eggs.gnu.org ([2001:4830:134:3::10]:37301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq7-0007oK-9J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq2-0006YX-CR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXq1-0006Xs-Vc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF977E9C0
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:41:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:40:52 +0200
Message-Id: <20170601214056.30387-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Make info migrate output consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This series make the output of info migrate be printed in a single
place for the states ACTIVE, CANCELLING and POSTCOPY_ACTIVE.

The code was duplicated, just use the same code.  Once done that, fix
the inconsistences that were not needed.

Please, review.

Thanks, Juan.

Juan Quintela (4):
  ram: Unfold get_xbzrle_cache_stats() into populate_ram_info()
  ram: We only print throttling information sometimes
  ram: Print block stats also in the complete case
  ram: Now POSTCOPY_ACTIVE is the same that STATUS_ACTIVE

 migration/migration.c | 77 ++++++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 53 deletions(-)

-- 
2.9.4
