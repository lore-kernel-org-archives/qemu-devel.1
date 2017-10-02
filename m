Received: from eggs.gnu.org ([2001:4830:134:3::10]:44110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tk-00070j-VN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tf-0003bP-CD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tf-0003ar-6e
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A8C27EA84
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:30 +0200
Message-Id: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/11] qapi: Cleanups around qapi2texi
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

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

 qapi-schema.json                       |   2 +-
 scripts/qapi.py                        | 107 +++++++++++++++------------------
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
 12 files changed, 110 insertions(+), 114 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-section.err
 create mode 100644 tests/qapi-schema/doc-bad-section.exit
 create mode 100644 tests/qapi-schema/doc-bad-section.json
 create mode 100644 tests/qapi-schema/doc-bad-section.out

-- 
2.13.6
