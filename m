Received: from eggs.gnu.org ([2001:4830:134:3::10]:44683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPV-0000wp-Q0
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPS-0001KL-OM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dCqPS-0001Ju-IZ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C8EE3DBC8
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:42:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 May 2017 18:42:11 +0200
Message-Id: <1495471335-23707-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qapi: Handle some keyval fallout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mlureau@redhat.com

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
 tests/test-qobject-input-visitor.c                 | 62 ++++++++++++----------
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

-- 
2.7.4
