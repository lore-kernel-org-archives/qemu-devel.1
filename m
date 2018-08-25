Received: from eggs.gnu.org ([2001:4830:134:3::10]:49376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4G-00018r-SF
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4D-00032E-My
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4D-00031M-Hv
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:15 +0200
Message-Id: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/9] monitor: various code simplification
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
asynchronous command type".

v3:
- updated "tests: add a few qmp tests" to move tests to new files
- comment update in "qmp: common 'id' handling & make QGA conform to QMP =
spec"
- commit message updates, add r-b tags

Marc-Andr=C3=A9 Lureau (9):
  monitor: consitify qmp_send_response() QDict argument
  qmp: constify qmp_is_oob()
  Revert "qmp: isolate responses into io thread"
  monitor: no need to save need_resume
  json-lexer: make it safe to call destroy multiple times
  tests: add a few qmp tests
  tests: add a qmp success-response test
  qga: process_event() simplification
  qmp: common 'id' handling & make QGA conform to QMP spec

 include/qapi/qmp/dispatch.h             |   2 +-
 monitor.c                               | 170 +++---------------------
 qapi/qmp-dispatch.c                     |  12 +-
 qga/main.c                              |  47 ++-----
 qobject/json-lexer.c                    |   5 +-
 tests/qmp-cmd-test.c                    |  31 +++++
 tests/qmp-test.c                        |  18 +++
 tests/test-qga.c                        |  13 +-
 tests/test-qmp-cmds.c                   |  17 +++
 tests/qapi-schema/qapi-schema-test.json |   2 +
 tests/qapi-schema/qapi-schema-test.out  |   2 +
 11 files changed, 119 insertions(+), 200 deletions(-)

--=20
2.18.0.547.g1d89318c48
