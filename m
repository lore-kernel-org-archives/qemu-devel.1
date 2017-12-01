Received: from eggs.gnu.org ([2001:4830:134:3::10]:54956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoJR-0005Bh-Tm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoJP-0003YV-64
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoJO-0003XU-RG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:37:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD0336A7E4
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:57:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:57:25 +0100
Message-Id: <20171201125728.1310-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Migration patches on queue for 2.12
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

Sending them because my next series are on top of this ones.

Later, Juan.

Juan Quintela (3):
  migration: Use proper types in json
  migration: print features as on off
  migration: free addr in the same function that we created it

 hmp.c                 | 22 +++++++++---------
 migration/migration.c | 62 ++++++++++++++++++++++++---------------------------
 migration/socket.c    |  4 ++--
 qapi/migration.json   | 20 ++++++++---------
 4 files changed, 52 insertions(+), 56 deletions(-)

-- 
2.14.3
