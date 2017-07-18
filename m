Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7W-000571-B3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7T-000178-3r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXZ7S-00016n-R9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEF7CA04E8
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C3DE600CC
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 22:29:10 +0200
Message-Id: <1500409760-20730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] QAPI patches for 2017-07-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-18

for you to fetch changes up to 4f11e88cbda71af50302c32d97b4f8122555027e:

  migration: Use JSON null instead of "" to reset parameter to default (2017-07-18 22:21:58 +0200)

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
 hw/ppc/spapr_drc.c                      |   7 ++-
 include/qapi/qmp/qobject.h              |  10 ++-
 include/qapi/visitor-impl.h             |   3 +-
 include/qapi/visitor.h                  |   8 +--
 include/qemu/typedefs.h                 |   1 +
 migration/migration.c                   |  34 +++++++---
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
 target/ppc/translate_init.c             |  10 ++-
 tests/check-qjson.c                     |   6 +-
 tests/check-qnull.c                     |  27 ++++----
 tests/qapi-schema/qapi-schema-test.json |   3 +-
 tests/qapi-schema/qapi-schema-test.out  |   1 +
 tests/qemu-iotests/085                  |   2 +-
 tests/qemu-iotests/139                  |   2 +-
 tests/test-qobject-input-visitor.c      |  24 ++++---
 tests/test-qobject-output-visitor.c     |  13 +++-
 32 files changed, 326 insertions(+), 135 deletions(-)

-- 
2.7.5
