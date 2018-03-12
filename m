Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0000gC-FD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJR-0005wM-Na
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJR-0005vy-HZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 234B94000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:34 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCAA4215CDAC
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:51 -0500
Message-Id: <20180312183628.394722-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
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

The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b669=
6e:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-r=
equest' into staging (2018-03-12 16:14:37 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12

for you to fetch changes up to a083c533b5a17c77ef164acdbf30eedfa9681fc6:

  qapi: add block latency histogram interface (2018-03-12 13:22:11 -0500)

This builds and passes 'make check', so even though the OOB portion
depends on chardev fixes that are still pending a pull request from
Paolo, that dependence can only be observed at runtime by clients
that use the new oob feature.  Given the timing of soft freeze, and
the fact that the chardev fixes do not form a build dependency, I
think it's okay if this pull request gets processed before Paolo's
(but it's also okay if Paolo's goes in first).

----------------------------------------------------------------
qapi patches for 2018-03-12, 2.12 softfreeze

- Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
- Max Reitz: 0/7 block: Handle null backing link
- Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
- Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram

----------------------------------------------------------------
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

Peter Xu (23):
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
      qmp: add new event "command-dropped"
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
 block/qapi.c                        |  53 ++-
 block/qcow2.c                       |   2 +-
 block/rbd.c                         |   8 +-
 block/sheepdog.c                    |   2 +-
 blockdev.c                          |  64 +++-
 hw/i386/acpi-build.c                |  14 +-
 monitor.c                           | 701 ++++++++++++++++++++++++++++++=
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
 tests/qapi-schema/test-qapi.py      |   2 +-
 tests/qemu-iotests/089              |  20 +
 tests/qemu-iotests/089.out          |   8 +
 trace-events                        |   3 +
 75 files changed, 1785 insertions(+), 484 deletions(-)

--=20
2.14.3
