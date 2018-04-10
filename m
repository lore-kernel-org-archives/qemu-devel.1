Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5uo7-0002RV-TL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5uo2-0001OO-4r
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5uo2-0001OC-0z
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 938D6F8FD4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 15:03:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Apr 2018 16:03:28 +0100
Message-Id: <20180410150329.47586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit df6378eb0e6cfd58a22a1c3ff8fa4a9039f1eaa8:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180410-pull-request' into staging (2018-04-10 14:04:27 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180410a

for you to fetch changes up to a18a73d7472e6ff5bc1e5f7fb9f7a42464295d03:

  Revert "migration: Don't activate block devices if using -S" (2018-04-10 15:28:42 +0100)

----------------------------------------------------------------
Migration reversion pull for 2.12

One to revert after we decided it needs some more thinking.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      Revert "migration: Don't activate block devices if using -S"

 migration/migration.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)
