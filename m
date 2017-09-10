Received: from eggs.gnu.org ([2001:4830:134:3::10]:39275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4pQ-0002S1-8W
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4pL-0008Ix-Ag
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:11:24 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54972)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4pK-0008IZ-Vn
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:11:19 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:11:07 +0300
Message-Id: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] trace: Add guest code events
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

Adds events to trace guest code execution.

Events with additional info are disabled by default to minimize overheads=
, since
that additional information might not be necessarily needed.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Llu=C3=ADs Vilanova (7):
      trace: Add event "guest_bbl_before"
      trace: Add event "guest_inst_before"
      trace: Add event "guest_inst_info_before"
      tcg: Add support for "inlining" regions of code
      trace: Add event "guest_bbl_after"
      trace: Add event "guest_inst_after"
      trace: Add event "guest_inst_info_after"


 accel/tcg/translator.c    |  104 ++++++++++++++++++++++++++++
 include/exec/translator.h |   22 ++++++
 include/qemu/log.h        |    1=20
 include/qemu/typedefs.h   |    1=20
 tcg/tcg-op.c              |    2 +
 tcg/tcg-op.h              |   40 +++++++++++
 tcg/tcg-opc.h             |    3 +
 tcg/tcg.c                 |  166 +++++++++++++++++++++++++++++++++++++++=
++++++
 tcg/tcg.h                 |   23 ++++++
 trace-events              |   55 +++++++++++++++
 util/log.c                |    2 +
 11 files changed, 418 insertions(+), 1 deletion(-)


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
