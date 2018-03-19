Received: from eggs.gnu.org ([2001:4830:134:3::10]:51486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exxrK-000419-BL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exxrH-0003FW-5j
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:42:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exxrH-0003Ea-09
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:42:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A01AE4023BB3
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 16:41:58 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60DFF2166BAE
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 16:41:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Mar 2018 11:41:14 -0500
Message-Id: <20180319164152.1077050-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805=
be:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-03-19 11:44:26 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v3

for you to fetch changes up to ebf1105a7086897da6963edefdb247c80f605424:

  qapi: Pass '-u' when doing non-silent diff (2018-03-19 11:32:36 -0500)

in v3:
rebase to master (a few more qobject_to_qdict() uses crept in)
squash in Peter Xu's fixup for test failures
[if tests still fail, then I will send a v4 without OOB from 2.12]
sending only the patches that changed from v2

----------------------------------------------------------------
qapi patches for 2018-03-12, 2.12 softfreeze

- Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
- Max Reitz: 0/7 block: Handle null backing link
- Daniel P. Berrange: chardev: tcp: postpone TLS work until machine done
- Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
- Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
- Eric Blake: qapi: Pass '-u' when doing non-silent diff

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (1):
      chardev: tcp: postpone TLS work until machine done

Eric Blake (2):
      qmp: add new event "command-dropped"
      qapi: Pass '-u' when doing non-silent diff

Marc-Andr=C3=A9 Lureau (4):
      qapi2texi: minor python code simplification
      qlit: use QType instead of int
      qlit: add qobject_from_qlit()
      qapi: generate a literal qobject for introspection

Max Reitz (7):
      compiler: Add QEMU_BUILD_BUG_MSG() macro
      qapi: Add qobject_to()
      qapi: Replace qobject_to_X(o) by qobject_to(X, o)
      qapi: Remove qobject_to_X() functions
      qapi: Make more of qobject_to()
      block: Handle null backing link
      block: Deprecate "backing": ""

Peter Xu (22):
      docs: update QMP documents for OOB commands
      qobject: introduce qstring_get_try_str()
      qobject: introduce qobject_get_try_str()
      qobject: let object_property_get_str() use new API
      monitor: move skip_flush into monitor_data_init
      monitor: move the cur_mon hack deeper for QMP
      monitor: unify global init
      monitor: let mon_list be tail queue
      monitor: allow using IO thread for parsing
      qmp: introduce QMPCapability
      monitor: introduce monitor_qmp_respond()
      monitor: let suspend_cnt be thread safe
      monitor: let suspend/resume work even with QMPs
      monitor: separate QMP parser and dispatcher
      monitor: send event when command queue full
      qapi: introduce new cmd option "allow-oob"
      qmp: support out-of-band (oob) execution
      qmp: isolate responses into io thread
      monitor: enable IO thread for (qmp & !mux) typed
      qmp: add command "x-oob-test"
      tests: qmp-test: verify command batching
      tests: qmp-test: add oob test

Vladimir Sementsov-Ogievskiy (2):
      block/accounting: introduce latency histogram
      qapi: add block latency histogram interface

 docs/devel/qapi-code-gen.txt        |  87 ++++-
 docs/interop/qmp-spec.txt           |  36 +-
 qemu-doc.texi                       |   7 +
 qapi/block-core.json                | 115 +++++-
 qapi/introspect.json                |   6 +-
 qapi/misc.json                      |  87 ++++-
 scripts/qapi/commands.py            |  18 +-
 scripts/qapi/common.py              |  15 +-
 scripts/qapi/doc.py                 |   9 +-
 scripts/qapi/introspect.py          |  83 +++--
 include/block/accounting.h          |  35 ++
 include/monitor/monitor.h           |   2 +-
 include/qapi/qmp/dispatch.h         |   7 +-
 include/qapi/qmp/qbool.h            |   1 -
 include/qapi/qmp/qdict.h            |   1 -
 include/qapi/qmp/qlist.h            |   1 -
 include/qapi/qmp/qlit.h             |   4 +-
 include/qapi/qmp/qnum.h             |   1 -
 include/qapi/qmp/qobject.h          |  30 ++
 include/qapi/qmp/qstring.h          |   3 +-
 include/qemu/compiler.h             |  12 +-
 vl.c                                |   7 +-
 tests/libqtest.c                    |   6 +-
 block.c                             |  13 +-
 block/accounting.c                  |  91 +++++
 block/parallels.c                   |   2 +-
 block/qapi.c                        |  53 ++-
 block/qcow.c                        |   2 +-
 block/qcow2.c                       |   2 +-
 block/qed.c                         |   2 +-
 block/rbd.c                         |   8 +-
 block/sheepdog.c                    |   2 +-
 block/vhdx.c                        |   2 +-
 block/vpc.c                         |   2 +-
 blockdev.c                          |  64 +++-
 chardev/char-socket.c               |  10 +
 hw/i386/acpi-build.c                |  16 +-
 monitor.c                           | 706 ++++++++++++++++++++++++++++++=
+-----
 qapi/qmp-dispatch.c                 |  35 +-
 qapi/qobject-input-visitor.c        |  24 +-
 qapi/qobject-output-visitor.c       |   4 +-
 qga/main.c                          |   2 +-
 qmp.c                               |  18 +-
 qobject/json-parser.c               |  13 +-
 qobject/qbool.c                     |  15 +-
 qobject/qdict.c                     |  65 ++--
 qobject/qjson.c                     |  10 +-
 qobject/qlist.c                     |  17 +-
 qobject/qlit.c                      |  47 ++-
 qobject/qnum.c                      |  17 +-
 qobject/qstring.c                   |  38 +-
 qom/object.c                        |  15 +-
 target/i386/cpu.c                   |   2 +-
 target/s390x/cpu_models.c           |   2 +-
 tests/check-qdict.c                 |  20 +-
 tests/check-qjson.c                 |  41 ++-
 tests/check-qlist.c                 |   4 +-
 tests/check-qlit.c                  |  30 +-
 tests/check-qnum.c                  |   4 +-
 tests/check-qobject.c               |   2 +-
 tests/check-qstring.c               |   2 +-
 tests/device-introspect-test.c      |  14 +-
 tests/numa-test.c                   |   8 +-
 tests/qmp-test.c                    |  97 ++++-
 tests/qom-test.c                    |   4 +-
 tests/test-char.c                   |   2 +-
 tests/test-keyval.c                 |   8 +-
 tests/test-qga.c                    |  19 +-
 tests/test-qmp-cmds.c               |  12 +-
 tests/test-qmp-event.c              |  16 +-
 tests/test-qobject-input-visitor.c  |  21 +-
 tests/test-qobject-output-visitor.c |  54 +--
 tests/test-x86-cpuid-compat.c       |  17 +-
 util/keyval.c                       |   4 +-
 util/qemu-config.c                  |   2 +-
 util/qemu-option.c                  |   6 +-
 qemu-options.hx                     |   4 +-
 tests/Makefile.include              |   8 +-
 tests/qapi-schema/test-qapi.py      |   2 +-
 tests/qemu-iotests/089              |  20 +
 tests/qemu-iotests/089.out          |   8 +
 trace-events                        |   3 +
 82 files changed, 1810 insertions(+), 494 deletions(-)

--=20
2.14.3
