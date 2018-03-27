Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcF-0007Ml-7U
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcA-0004vW-Cb
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcA-0004vK-6m
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28325401DEA8
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:17 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E090E76C0
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:00 -0500
Message-Id: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] QAPI changes for 2018-03-27, 2.12-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f58d9620aa4a514b1227074ff56eefd1334a62=
25:

  Merge remote-tracking branch 'remotes/rth/tags/pull-dt-20180326' into s=
taging (2018-03-27 10:27:34 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-27

for you to fetch changes up to 701a2432fea0a9a1741abf7a887fae26f5410970:

  hmp.c: Revert hmp_info_cpus output format change (2018-03-27 09:21:52 -=
0500)

----------------------------------------------------------------
qapi patches for 2018-03-27, 2.12-rc1

- Marc-Andr=C3=A9 Lureau: qmp-test: fix response leak
- Eric Blake: tests: Silence false positive warning on generated test nam=
e
- Laurent Vivier: 0/4 (partial) coccinelle: re-run scripts from scripst/c=
occinelle
- Peter Xu: 0/8 Monitor: some oob related patches (fixes, new param, test=
s)
- Satheesh Rajendran: hmp.c: Revert hmp_info_cpus output format change

----------------------------------------------------------------
Eric Blake (2):
      tests: Silence false positive warning on generated test name
      tests: Add parameter to qtest_init_without_qmp_handshake

Laurent Vivier (3):
      error: Strip trailing '\n' from error string arguments (again again=
)
      error: Remove NULL checks on error_propagate() calls
      qdict: remove useless cast

Marc-Andr=C3=A9 Lureau (1):
      qmp-test: fix response leak

Peter Xu (7):
      qmp: fix qmp_capabilities error regression
      qapi: restrict allow-oob value to be "true"
      tests: let qapi-schema tests detect oob
      tests: add oob-test for qapi-schema
      qmp: cleanup qmp queues properly
      monitor: new parameter "x-oob"
      tests: qmp-test: add test for new "x-oob"

Satheesh Rajendran (1):
      hmp.c: Revert hmp_info_cpus output format change

 scripts/qapi/common.py                  |   2 +-
 tests/libqtest.h                        |   7 +-
 include/monitor/monitor.h               |   1 +
 vl.c                                    |   5 ++
 tests/libqtest.c                        |  10 +--
 block/nvme.c                            |  11 ++-
 hmp.c                                   |   2 +-
 io/channel-websock.c                    |   4 +-
 monitor.c                               | 118 ++++++++++++++++++++++----=
------
 target/i386/hvf/hvf.c                   |  24 +++----
 tests/qmp-test.c                        |  85 ++++++++++++++++++++++-
 tests/test-qmp-cmds.c                   |   4 ++
 tests/test-visitor-serialization.c      |   2 +-
 tests/Makefile.include                  |   1 +
 tests/qapi-schema/doc-good.out          |   4 +-
 tests/qapi-schema/ident-with-escape.out |   2 +-
 tests/qapi-schema/indented-expr.out     |   4 +-
 tests/qapi-schema/oob-test.err          |   1 +
 tests/qapi-schema/oob-test.exit         |   1 +
 tests/qapi-schema/oob-test.json         |   2 +
 tests/qapi-schema/oob-test.out          |   0
 tests/qapi-schema/qapi-schema-test.json |   3 +
 tests/qapi-schema/qapi-schema-test.out  |  20 +++---
 tests/qapi-schema/test-qapi.py          |   4 +-
 24 files changed, 233 insertions(+), 84 deletions(-)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

--=20
2.14.3
