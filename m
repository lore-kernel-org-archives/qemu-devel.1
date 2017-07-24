Received: from eggs.gnu.org ([2001:4830:134:3::10]:33076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyy-00014q-2r
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZbyw-0006rc-Dq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZbyw-0006r7-5C
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E5CD7EA89
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-94.ams2.redhat.com
	[10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3F261B91
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:57:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 13:56:49 +0200
Message-Id: <1500897419-15539-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/10] QAPI patches for 2017-07-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit df95f1a298a3e16c80293343143dcedbe7978f6c:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170721-tag' into staging (2017-07-24 10:01:15 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-18-v2

for you to fetch changes up to 01fa55982692fb51a16049b63b571651a1053989:

  migration: Use JSON null instead of "" to reset parameter to default (2017-07-24 13:35:11 +0200)

----------------------------------------------------------------
QAPI patches for 2017-07-18

----------------------------------------------------------------
Markus Armbruster (10):
      qapi: Separate type QNull from QObject
      qapi: Use QNull for a more regular visit_type_null()
      qapi: Introduce a first class 'null' type
      tests/test-qobject-input-visitor: Drop redundant test
      block: Use JSON null instead of "" to disable backing file
      hmp: Clean up and simplify hmp_migrate_set_parameter()
      migration: Clean up around tls_creds, tls_hostname
      migration: Add TODO comments on duplication of QAPI_CLONE()
      migration: Unshare MigrationParameters struct for now
      migration: Use JSON null instead of "" to reset parameter to default

 blockdev.c                              |  14 +++++
 docs/devel/qapi-code-gen.txt            |  10 +--
 hmp.c                                   |  88 ++++++++++++--------------
 hw/ppc/spapr_drc.c                      |   4 +-
 include/qapi/qmp/qobject.h              |  10 ++-
 include/qapi/visitor-impl.h             |   3 +-
 include/qapi/visitor.h                  |   8 +--
 include/qemu/typedefs.h                 |   1 +
 migration/migration.c                   |  96 +++++++++++++++++++++++++---
 qapi-schema.json                        | 108 ++++++++++++++++++++++++++++----
 qapi/block-core.json                    |  29 ++++++---
 qapi/qapi-clone-visitor.c               |   5 +-
 qapi/qapi-dealloc-visitor.c             |   6 +-
 qapi/qapi-visit-core.c                  |   7 ++-
 qapi/qobject-input-visitor.c            |   6 +-
 qapi/qobject-output-visitor.c           |   5 +-
 qapi/string-input-visitor.c             |   8 ++-
 qapi/string-output-visitor.c            |   3 +-
 qapi/trace-events                       |   2 +-
 qobject/json-parser.c                   |   2 +-
 qobject/qnull.c                         |   8 ++-
 scripts/qapi.py                         |   5 +-
 target/i386/cpu.c                       |   4 +-
 target/ppc/translate_init.c             |   5 +-
 tests/check-qjson.c                     |   6 +-
 tests/check-qnull.c                     |  27 ++++----
 tests/qapi-schema/qapi-schema-test.json |   3 +-
 tests/qapi-schema/qapi-schema-test.out  |   1 +
 tests/qemu-iotests/085                  |   2 +-
 tests/qemu-iotests/139                  |   2 +-
 tests/test-qobject-input-visitor.c      |  24 ++++---
 tests/test-qobject-output-visitor.c     |  13 +++-
 32 files changed, 378 insertions(+), 137 deletions(-)

-- 
2.7.5
