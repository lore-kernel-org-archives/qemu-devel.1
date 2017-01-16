Received: from eggs.gnu.org ([2001:4830:134:3::10]:42214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7an-0004r8-6X
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7ak-0005FP-0z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7aj-0005F0-Qb
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:44:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:44:51 +0000
Message-Id: <20170116134455.28636-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Tracing patches
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

The following changes since commit 2ccede18bd24fce5db83fef3674563a1f25671=
7b:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-req=
uest' into staging (2017-01-16 12:41:35 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to a47e87151e785977d34e7b726495e7781860ca9f:

  trace: Add event "guest_cpu_exit" (2017-01-16 13:40:56 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Llu=C3=ADs Vilanova (3):
  trace: Lock vCPU list when initializing dynamic tracing state
  trace: Fix dynamic event state on vCPU hot-unplug
  trace: Add event "guest_cpu_exit"

Marc-Andr=C3=A9 Lureau (1):
  trace-events: spelling fix

 trace/control.h        |  8 ++++++++
 qom/cpu.c              |  2 ++
 trace/control-target.c | 11 ++++++++++-
 trace/control.c        | 19 +++++++++++++++++++
 trace-events           |  8 +++++++-
 5 files changed, 46 insertions(+), 2 deletions(-)

--=20
2.9.3
