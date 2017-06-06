Received: from eggs.gnu.org ([2001:4830:134:3::10]:58320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlK-0006h9-4F
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlG-00060B-JT
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIBlG-0005zv-Cy
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFDE43DEEB
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:30:52 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Jun 2017 18:30:36 +0800
Message-Id: <1496745042-2379-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

I picked this topic out as suggested by Juan. Also I did what Juan has
suggested in previous discussions that I moved lots of global
parameters into MigrationState, and let them be properties. Then we
can use HW_COMPAT_* and "-global migration.xxx=xxx" formular.

If without xen_init(), we can remove more LOC. However there is it, so
I changed the bits as best as I can.

If this can be merged and okay, we can move on to convert more things
into properties for migration.

Please review. Thanks.

Peter Xu (6):
  migration: let MigrationState be a qdev
  migration: move global_state.optional out
  migration: use compat bit for global_state
  migration: move only_migratable to MigrationState
  migration: move skip_configuration out
  migration: move skip_section_footers

 hw/i386/pc_piix.c             |  3 --
 hw/ppc/spapr.c                |  3 --
 include/hw/compat.h           | 12 ++++++
 include/migration/migration.h | 33 +++++++++++++++++
 include/sysemu/sysemu.h       |  1 -
 migration/migration.c         | 85 +++++++++++++++++++++++++++++++------------
 migration/savevm.c            | 22 +++++------
 vl.c                          |  9 ++++-
 8 files changed, 123 insertions(+), 45 deletions(-)

-- 
2.7.4
