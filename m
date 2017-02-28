Received: from eggs.gnu.org ([2001:4830:134:3::10]:33595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDt-00056S-Rm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDq-0000WK-Ph
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDq-0000Vh-H4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:18 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B750880B56
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQHIW011076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:51 +0100
Message-Id: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Actually, the command line option is the least part of this series.
Its bulk is about building infrastructure and getting errors out of
the JSON parser[*].  The latter part could be spun out in its own
series, if that helps.  We'll see.

The design of the command line interface was discussed here:
Subject: Non-flat command line option argument syntax
Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:

  vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28

for you to fetch changes up to cf66cd3cad56827ae943cc6d752ec619f448b7d7:

  keyval: Support lists (2017-02-28 23:17:56 +0100)

----------------------------------------------------------------
block: Command line option -blockdev

----------------------------------------------------------------
Daniel P. Berrange (1):
      qapi: qobject input visitor variant for use with keyval_parse()

Markus Armbruster (50):
      qga: Fix crash on non-dictionary QMP argument
      libqtest: Work around a "QMP wants a newline" bug
      qmp-test: New, covering basic QMP protocol
      qmp: Dumb down how we run QMP command registration
      qmp: Clean up how we enforce capability negotiation
      qmp: Drop duplicated QMP command object checks
      qmp: Eliminate silly QERR_QMP_* macros
      qmp: Improve QMP dispatch error messages
      qapi: Improve a QObject input visitor error message
      qapi: Clean up after commit 3d344c2
      qapi: Make QObject input visitor set *list reliably
      qapi: Improve qobject input visitor error reporting
      qapi: Drop string input visitor method optional()
      qapi: Make string input and opts visitor require non-null input
      qom: Make object_property_set_qobject()'s input visitor strict
      test-qobject-input-visitor: Use strict visitor
      qapi: Drop unused non-strict qobject input visitor
      tests-qobject-input-strict: Merge into test-qobject-input-visitor
      test-string-input-visitor: Tear down existing test automatically
      test-string-input-visitor: Improve list coverage
      tests: Cover partial input visit of list
      test-qobject-input-visitor: Cover missing nested struct member
      qapi: Make input visitors detect unvisited list tails
      tests: Cover input visit beyond end of list
      qapi: Fix object input visit beyond end of list
      qapi: Improve qobject visitor documentation
      Merge branch 'qapi-next' into block-next
      test-qemu-opts: Cover qemu_opts_parse() of "no"
      tests: Fix gcov-files-test-qemu-opts-y, gcov-files-test-logging-y
      keyval: New keyval_parse()
      test-keyval: Cover use with qobject input visitor
      qapi: Factor out common part of qobject input visitor creation
      qapi: Factor out common qobject_input_get_keyval()
      qobject: Propagate parse errors through qobject_from_jsonv()
      libqtest: Fix qmp() & friends to abort on JSON parse errors
      qjson: Abort earlier on qobject_from_jsonf() misuse
      test-qobject-input-visitor: Abort earlier on bad test input
      qobject: Propagate parse errors through qobject_from_json()
      block: More detailed syntax error reporting for JSON filenames
      check-qjson: Test errors from qobject_from_json()
      test-visitor-serialization: Pass &error_abort to qobject_from_json()
      monitor: Assert qmp_schema_json[] is sane
      test-qapi-util: New, covering qapi/qapi-util.c
      qapi: New parse_qapi_name()
      keyval: Restrict key components to valid QAPI names
      qapi: New qobject_input_visitor_new_str() for convenience
      block: Initial implementation of -blockdev
      qapi: Improve how keyval input visitor reports unexpected dicts
      docs/qapi-code-gen.txt: Clarify naming rules
      keyval: Support lists

 MAINTAINERS                           |   1 +
 block.c                               |   9 +-
 block/nbd.c                           |   2 +-
 block/nfs.c                           |   2 +-
 block/ssh.c                           |   2 +-
 docs/qapi-code-gen.txt                |  63 ++--
 hw/ppc/spapr_drc.c                    |   5 +
 include/monitor/monitor.h             |   1 +
 include/qapi/qmp/qerror.h             |   9 -
 include/qapi/qmp/qjson.h              |   5 +-
 include/qapi/qobject-input-visitor.h  |  61 +++-
 include/qapi/qobject-output-visitor.h |  35 +-
 include/qapi/util.h                   |   2 +
 include/qapi/visitor-impl.h           |   7 +-
 include/qapi/visitor.h                |  19 +-
 include/qemu/module.h                 |   2 -
 include/qemu/option.h                 |   3 +
 monitor.c                             | 151 +++-----
 qapi/opts-visitor.c                   |  12 +
 qapi/qapi-util.c                      |  47 +++
 qapi/qapi-visit-core.c                |   8 +
 qapi/qmp-dispatch.c                   |  22 +-
 qapi/qobject-input-visitor.c          | 429 ++++++++++++++++++-----
 qapi/string-input-visitor.c           |  97 +++---
 qapi/trace-events                     |   1 +
 qemu-options.hx                       |   7 +
 qga/main.c                            |   2 +-
 qmp.c                                 |   2 +-
 qobject/qjson.c                       |  14 +-
 qom/qom-qobject.c                     |   4 +-
 scripts/qapi-commands.py              |   7 +-
 scripts/qapi-visit.py                 |   3 +
 target/s390x/cpu_models.c             |   2 +-
 tests/.gitignore                      |   2 +
 tests/Makefile.include                |  19 +-
 tests/check-qjson.c                   |  88 +++--
 tests/check-qnull.c                   |   2 +-
 tests/libqtest.c                      |  32 +-
 tests/libqtest.h                      |   8 +
 tests/qmp-test.c                      | 139 ++++++++
 tests/test-keyval.c                   | 624 ++++++++++++++++++++++++++++++++++
 tests/test-opts-visitor.c             |  80 +++++
 tests/test-qapi-util.c                |  85 +++++
 tests/test-qemu-opts.c                |   5 +
 tests/test-qga.c                      |   2 +-
 tests/test-qmp-commands.c             |   4 +-
 tests/test-qobject-input-strict.c     | 381 ---------------------
 tests/test-qobject-input-visitor.c    | 446 +++++++++++++++++++++++-
 tests/test-string-input-visitor.c     | 142 ++++++--
 tests/test-visitor-serialization.c    |   4 +-
 trace-events                          |   1 -
 util/Makefile.objs                    |   1 +
 util/keyval.c                         | 394 +++++++++++++++++++++
 vl.c                                  |  41 ++-
 54 files changed, 2748 insertions(+), 788 deletions(-)
 create mode 100644 tests/qmp-test.c
 create mode 100644 tests/test-keyval.c
 create mode 100644 tests/test-qapi-util.c
 delete mode 100644 tests/test-qobject-input-strict.c
 create mode 100644 util/keyval.c

-- 
2.7.4
