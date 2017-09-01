Received: from eggs.gnu.org ([2001:4830:134:3::10]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0000FH-0A
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUd-0007I6-8B
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUc-0007Hm-Vl
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB08D4E028
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 91F3D7B0CC
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:24 +0200
Message-Id: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/47] QAPI patches for 2017-09-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339=
be:

  Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' i=
nto staging (2017-08-31 15:52:43 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-09-01

for you to fetch changes up to b81199affe432d6e8752ca45dbee19b38fcba23d:

  qapi: drop the sentinel in enum array (2017-09-01 14:33:55 +0200)

----------------------------------------------------------------
QAPI patches for 2017-09-01

----------------------------------------------------------------
Eduardo Habkost (1):
      qapi: Fix error handling code on alternate conflict

Marc-Andr=C3=A9 Lureau (19):
      qdict: Add qdict_put_null() helper, and put it to use
      qlit: move qlit from check-qjson to qobject/
      qlit: use QLit prefix consistently
      qlit: Change compound literals to initializers
      qlit: rename compare_litqobj_to_qobj() to qlit_equal_qobject()
      qlit: make qlit_equal_qobject return a bool
      qlit: make qlit_equal_qobject() take const arguments
      qlit: add QLIT_QNULL and QLIT_BOOL
      qlit: Replace open-coded qnum_get_int() by call
      tests/check-qlit: New, covering qobject/qlit.c
      qlit: Tighten QLit dict vs QDict comparison
      qlit: Tighten QLit list vs QList comparison
      tpm: Clean up driver registration & lookup
      hmp: Use qapi_enum_parse() in hmp_migrate_set_capability()
      hmp: Use qapi_enum_parse() in hmp_migrate_set_parameter()
      block: Use qemu_enum_parse() in blkdebug_debug_breakpoint()
      quorum: Use qapi_enum_parse() in quorum_open()
      qapi: Change data type of the FOO_lookup generated for enum FOO
      qapi: drop the sentinel in enum array

Markus Armbruster (27):
      tests/qmp-test: Add generic, basic test of query commands
      qobject: Explain how QNum works, and why
      qapi-schema: Document how generated documentation is ordered
      qapi-schema: Introspection doc is in the wrong section, fix
      qapi-schema: Rocker doc section contains unrelated stuff, fix
      qapi-schema: Collect sockets stuff in qapi/sockets.json
      qapi-schema: Collect run state stuff in qapi/run-state.json
      qapi-schema: Collect char device stuff in qapi/char.json
      qapi-schema: Collect net device stuff in qapi/net.json
      qapi-schema: Collect UI stuff in qapi/ui.json
      qapi-schema: Collect migration stuff in qapi/migration.json
      qapi-schema: Collect transaction stuff in qapi/transaction.json
      qapi-schema: Collect TPM stuff in qapi/tpm.json
      qapi-schema: Move block events from event.json to block.json
      qapi-schema: Fold event.json back into qapi-schema.json
      qapi-schema: Make block-core.json self-contained
      qapi-schema: Move queries from common.json to qapi-schema.json
      qapi-schema: Improve section headings
      qapi: Update qapi-code-gen.txt examples to match current code
      qapi: Drop superfluous qapi_enum_parse() parameter max
      tpm: Clean up model registration & lookup
      crypto: Use qapi_enum_parse() in qcrypto_block_luks_name_lookup()
      qapi: Use qapi_enum_parse() in input_type_enum()
      qapi: Avoid unnecessary use of enum lookup table's sentinel
      qapi: Generate FOO_str() macro for QAPI enum FOO
      qapi: Mechanically convert FOO_lookup[...] to FOO_str(...)
      qapi: Convert indirect uses of FOO_lookup[...] to qapi_enum_lookup(=
)

 MAINTAINERS                                        |   16 +
 Makefile                                           |   15 +-
 backends/hostmem.c                                 |    4 +-
 block.c                                            |    4 +-
 block/backup.c                                     |    2 +-
 block/blkdebug.c                                   |   27 +-
 block/file-posix.c                                 |   20 +-
 block/file-win32.c                                 |    5 +-
 block/gluster.c                                    |   11 +-
 block/iscsi.c                                      |    2 +-
 block/nfs.c                                        |    2 +-
 block/parallels.c                                  |   17 +-
 block/qcow2.c                                      |   15 +-
 block/qed.c                                        |    2 +-
 block/quorum.c                                     |   27 +-
 block/rbd.c                                        |    2 +-
 block/sheepdog.c                                   |    2 +-
 blockdev.c                                         |    8 +-
 blockjob.c                                         |    6 +-
 chardev/char.c                                     |    4 +-
 crypto/block-luks.c                                |   38 +-
 crypto/block.c                                     |    4 +-
 crypto/cipher-afalg.c                              |    2 +-
 crypto/cipher-builtin.c                            |    8 +-
 crypto/cipher-gcrypt.c                             |    4 +-
 crypto/cipher-nettle.c                             |    8 +-
 crypto/hmac-gcrypt.c                               |    2 +-
 crypto/hmac-glib.c                                 |    2 +-
 crypto/hmac-nettle.c                               |    2 +-
 crypto/pbkdf-gcrypt.c                              |    2 +-
 crypto/pbkdf-nettle.c                              |    2 +-
 crypto/secret.c                                    |    2 +-
 crypto/tlscreds.c                                  |    2 +-
 docs/devel/qapi-code-gen.txt                       |   50 +-
 hmp.c                                              |  220 +-
 hw/block/fdc.c                                     |    6 +-
 hw/char/escc.c                                     |    2 +-
 hw/core/qdev-properties.c                          |   17 +-
 hw/input/virtio-input-hid.c                        |    4 +-
 include/hw/qdev-core.h                             |    2 +-
 include/qapi/qmp/qdict.h                           |    4 +-
 include/qapi/qmp/qlit.h                            |   54 +
 include/qapi/qmp/qnum.h                            |   21 +
 include/qapi/util.h                                |   10 +-
 include/qapi/visitor.h                             |    2 +-
 include/qom/object.h                               |    4 +-
 include/sysemu/tpm_backend.h                       |    4 +-
 migration/colo-failover.c                          |    4 +-
 migration/colo.c                                   |   14 +-
 migration/global_state.c                           |    6 +-
 migration/migration.c                              |    1 -
 monitor.c                                          |   20 +-
 net/filter.c                                       |    2 +-
 net/net.c                                          |    4 +-
 qapi-schema.json                                   | 3866 ++------------=
------
 qapi/block-core.json                               |    5 +-
 qapi/block.json                                    |   73 +-
 qapi/char.json                                     |  538 +++
 qapi/common.json                                   |  132 +-
 qapi/crypto.json                                   |    2 +-
 qapi/event.json                                    |  646 ----
 qapi/introspect.json                               |    6 +-
 qapi/migration.json                                | 1085 ++++++
 qapi/net.json                                      |  706 ++++
 qapi/qapi-util.c                                   |   16 +-
 qapi/qapi-visit-core.c                             |   34 +-
 qapi/qmp-dispatch.c                                |    2 +-
 qapi/run-state.json                                |  352 ++
 qapi/sockets.json                                  |  147 +
 qapi/tpm.json                                      |  137 +
 qapi/trace.json                                    |    2 +-
 qapi/transaction.json                              |  158 +
 qapi/ui.json                                       |  977 +++++
 qemu-img.c                                         |    6 +-
 qemu-nbd.c                                         |    4 +-
 qobject/Makefile.objs                              |    2 +-
 qobject/qlit.c                                     |   84 +
 qom/object.c                                       |   16 +-
 scripts/coccinelle/qobject.cocci                   |    3 +
 scripts/qapi-event.py                              |    1 +
 scripts/qapi-types.py                              |    4 +
 scripts/qapi-visit.py                              |    2 +-
 scripts/qapi.py                                    |   24 +-
 target/i386/cpu.c                                  |    4 +-
 tests/Makefile.include                             |    7 +-
 tests/check-qjson.c                                |  150 +-
 tests/check-qlit.c                                 |   74 +
 tests/check-qom-proplist.c                         |   14 +-
 .../qapi-schema/alternate-conflict-bool-string.err |    1 +
 .../alternate-conflict-bool-string.exit            |    1 +
 .../alternate-conflict-bool-string.json            |    4 +
 .../qapi-schema/alternate-conflict-bool-string.out |    0
 .../qapi-schema/alternate-conflict-num-string.err  |    1 +
 .../qapi-schema/alternate-conflict-num-string.exit |    1 +
 .../qapi-schema/alternate-conflict-num-string.json |    4 +
 .../qapi-schema/alternate-conflict-num-string.out  |    0
 tests/qmp-test.c                                   |  182 +-
 tests/test-qapi-util.c                             |   18 +-
 tests/test-qobject-input-visitor.c                 |    8 +-
 tests/test-qobject-output-visitor.c                |    2 +-
 tests/test-string-input-visitor.c                  |    4 +-
 tests/test-string-output-visitor.c                 |    4 +-
 tpm.c                                              |   81 +-
 ui/input-legacy.c                                  |    6 +-
 ui/input.c                                         |   12 +-
 ui/vnc.c                                           |    6 +-
 util/keyval.c                                      |    1 -
 vl.c                                               |    6 +-
 108 files changed, 5360 insertions(+), 4981 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qapi/char.json
 delete mode 100644 qapi/event.json
 create mode 100644 qapi/migration.json
 create mode 100644 qapi/net.json
 create mode 100644 qapi/run-state.json
 create mode 100644 qapi/sockets.json
 create mode 100644 qapi/tpm.json
 create mode 100644 qapi/transaction.json
 create mode 100644 qapi/ui.json
 create mode 100644 qobject/qlit.c
 create mode 100644 tests/check-qlit.c
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.out
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.out

--=20
2.13.5
