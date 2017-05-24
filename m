Received: from eggs.gnu.org ([2001:4830:134:3::10]:44528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4n-0007ZL-Jk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4j-0006zd-Lg
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDS4j-0006zJ-GA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66CB661B84
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 08:55:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 24 May 2017 10:55:16 +0200
Message-Id: <20170524085519.22856-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Remove of loadvm handlers
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

We just have a loadvm handlers that are a new list only used in a
single place.  Just move everything to use the savevm_handlers (yes,
it is a list, and we could have a better name).

Once there, vmstate_load() had three arguments but only needs two.  Fix that.

Please, review.

Juan Quintela (3):
  migration: Use savevm_handlers instead of loadvm copy
  migration: loadvm handlers are not used
  migration: Remove section_id parameter from vmstate_load

 include/migration/migration.h |  5 ----
 include/migration/vmstate.h   |  2 --
 include/qemu/typedefs.h       |  1 -
 migration/migration.c         |  2 --
 migration/savevm.c            | 58 ++++++++++++-------------------------------
 5 files changed, 16 insertions(+), 52 deletions(-)

-- 
2.9.3
