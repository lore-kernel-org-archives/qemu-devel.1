Received: from eggs.gnu.org ([2001:4830:134:3::10]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZN-0005Cf-9Q
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZM-0006dt-DK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:01:57 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 22:01:43 +0100
Message-Id: <1487710908-26356-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 0/5] block: Crude initial implementation
 of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

Still missing: list support, better error messages, general polish

This is based on
* [PATCH v2 00/24] QemuOpts util/cutils: Fix and clean up number
  conversions"
* [PATCH 00/14] qobject: Cleanups, mostly in tests
* [PATCH 0/2] qapi: Improve qobject input visitor error reporting

Branch blockdev-cmdline in my public repo
http://repo.or.cz/w/qemu/armbru.git

v3: Support non-string types with KEY=VALUE
v2: Support KEY=VALUE,... syntax as well.

Daniel P. Berrange (1):
  qapi: Permit scalar type conversions in QObjectInputVisitor

Markus Armbruster (4):
  tests: Fix gcov-files-test-qemu-opts-y, gcov-files-test-logging-y
  keyval: New keyval_parse()
  qapi: Factor qobject_input_get_autocast() out of methods
  block: Crude initial implementation of -blockdev

 include/qapi/qobject-input-visitor.h |  32 ++-
 include/qemu/option.h                |   3 +
 qapi/qobject-input-visitor.c         | 148 +++++++++++++
 qemu-options.hx                      |   3 +
 tests/.gitignore                     |   1 +
 tests/Makefile.include               |   7 +-
 tests/test-keyval.c                  | 395 +++++++++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c   | 194 ++++++++++++++++-
 util/Makefile.objs                   |   1 +
 util/keyval.c                        | 150 +++++++++++++
 vl.c                                 |  50 +++++
 11 files changed, 974 insertions(+), 10 deletions(-)
 create mode 100644 tests/test-keyval.c
 create mode 100644 util/keyval.c

-- 
2.7.4
