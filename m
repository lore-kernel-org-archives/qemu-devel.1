Received: from eggs.gnu.org ([2001:4830:134:3::10]:47709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9go-0003CG-9k
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9gj-0002Ec-E8
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9gj-0002ES-8F
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B20F61D2D
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:50:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:50:23 +0100
Message-Id: <20170323205025.12113-1-quintela@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] Disable hotplug during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

This series disable hotplug/unplug during migration.  Thank to Markus
for explaining where I had to put the checks.  Why?  Because during
migration we will fail if there are changes.  For instance, in
postcopy, if we add a memory region, we would failing.  Same for other
devices if they are not setup exactly the same on destination.

Iidea would be to disable it, andthen enable for the thing that we know that work.

This series are on top of my previous RAMState v2 serie.

Commets, please?

Thanks, Juan.


Juan Quintela (2):
  migration: Disable hotplug/unplug during migration
  ram: remove migration_bitmap_extend()

 exec.c                  |  1 -
 hw/core/qdev.c          |  5 +++++
 include/exec/ram_addr.h |  2 --
 migration/ram.c         | 34 ----------------------------------
 qdev-monitor.c          |  7 ++++++-
 5 files changed, 11 insertions(+), 38 deletions(-)

-- 
2.9.3
