Received: from eggs.gnu.org ([2001:4830:134:3::10]:55661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029U-12
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaR-00060N-C0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaR-0005zE-1l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A49180B22
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB968619AF
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:11 +0100
Message-Id: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] QAPI patches for 2017-12-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba=
26:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-=
18-v2' into staging (2017-12-20 13:20:48 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-12-20

for you to fetch changes up to 49ccefde303c84d291c70842922c37b6de6ef15a:

  qmp: remove qmp_cpu (2017-12-20 19:18:33 +0100)

----------------------------------------------------------------
QAPI patches for 2017-12-20

----------------------------------------------------------------
Chen Hanxiao (1):
      qapi-docs: fix a comment typo

Daniel Henrique Barboza (1):
      qmp: remove qmp_cpu

Markus Armbruster (11):
      qapi-schema: Fix query-vm-generation-id's doc comment markup
      qapi: Stop rejecting #optional
      qapi: Eliminate QAPISchemaParser.__init__()'s local fname
      qapi: Make cur_doc local to QAPISchemaParser.__init__()
      tests/qapi-schema/doc-bad-section: New, factored out of doc-good
      qapi2texi: Clean up texi_sections()
      qapi: Unify representation of doc section without name
      qapi: Simplify representation of QAPIDoc section text
      qapi2texi: Simplify representation of section text
      qapi: Rename QAPIDoc.parser, .section to ._parser, ._section
      qapi2texi: De-duplicate code to add blank line before symbol

 docs/devel/qapi-code-gen.txt           |   2 +-
 qapi-schema.json                       |  13 +---
 qmp.c                                  |   5 --
 scripts/qapi.py                        | 107 +++++++++++++++------------=
------
 scripts/qapi2texi.py                   |  65 +++++++++-----------
 tests/Makefile.include                 |   3 +-
 tests/qapi-schema/doc-bad-section.err  |   0
 tests/qapi-schema/doc-bad-section.exit |   1 +
 tests/qapi-schema/doc-bad-section.json |  11 ++++
 tests/qapi-schema/doc-bad-section.out  |  13 ++++
 tests/qapi-schema/doc-good.json        |   1 -
 tests/qapi-schema/doc-good.out         |   4 +-
 tests/qapi-schema/doc-good.texi        |  11 +---
 tests/qapi-schema/test-qapi.py         |   6 +-
 14 files changed, 111 insertions(+), 131 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-section.err
 create mode 100644 tests/qapi-schema/doc-bad-section.exit
 create mode 100644 tests/qapi-schema/doc-bad-section.json
 create mode 100644 tests/qapi-schema/doc-bad-section.out

--=20
2.13.6
