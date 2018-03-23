Received: from eggs.gnu.org ([2001:4830:134:3::10]:33634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdV-0005Ye-Oi
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdR-0002GQ-Je
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezQdR-0002G9-Ep
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 805F4813F699
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:47 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48F288443B
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 23 Mar 2018 12:37:37 -0500
Message-Id: <20180323173741.1445744-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] QAPI patches for 2018-03-23, for 2.12-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b358759=
50:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' =
into staging (2018-03-23 10:20:54 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-23

for you to fetch changes up to 39615354fc07af34e04ab5efb5b6d478b0d24e32:

  qapi: Force UTF8 encoding when parsing qapi files (2018-03-23 12:29:07 =
-0500)

There may be another rc1 pull request on Monday, but let's get
these in sooner rather than later to minimize the window where
iotests are broken during bisects.

----------------------------------------------------------------
qapi patches for 2018-03-12, 2.12-rc1

- Peter Xu: 0/4 Turn OOB off for 2.12-rc1, revert OOB tests
- Eric Blake: qapi: Force UTF8 encoding when parsing qapi files

----------------------------------------------------------------
Eric Blake (1):
      qapi: Force UTF8 encoding when parsing qapi files

Peter Xu (3):
      Revert "tests: qmp-test: add oob test"
      Revert "tests: qmp-test: verify command batching"
      Revert "monitor: enable IO thread for (qmp & !mux) typed"

 monitor.c              |  5 +--
 tests/qmp-test.c       | 97 +-------------------------------------------=
------
 tests/Makefile.include |  6 ++--
 3 files changed, 5 insertions(+), 103 deletions(-)

--=20
2.14.3
