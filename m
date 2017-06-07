Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIYfL-0004F1-Ax
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIYfI-00018y-Ba
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIYfI-00017c-5h
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F303D80470
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 10:58:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 12:58:08 +0200
Message-Id: <20170607105810.3003-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Make info migrate output consistent
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

Changes for v2:
- patches 1 & 2 in previous pull requset
- create function populate_disk_info (dave suggestion)

Please, review.

Thanks, Juan.

[v1]
This series make the output of info migrate be printed in a single
place for the states ACTIVE, CANCELLING and POSTCOPY_ACTIVE.

The code was duplicated, just use the same code.  Once done that, fix
the inconsistences that were not needed.


Juan Quintela (2):
  ram: Print block stats also in the complete case
  ram: Now POSTCOPY_ACTIVE is the same that STATUS_ACTIVE

 migration/migration.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

-- 
2.9.4
