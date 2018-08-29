Received: from eggs.gnu.org ([2001:4830:134:3::10]:50103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0iU-0007rC-2z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0iP-0000Bb-RO
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fv0iM-00007w-3A
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6320E7A7E6
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 13:40:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 15:40:33 +0200
Message-Id: <20180829134043.31706-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/10] monitor: various code simplification
 and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
asynchronous command type".

v4:
- splitted "tests: add a few qmp tests"
- fix success-response crash regression in "qga: process_event() simplifi=
cation"
- add r-b tags from Michael

v3:
- updated "tests: add a few qmp tests" to move tests to new files
- comment update in "qmp: common 'id' handling & make QGA conform to QMP =
spec"
- commit message updates, add r-b tags

Marc-Andr=C3=A9 Lureau (10):
  monitor: consitify qmp_send_response() QDict argument
  qmp: constify qmp_is_oob()
  Revert "qmp: isolate responses into io thread"
  monitor: no need to save need_resume
  json-lexer: make it safe to call destroy multiple times
  tests: add qmp/object-add-without-props test
  tests: add qmp/qom-set-without-value test
  tests: add a qmp success-response test
  qga: process_event() simplification
  qmp: common 'id' handling & make QGA conform to QMP spec

 include/qapi/qmp/dispatch.h             |   2 +-
 monitor.c                               | 170 +++---------------------
 qapi/qmp-dispatch.c                     |  12 +-
 qga/main.c                              |  57 +++-----
 qobject/json-lexer.c                    |   5 +-
 tests/qmp-cmd-test.c                    |  31 +++++
 tests/qmp-test.c                        |  18 +++
 tests/test-qga.c                        |  13 +-
 tests/test-qmp-cmds.c                   |  17 +++
 tests/qapi-schema/qapi-schema-test.json |   2 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 11 files changed, 125 insertions(+), 204 deletions(-)

--=20
2.19.0.rc0.48.gb9dfa238d5
