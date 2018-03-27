Received: from eggs.gnu.org ([2001:4830:134:3::10]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dXO-00054w-Ut
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dXL-0006lk-0s
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:36:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0dXK-0006kS-Si
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:36:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Mar 2018 20:36:16 -0500
Message-Id: <20180327013620.1644387-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] Monitor: OOB related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, marcandre.lureau@redhat.com, borntraeger@de.ibm.com

This is patches 2, 3, 7, and 8 (with 7 rewritten) from Peter Xu's
series.  I've pushed them to git://repo.or.cz/qemu/ericb.git qapi-next
(on top of the other pending qapi patches at branch qapi); hopefully
this will be part of my pull request tomorrow for -rc1.

Eric Blake (1):
  tests: Add parameter to qtest_init_without_qmp_handshake

Peter Xu (3):
  qmp: cleanup qmp queues properly
  monitor: new parameter "x-oob"
  tests: qmp-test: add test for new "x-oob"

 tests/libqtest.h          |  7 +++-
 include/monitor/monitor.h |  1 +
 vl.c                      |  5 +++
 tests/libqtest.c          | 10 +++--
 monitor.c                 | 94 ++++++++++++++++++++++++++++++++++++-----=
------
 tests/qmp-test.c          | 84 +++++++++++++++++++++++++++++++++++++++++=
-
 6 files changed, 173 insertions(+), 28 deletions(-)

--=20
2.14.3
