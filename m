Received: from eggs.gnu.org ([2001:4830:134:3::10]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqAIH-0001Sy-SB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqAIG-0000Nu-0Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqAIF-0000MK-RW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0DB27E9F0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 03:17:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Mar 2017 22:17:03 -0500
Message-Id: <20170321031705.22291-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] Fix QemuOpts regression on bogus
 keys
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
problem while working on https://bugzilla.redhat.com/1433193
Broken since 2.7, but the fix is a one-liner (pointing out my
embarrassing mistake of mis-converting a pre-decrement operator);
as a bug fix, it still qualifies for 2.9 in spite of hard freeze,
on the other hand, as the regression was not introduced in 2.9,
I also understand if it is postponed.

Eric Blake (2):
  tests: Expose regression in QemuOpts visitor
  qapi: Fix QemuOpts visitor regression on unvisited input

 qapi/opts-visitor.c       |  6 +++---
 tests/test-opts-visitor.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.9.3
