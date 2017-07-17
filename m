Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sD-0002O2-4Y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4s9-0006tn-U8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX4s9-0006tD-Nq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 13:11:20 +0100
Message-Id: <20170717121127.25154-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 304187c51cfe1ffda1afc9b86c4ccae1cbac68cb:

  trace: update old trace events in docs (2017-07-17 13:11:13 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Llu=C3=ADs Vilanova (6):
  trace: Allocate cpu->trace_dstate in place
  trace: [tcg] Delay changes to dynamic state when translating
  exec: [tcg] Use different TBs according to the vCPU's dynamic tracing
    state
  trace: [tcg] Do not generate TCG code to trace dynamically-disabled
    events
  trace: [tcg, trivial] Re-align generated code
  trace: [trivial] Statically enable all guest events

Stefan Hajnoczi (1):
  trace: update old trace events in docs

 docs/devel/tracing.txt                   |  3 +--
 include/exec/exec-all.h                  |  3 +++
 include/exec/tb-hash-xx.h                |  7 +++++--
 include/exec/tb-hash.h                   |  5 +++--
 include/qom/cpu.h                        | 12 ++++++------
 trace/control.h                          |  3 +++
 accel/tcg/cpu-exec.c                     |  8 ++++++--
 accel/tcg/translate-all.c                | 11 +++++++++--
 qom/cpu.c                                |  8 --------
 tcg/tcg-runtime.c                        |  3 ++-
 tests/qht-bench.c                        |  2 +-
 trace/control-target.c                   | 19 +++++++++++++++++--
 trace/control.c                          |  9 ++++++++-
 scripts/tracetool/__init__.py            |  3 ++-
 scripts/tracetool/backend/dtrace.py      |  4 ++--
 scripts/tracetool/backend/ftrace.py      | 20 ++++++++++----------
 scripts/tracetool/backend/log.py         | 19 ++++++++++---------
 scripts/tracetool/backend/simple.py      |  4 ++--
 scripts/tracetool/backend/syslog.py      |  6 +++---
 scripts/tracetool/backend/ust.py         |  4 ++--
 scripts/tracetool/format/h.py            | 26 +++++++++++++++++++-------
 scripts/tracetool/format/tcg_h.py        | 21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |  5 +++--
 trace-events                             |  6 +++---
 24 files changed, 137 insertions(+), 74 deletions(-)

--=20
2.9.4
