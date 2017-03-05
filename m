Received: from eggs.gnu.org ([2001:4830:134:3::10]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReA-0000Og-1e
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe6-0002xC-N9
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe6-0002vs-E2
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C3ACC04B31F
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258Zxo9024226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:01 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:31 +0100
Message-Id: <1488702958-24336-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/27] QAPI patches for 2017-02-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48=
c6:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303=
' into staging (2017-03-04 16:31:14 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-28

for you to fetch changes up to aa3a982e674b09ae32502940f93ba98b3a8ad50e:

  qapi: Improve qobject visitor documentation (2017-03-05 09:14:20 +0100)

----------------------------------------------------------------
QAPI patches for 2017-02-28

----------------------------------------------------------------
Markus Armbruster (27):
      qga: Fix crash on non-dictionary QMP argument
      libqtest: Work around a "QMP wants a newline" bug
      qmp-test: New, covering basic QMP protocol
      qmp: Dumb down how we run QMP command registration
      qapi: Support multiple command registries per program
      qapi-introspect: Mangle --prefix argument properly for C
      qmp: Clean up how we enforce capability negotiation
      qmp: Drop duplicated QMP command object checks
      qmp: Eliminate silly QERR_QMP_* macros
      qapi: Improve a QObject input visitor error message
      qapi: Clean up after commit 3d344c2
      qapi: Make QObject input visitor set *list reliably
      qapi: Improve qobject input visitor error reporting
      qapi: Drop string input visitor method optional()
      qapi: Make string input and opts visitor require non-null input
      qom: Make object_property_set_qobject()'s input visitor strict
      test-qobject-input-visitor: Use strict visitor
      qapi: Drop unused non-strict qobject input visitor
      tests-qobject-input-strict: Merge into test-qobject-input-visitor
      test-string-input-visitor: Tear down existing test automatically
      test-string-input-visitor: Improve list coverage
      tests: Cover partial input visit of list
      test-qobject-input-visitor: Cover missing nested struct member
      qapi: Make input visitors detect unvisited list tails
      tests: Cover input visit beyond end of list
      qapi: Fix object input visit beyond end of list
      qapi: Improve qobject visitor documentation

 MAINTAINERS                           |   1 +
 block/nbd.c                           |   2 +-
 block/nfs.c                           |   2 +-
 block/ssh.c                           |   2 +-
 docs/qapi-code-gen.txt                |   2 +-
 hw/ppc/spapr_drc.c                    |   5 +
 include/monitor/monitor.h             |   1 +
 include/qapi/qmp/dispatch.h           |  22 +-
 include/qapi/qmp/qerror.h             |   9 -
 include/qapi/qobject-input-visitor.h  |  40 +++-
 include/qapi/qobject-output-visitor.h |  35 +++-
 include/qapi/visitor-impl.h           |   7 +-
 include/qapi/visitor.h                |  19 +-
 include/qemu/module.h                 |   2 -
 monitor.c                             | 178 ++++++----------
 qapi/opts-visitor.c                   |  12 ++
 qapi/qapi-visit-core.c                |   8 +
 qapi/qmp-dispatch.c                   |  29 ++-
 qapi/qmp-registry.c                   |  37 ++--
 qapi/qobject-input-visitor.c          | 219 ++++++++++++-------
 qapi/string-input-visitor.c           |  97 +++++----
 qapi/trace-events                     |   1 +
 qga/commands.c                        |   2 +-
 qga/guest-agent-core.h                |   2 +
 qga/main.c                            |  19 +-
 qmp.c                                 |   2 +-
 qom/qom-qobject.c                     |   4 +-
 scripts/qapi-commands.py              |  19 +-
 scripts/qapi-introspect.py            |   2 +-
 scripts/qapi-visit.py                 |   3 +
 target/s390x/cpu_models.c             |   2 +-
 tests/Makefile.include                |   9 +-
 tests/check-qnull.c                   |   2 +-
 tests/libqtest.c                      |  29 ++-
 tests/libqtest.h                      |   8 +
 tests/qmp-test.c                      | 139 +++++++++++++
 tests/test-opts-visitor.c             |  80 +++++++
 tests/test-qga.c                      |   2 +-
 tests/test-qmp-commands.c             |  14 +-
 tests/test-qobject-input-strict.c     | 381 ----------------------------=
------
 tests/test-qobject-input-visitor.c    | 260 ++++++++++++++++++++++-
 tests/test-string-input-visitor.c     | 142 ++++++++++---
 tests/test-visitor-serialization.c    |   2 +-
 trace-events                          |   1 -
 vl.c                                  |   2 +-
 45 files changed, 1083 insertions(+), 773 deletions(-)
 create mode 100644 tests/qmp-test.c
 delete mode 100644 tests/test-qobject-input-strict.c

--=20
2.7.4
