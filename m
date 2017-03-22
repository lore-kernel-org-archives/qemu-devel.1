Received: from eggs.gnu.org ([2001:4830:134:3::10]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqWAN-0004dU-Fp
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqWAI-00035I-Pn
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqWAI-000357-Jj
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:38:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6539D4DD5F
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 02:38:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 21 Mar 2017 21:38:17 -0500
Message-Id: <20170322023820.10772-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 0/3] Fix QemuOpts regression on
 bogus keys
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

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04072.html

Since then:
- fix 'make check' failure, where we had accidentally been relying
on ignoring bogus keys in user_creatable_add_opts() (new patch 2) [Markus]
- commit message and one-word comment improvement, explaining why
test doesn't fail even though it flags problem (patch 1) [Laurent]
- add Reviewed/Tested-by as appropriate

Eric Blake (3):
  tests: Expose regression in QemuOpts visitor
  qom: Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts
  qapi: Fix QemuOpts visitor regression on unvisited input

 qapi/opts-visitor.c       |  6 +++---
 qom/object_interfaces.c   |  7 ++++---
 tests/test-opts-visitor.c | 29 ++++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.9.3
