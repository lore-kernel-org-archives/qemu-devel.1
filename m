Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzks-0000Z2-Vn
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzks-0002EO-3d
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFzkr-0002EB-Tk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0883B883B1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:17:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 11:17:17 +0200
Message-Id: <20170531091720.21697-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3]  Remove of loadvm handlers
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

Changes from v2
- also store load_section_id (dave found the problem)

I think that we can remove it now, at least.

Thanks, Juan.

[v2]
- store load_version_id field to SaveStateHandler
- Adjust everything to use it

Thanks to Laurent to point that to me.

[v1]
We just have a loadvm handlers that are a new list only used in a
single place.  Just move everything to use the savevm_handlers (yes,
it is a list, and we could have a better name).

Once there, vmstate_load() had three arguments but only needs two.  Fix that.

Juan Quintela (3):
  migration: Use savevm_handlers instead of loadvm copy
  migration: loadvm handlers are not used
  migration: Remove section_id parameter from vmstate_load

 include/migration/migration.h |  5 ----
 include/migration/vmstate.h   |  2 --
 include/qemu/typedefs.h       |  1 -
 migration/migration.c         |  2 --
 migration/savevm.c            | 64 +++++++++++++++----------------------------
 5 files changed, 22 insertions(+), 52 deletions(-)

-- 
2.9.4
