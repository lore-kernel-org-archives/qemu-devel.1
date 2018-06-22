Received: from eggs.gnu.org ([2001:4830:134:3::10]:56703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pl-AB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000I3-4w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO34-0000HC-Vq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E01401C87C
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-237.ams2.redhat.com
	[10.36.117.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E5C442026D6C
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:18 +0200
Message-Id: <20180622153228.23594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] QAPI patches for 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 45eb6fb6cea28cdc937764aac6585751047bb2=
94:

  nbd/server: Silence gcc false positive (2018-06-22 14:18:36 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-06-22

for you to fetch changes up to be25fcc4d2faeb3ffa8db813272963bae659c4c2:

  MAINTAINERS: Update QAPI stanza for commit fb0bc835e56 (2018-06-22 16:3=
3:47 +0200)

----------------------------------------------------------------
QAPI patches for 2018-06-22

----------------------------------------------------------------
Anton Nefedov (2):
      qapi: allow empty branches in flat unions
      qapi: remove empty flat union branches and types

Marc-Andr=C3=A9 Lureau (2):
      qapi/visit: remove useless prefix argument
      qapi/events: generate event enum in main module

Markus Armbruster (3):
      qapi: Open files with encoding=3D'utf-8'
      qapi/introspect: Eliminate pointless variable in .visit_end()
      MAINTAINERS: Update QAPI stanza for commit fb0bc835e56

Matthias Maier (1):
      Revert commit d4e5ec877ca

Max Reitz (2):
      qdict: Make qdict_flatten() shallow-clone-friendly
      tests: Add QDict clone-flatten test

 MAINTAINERS                                        |  3 +-
 Makefile                                           |  6 +--
 block/qcow2.c                                      |  1 -
 cpus.c                                             |  2 -
 docs/devel/qapi-code-gen.txt                       |  8 ++--
 qapi/block-core.json                               | 52 ++--------------=
------
 qapi/crypto.json                                   | 13 +-----
 qapi/misc.json                                     | 46 +---------------=
---
 qapi/net.json                                      | 12 -----
 qapi/ui.json                                       | 19 +-------
 qobject/block-qdict.c                              | 19 ++++++--
 scripts/qapi/common.py                             | 32 ++++++++-----
 scripts/qapi/events.py                             |  5 ++-
 scripts/qapi/introspect.py                         |  5 +--
 scripts/qapi/types.py                              |  2 +
 scripts/qapi/visit.py                              | 21 ++++++---
 tests/Makefile.include                             |  7 ++-
 tests/check-block-qdict.c                          | 33 ++++++++++++++
 tests/qapi-schema/flat-union-incomplete-branch.err |  1 -
 .../qapi-schema/flat-union-incomplete-branch.exit  |  1 -
 .../qapi-schema/flat-union-incomplete-branch.json  |  9 ----
 tests/qapi-schema/flat-union-incomplete-branch.out |  0
 tests/qapi-schema/qapi-schema-test.json            |  6 ++-
 tests/qapi-schema/qapi-schema-test.out             |  3 +-
 24 files changed, 116 insertions(+), 190 deletions(-)
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.err
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.json
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.out

--=20
2.17.1
