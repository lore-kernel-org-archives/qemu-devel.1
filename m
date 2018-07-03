Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV9-0000y1-Qs
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV5-0000Mr-Ts
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV5-0000MQ-O9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D128DFEB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D88DB2166BA9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:05:59 +0200
Message-Id: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] QAPI patches for 2018-07-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b07cd3e748b3f27a17c27afeee578dc4eedb8d=
d5:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180703=
' into staging (2018-07-03 14:59:27 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-07-03

for you to fetch changes up to 514337c142f9522f6ab89c3d2f964f446ebeb1cd:

  qapi: add conditions to SPICE type/commands/events on the schema (2018-=
07-03 18:38:54 +0200)

----------------------------------------------------------------
QAPI patches for 2018-07-03

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (13):
      qapi: add 'if' to top-level expressions
      qapi: pass 'if' condition into QAPISchemaEntity objects
      qapi: leave the ifcond attribute undefined until check()
      qapi: add 'ifcond' to visitor methods
      qapi: mcgen() shouldn't indent # lines
      qapi: add #if/#endif helpers
      qapi-introspect: modify to_qlit() to append ',' on level > 0
      qapi-introspect: add preprocessor conditions to generated QLit
      qapi/commands: add #if conditions to commands
      qapi/events: add #if conditions to events
      qapi: add 'If:' section to generated documentation
      qapi: add conditions to VNC type/commands/events on the schema
      qapi: add conditions to SPICE type/commands/events on the schema

Markus Armbruster (1):
      qapi-types: add #if conditions to types & visitors

 docs/devel/qapi-code-gen.txt             |  29 ++++
 hmp-commands-info.hx                     |   2 +
 hmp.c                                    |   9 +-
 monitor.c                                |   3 -
 qapi/char.json                           |   8 +-
 qapi/ui.json                             |  75 ++++++---
 qmp.c                                    |  46 +----
 scripts/qapi/commands.py                 |  26 ++-
 scripts/qapi/common.py                   | 280 ++++++++++++++++++++++++-=
------
 scripts/qapi/doc.py                      |  32 ++--
 scripts/qapi/events.py                   |   8 +-
 scripts/qapi/introspect.py               |  47 ++++--
 scripts/qapi/types.py                    |  56 ++++---
 scripts/qapi/visit.py                    |  41 +++--
 tests/Makefile.include                   |   4 +
 tests/qapi-schema/bad-if-empty-list.err  |   1 +
 tests/qapi-schema/bad-if-empty-list.exit |   1 +
 tests/qapi-schema/bad-if-empty-list.json |   3 +
 tests/qapi-schema/bad-if-empty-list.out  |   0
 tests/qapi-schema/bad-if-empty.err       |   1 +
 tests/qapi-schema/bad-if-empty.exit      |   1 +
 tests/qapi-schema/bad-if-empty.json      |   3 +
 tests/qapi-schema/bad-if-empty.out       |   0
 tests/qapi-schema/bad-if-list.err        |   1 +
 tests/qapi-schema/bad-if-list.exit       |   1 +
 tests/qapi-schema/bad-if-list.json       |   3 +
 tests/qapi-schema/bad-if-list.out        |   0
 tests/qapi-schema/bad-if.err             |   1 +
 tests/qapi-schema/bad-if.exit            |   1 +
 tests/qapi-schema/bad-if.json            |   3 +
 tests/qapi-schema/bad-if.out             |   0
 tests/qapi-schema/doc-good.json          |   2 +-
 tests/qapi-schema/doc-good.out           |   1 +
 tests/qapi-schema/doc-good.texi          |   2 +
 tests/qapi-schema/qapi-schema-test.json  |  26 +++
 tests/qapi-schema/qapi-schema-test.out   |  35 ++++
 tests/qapi-schema/test-qapi.py           |  20 ++-
 tests/test-qmp-cmds.c                    |  12 ++
 ui/vnc.h                                 |   2 +
 39 files changed, 561 insertions(+), 225 deletions(-)
 mode change 100644 =3D> 100755 scripts/qapi/doc.py
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if-list.err
 create mode 100644 tests/qapi-schema/bad-if-list.exit
 create mode 100644 tests/qapi-schema/bad-if-list.json
 create mode 100644 tests/qapi-schema/bad-if-list.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out

--=20
2.17.1
