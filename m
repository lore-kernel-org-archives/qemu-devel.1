Received: from eggs.gnu.org ([2001:4830:134:3::10]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNu-0003jC-Hc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNr-0005qH-5T
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYNq-0005q1-Vg
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A3FCC04B333
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:15:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:15:47 +0200
Message-Id: <20170601221552.30628-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Create setup/cleanup methods for migration
 incoming side
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

This series make:
- use of cleanup/save methods generic, not only for save_live methods
- create the equivalent methods for the load side (load_setup/cleanup)
- Make ram use this methods to see how/when they are used.

Stefan, Kevin, this were the methods that you asked for the block.c
migration, right?  Please, comment if they are enough for you.

This are on top of the ramstate_dynamic series that I just posted.

Please, review.

Later, Juan.

Juan Quintela (5):
  migration: Rename save_live_setup() to save_setup()
  migration: Rename cleanup() to save_cleanup()
  migration: Create load_setup()/cleanup() methods
  migration: Convert ram to use new load_setup()/load_cleanup()
  migration: Make compression_threads use save/load_setup/cleanup()

 hw/ppc/spapr.c               |  4 +--
 include/migration/register.h |  6 ++--
 migration/block.c            |  4 +--
 migration/migration.c        |  8 ------
 migration/ram.c              | 66 ++++++++++++++++++++++++++++++--------------
 migration/ram.h              |  6 ----
 migration/savevm.c           | 41 +++++++++++++++++++++++----
 7 files changed, 89 insertions(+), 46 deletions(-)

-- 
2.9.4
