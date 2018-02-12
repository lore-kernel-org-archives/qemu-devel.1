Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elGa1-0008AN-Rk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elGZy-0001VN-QX
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elGZy-0001V5-M4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BC084084FE8
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 16:03:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Feb 2018 16:03:38 +0000
Message-Id: <20180212160340.15333-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migration: Fix early failure crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This fixes a crash for the case where a migration exits with an error
very early, this is probably due to my recent error handling change.

I also add a test to make sure this doesn't fail again, the test does
output one line of junk, suggestions for how to clean it up are welcome:

[dgilbert@dgilbert-t530 try]$ tests/migration-test 
/x86_64/migration/deprecated: OK
/x86_64/migration/bad_dest: qemu-system-x86_64: Failed to connect socket: Connection refused
OK
/x86_64/migration/postcopy/unix: OK

Dave

Dr. David Alan Gilbert (2):
  migration: Fix early failure cleanup
  tests/migration: Add test for migration to bad destination

 migration/ram.c        | 12 ++++++----
 tests/migration-test.c | 65 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 20 deletions(-)

-- 
2.14.3
