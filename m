Received: from eggs.gnu.org ([209.51.188.92]:33443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KED-0006YN-AT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KEC-0001uL-Kj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:25 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 13:35:04 +0100
Message-Id: <20190311123507.24867-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] coroutine: add x86 specific coroutine
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is in preparation for CET support for x86.

I know this is very late, but if possible I'd like to have this in 4.0
as an experimental backend.

Paolo Bonzini (3):
  qemugdb: fix licensing
  qemugdb: allow adding support for other coroutine backends
  coroutine: add x86 specific coroutine backend

 configure                             |   8 +
 scripts/qemu-gdb.py                   |   7 +-
 scripts/qemugdb/coroutine.py          | 114 +++++---------
 scripts/qemugdb/coroutine_ucontext.py |  69 +++++++++
 scripts/qemugdb/coroutine_x86.py      |  21 +++
 scripts/qemugdb/mtree.py              |   7 +-
 scripts/qemugdb/tcg.py                |   7 +-
 util/coroutine-x86.c                  | 212 ++++++++++++++++++++++++++
 8 files changed, 350 insertions(+), 95 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_ucontext.py
 create mode 100644 scripts/qemugdb/coroutine_x86.py
 create mode 100644 util/coroutine-x86.c

--=20
2.20.1
