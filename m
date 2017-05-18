Received: from eggs.gnu.org ([2001:4830:134:3::10]:48521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNRD-0002nt-3l
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNR8-00006F-7A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBNR8-00005t-0w
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:33:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A693E624DC
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:33:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 17:33:48 +0200
Message-Id: <20170518153350.30094-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Make migration/savevm.c target
 independent
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

Changes for v2
- Make copyright notice correct (dave)

Please, review.


[v1]
Only reason that ram.c is compiled by target is because it use
TARGET_PAGE_BITS.  As we already have a function to export
TARGET_PAGE_SIZE, do the same.
After this, we can make it target independent.

Juan Quintela (2):
  exec: Create include for target_page_size()
  migration: Make savevm.c target independent

 Makefile.target            |  2 +-
 exec.c                     | 10 ++++++++++
 include/exec/target_page.h | 21 +++++++++++++++++++++
 include/sysemu/sysemu.h    |  1 -
 migration/Makefile.objs    |  2 +-
 migration/migration.c      |  1 +
 migration/postcopy-ram.c   |  1 +
 migration/savevm.c         | 15 ++++++++-------
 8 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 include/exec/target_page.h

-- 
2.9.3
