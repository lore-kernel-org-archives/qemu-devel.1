Received: from eggs.gnu.org ([2001:4830:134:3::10]:55603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJn2-0001YO-2w
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJmy-000325-Uw
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZJmy-00031g-P2
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  2 Feb 2017 15:59:07 +0000
Message-Id: <20170202155909.31784-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Postcopy fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: zhang.zhanghailiang@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  These are a couple of postcopy fixes for failure paths;
The first is a pretty harmless assert, it happens on the destination
when it discovers that it's got an incoming postcopy but
it can't support it - it was going to exit anyway.

The second is more useful and fixes an assert on the source
in the small window where a postcopy that's starting up fails
and tries to recover the source.

Dave

Dr. David Alan Gilbert (2):
  Postcopy: Reset state to avoid cleanup assert
  postcopy: Recover block devices on early failure

 migration/migration.c | 25 +++++++++++++++++++++++++
 migration/savevm.c    |  1 +
 2 files changed, 26 insertions(+)

-- 
2.9.3
