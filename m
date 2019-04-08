Received: from eggs.gnu.org ([209.51.188.92]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNo-0007E0-Lz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNn-0000LL-JJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 16:35:39 +0200
Message-Id: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This series adds optional feature lists to struct definitions in the
QAPI schema and makes use of them to advertise the new behaviour of
auto-read-only=3Don in file-posix.

Kevin Wolf (4):
  qapi: Support features for structs
  tests/qapi-schema: Test for good feature lists in structs
  tests/qapi-schema: Error case tests for features in structs
  file-posix: Add dynamic-auto-read-only QAPI feature

 qapi/block-core.json                          | 11 ++++-
 qapi/introspect.json                          |  8 ++-
 tests/qapi-schema/features-bad-type.json      |  3 ++
 tests/qapi-schema/features-missing-name.json  |  3 ++
 tests/qapi-schema/features-name-bad-type.json |  3 ++
 tests/qapi-schema/features-no-list.json       |  3 ++
 tests/qapi-schema/features-unknown-key.json   |  3 ++
 tests/qapi-schema/qapi-schema-test.json       | 27 ++++++++++
 docs/devel/qapi-code-gen.txt                  | 38 ++++++++++++++
 scripts/qapi/common.py                        | 49 +++++++++++++++----
 scripts/qapi/doc.py                           |  3 +-
 scripts/qapi/introspect.py                    |  6 ++-
 scripts/qapi/types.py                         |  3 +-
 scripts/qapi/visit.py                         |  3 +-
 tests/Makefile.include                        |  5 ++
 tests/qapi-schema/double-type.err             |  2 +-
 tests/qapi-schema/features-bad-type.err       |  1 +
 tests/qapi-schema/features-bad-type.exit      |  1 +
 tests/qapi-schema/features-bad-type.out       |  0
 tests/qapi-schema/features-missing-name.err   |  1 +
 tests/qapi-schema/features-missing-name.exit  |  1 +
 tests/qapi-schema/features-missing-name.out   |  0
 tests/qapi-schema/features-name-bad-type.err  |  1 +
 tests/qapi-schema/features-name-bad-type.exit |  1 +
 tests/qapi-schema/features-name-bad-type.out  |  0
 tests/qapi-schema/features-no-list.err        |  1 +
 tests/qapi-schema/features-no-list.exit       |  1 +
 tests/qapi-schema/features-no-list.out        |  0
 tests/qapi-schema/features-unknown-key.err    |  2 +
 tests/qapi-schema/features-unknown-key.exit   |  1 +
 tests/qapi-schema/features-unknown-key.out    |  0
 tests/qapi-schema/qapi-schema-test.out        | 26 ++++++++++
 tests/qapi-schema/test-qapi.py                |  7 ++-
 tests/qapi-schema/unknown-expr-key.err        |  2 +-
 34 files changed, 197 insertions(+), 19 deletions(-)
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.out
 create mode 100644 tests/qapi-schema/features-missing-name.err
 create mode 100644 tests/qapi-schema/features-missing-name.exit
 create mode 100644 tests/qapi-schema/features-missing-name.out
 create mode 100644 tests/qapi-schema/features-name-bad-type.err
 create mode 100644 tests/qapi-schema/features-name-bad-type.exit
 create mode 100644 tests/qapi-schema/features-name-bad-type.out
 create mode 100644 tests/qapi-schema/features-no-list.err
 create mode 100644 tests/qapi-schema/features-no-list.exit
 create mode 100644 tests/qapi-schema/features-no-list.out
 create mode 100644 tests/qapi-schema/features-unknown-key.err
 create mode 100644 tests/qapi-schema/features-unknown-key.exit
 create mode 100644 tests/qapi-schema/features-unknown-key.out

--=20
2.20.1
