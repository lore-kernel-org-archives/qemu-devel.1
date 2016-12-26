Received: from eggs.gnu.org ([2001:4830:134:3::10]:49416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl5-0007nr-AD
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl0-0001yJ-EU
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:39 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44293)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl0-0001xi-3S
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:34 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 22:24:29 +0100
Message-Id: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] trace: Fix event tracing during vCPU
 hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

The vCPU list needs to be locked to avoid memory corruption with concurre=
nt
hot-(un)plugs, and per-vCPU events need to be disabled during vCPU hot-un=
plug.

Also adds event "guest_cpu_exit" to track vCPU hot-unplugging.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---


Llu=C3=ADs Vilanova (3):
      trace: Lock vCPU list when initializing dynamic tracing state
      trace: Fix dynamic event state on vCPU hot-unplug
      trace: Add event "guest_cpu_exit"


 qom/cpu.c              |    2 ++
 trace-events           |    6 ++++++
 trace/control-target.c |   11 ++++++++++-
 trace/control.c        |   19 +++++++++++++++++++
 trace/control.h        |    8 ++++++++
 5 files changed, 45 insertions(+), 1 deletion(-)


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
