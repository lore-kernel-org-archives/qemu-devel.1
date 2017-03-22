Received: from eggs.gnu.org ([2001:4830:134:3::10]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhVz-00011q-TQ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhVw-0000S3-JP
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqhVw-0000RV-Dv
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 303E8C05AA52
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 14:45:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 22 Mar 2017 09:45:22 -0500
Message-Id: <20170322144525.18964-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Fix QemuOpts regression on bogus keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, lvivier@redhat.com

Reported to me off-list by Laurent Vivier, who found the
problem while working on https://bugzilla.redhat.com/1433193;
now split into https://bugzilla.redhat.com/show_bug.cgi?id=1434666.
Broken since 2.7, but the fix is a one-liner (pointing out my
embarrassing mistake of mis-converting a pre-decrement operator);
as a bug fix, it still qualifies for 2.9 in spite of hard freeze,
on the other hand, as the regression was not introduced in 2.9,
I also understand if it is postponed.

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04072.html
v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04275.html

Since then:
- more commit message tweaks
- drop a spurious hunk from the test in commit 3

Eric Blake (3):
  tests: Expose regression in QemuOpts visitor
  qom: Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts
  qapi: Fix QemuOpts visitor regression on unvisited input

 qapi/opts-visitor.c       |  6 +++---
 qom/object_interfaces.c   |  7 ++++---
 tests/test-opts-visitor.c | 27 +++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.9.3
