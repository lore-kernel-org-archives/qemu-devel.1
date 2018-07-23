Received: from eggs.gnu.org ([2001:4830:134:3::10]:38390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1c-0003af-An
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1Y-0004n5-E2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fha1Y-0004mh-8n
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 839D440241C4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:33:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Jul 2018 20:33:01 +0800
Message-Id: <20180723123305.24792-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 0/4] migration: some fixes for
 release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The release-ram feature is broken.  Fix it up.  Meanwhile disable
postcopy recovery when release-ram is enabled, since they cannot work
together.  Please see the comments for more information.

This patchset is for 3.0.

Please review, thanks.

Peter Xu (4):
  migration: update recv bitmap only on dest vm
  migration: disallow recovery for release-ram
  tests: only update last_byte when at the edge
  tests: torture release-ram in postcopy test

 migration/migration.c  | 19 +++++++++++++++++++
 migration/ram.c        | 11 +++++++++--
 tests/migration-test.c | 16 +++++++++++-----
 3 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.17.1
