Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77S-0002M2-6G
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77O-0000dP-W9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG77O-0000d1-Oh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97AF380B20
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62FC75DC1F
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 May 2017 19:09:03 +0200
Message-Id: <1496250547-20701-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] QAPI patches for 2017-05-31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b=
04:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-30 14:15:15 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-31

for you to fetch changes up to c0644771ebedbd8f47f3c24816445e30111d226b:

  qapi: Reject alternates that can't work with keyval_parse() (2017-05-31=
 16:04:09 +0200)

----------------------------------------------------------------
QAPI patches for 2017-05-31

----------------------------------------------------------------
Markus Armbruster (4):
      qobject-input-visitor: Reject non-finite numbers with keyval
      qapi: Document visit_type_any() issues with keyval input
      tests/qapi-schema: Avoid 'str' in alternate test cases
      qapi: Reject alternates that can't work with keyval_parse()

 include/qapi/visitor.h                             |  4 ++
 qapi/qobject-input-visitor.c                       |  3 +-
 scripts/qapi.py                                    | 19 ++++++-
 tests/Makefile.include                             |  2 +
 tests/qapi-schema/alternate-clash.json             |  2 +-
 tests/qapi-schema/alternate-conflict-dict.json     |  2 +-
 tests/qapi-schema/alternate-conflict-enum-bool.err |  1 +
 .../qapi-schema/alternate-conflict-enum-bool.exit  |  1 +
 .../qapi-schema/alternate-conflict-enum-bool.json  |  6 +++
 tests/qapi-schema/alternate-conflict-enum-bool.out |  0
 tests/qapi-schema/alternate-conflict-enum-int.err  |  1 +
 tests/qapi-schema/alternate-conflict-enum-int.exit |  1 +
 tests/qapi-schema/alternate-conflict-enum-int.json |  6 +++
 tests/qapi-schema/alternate-conflict-enum-int.out  |  0
 tests/qapi-schema/alternate-conflict-string.err    |  2 +-
 tests/qapi-schema/alternate-conflict-string.json   |  6 +--
 tests/qapi-schema/alternate-nested.json            |  2 +-
 tests/qapi-schema/args-alternate.json              |  2 +-
 tests/qapi-schema/doc-bad-alternate-member.json    |  2 +-
 tests/qapi-schema/qapi-schema-test.json            | 13 +++--
 tests/qapi-schema/qapi-schema-test.out             | 34 ++++++------
 tests/qapi-schema/returns-alternate.json           |  2 +-
 tests/test-clone-visitor.c                         | 23 ++++----
 tests/test-keyval.c                                | 18 ++++---
 tests/test-qobject-input-visitor.c                 | 62 ++++++++++++----=
------
 tests/test-qobject-output-visitor.c                |  4 +-
 util/keyval.c                                      | 10 ++--
 27 files changed, 140 insertions(+), 88 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.err
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.json
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.out
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.err
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.json
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.out

--=20
2.7.4
