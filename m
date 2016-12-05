Received: from eggs.gnu.org ([2001:4830:134:3::10]:47256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007V5-BE
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOD-0006uy-6x
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOD-0006ui-0g
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:17 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0164F804EC
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-24.ams2.redhat.com
	[10.36.116.24])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uB5GjELF008218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 11:45:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:04 +0100
Message-Id: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] QAPI patches for 2016-12-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A set of fixes for MacOS from Eric, and a little documentation
polishing from Marc-Andr=C3=A9.  The diffstat for the .json may look scar=
y,
but the generated code is identical.

The following changes since commit bd8ef5060dd2124a54578241da9a572faf7658=
dd:

  Merge remote-tracking branch 'dgibson/tags/ppc-for-2.8-20161201' into s=
taging (2016-12-01 13:39:29 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2016-12-05

for you to fetch changes up to 5072f7b38b1b9b26b8fbe1a89086386a420aded8:

  qapi: add missing colon-ending for section name (2016-12-05 17:41:38 +0=
100)

----------------------------------------------------------------
QAPI patches for 2016-12-05

----------------------------------------------------------------
Eric Blake (3):
      qmp-event: Avoid qobject_from_jsonf("%"PRId64)
      test-qga: Avoid qobject_from_jsonv("%"PRId64)
      tests: Avoid qobject_from_jsonf("%"PRId64)

Marc-Andr=C3=A9 Lureau (6):
      qga/schema: fix double-return in doc
      qapi: fix schema symbol sections
      qapi: fix missing symbol @prefix
      qapi: fix various symbols mismatch in documentation
      qapi: use one symbol per line
      qapi: add missing colon-ending for section name

 qapi-schema.json                   | 346 +++++++++++++++++++------------=
------
 qapi/block-core.json               | 209 +++++++++++-----------
 qapi/block.json                    |  16 +-
 qapi/common.json                   |  14 +-
 qapi/crypto.json                   |  36 ++--
 qapi/event.json                    |  58 +++----
 qapi/introspect.json               |  28 +--
 qapi/qmp-event.c                   |  17 +-
 qapi/rocker.json                   |   2 +-
 qapi/trace.json                    |   8 +-
 qga/qapi-schema.json               |  52 +++---
 tests/check-qjson.c                |   6 +-
 tests/test-qga.c                   |   7 +-
 tests/test-qobject-input-visitor.c |   5 +-
 14 files changed, 406 insertions(+), 398 deletions(-)

--=20
2.5.5
