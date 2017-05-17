Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1Uj-00073L-72
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1Ue-00006k-RG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB1Ue-00006Q-Ky
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:08:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B436A20B1A
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:08:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 18:08:02 +0200
Message-Id: <20170517160804.22245-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Make migration/ram.c target independent
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

Only reason that ram.c is compiled by target is because it use
TARGET_PAGE_BITS.  As we already have a function to export
TARGET_PAGE_SIZE, do the same.
After this, we can make it target independent.

Please, review.

Later, Juan.




Juan Quintela (2):
  exec: Create include for target_page_size()
  migration: Make savevm.c target independent

 Makefile.target            |  2 +-
 exec.c                     | 10 ++++++++++
 include/exec/target_page.h | 22 ++++++++++++++++++++++
 include/sysemu/sysemu.h    |  1 -
 migration/Makefile.objs    |  2 +-
 migration/migration.c      |  1 +
 migration/postcopy-ram.c   |  1 +
 migration/savevm.c         | 15 ++++++++-------
 8 files changed, 44 insertions(+), 10 deletions(-)
 create mode 100644 include/exec/target_page.h

-- 
2.9.3
