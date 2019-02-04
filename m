Received: from eggs.gnu.org ([209.51.188.92]:45738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXJ-0004NB-Q7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXI-0001ts-Rs
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:13 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 22:12:01 +0100
Message-Id: <20190204211204.27321-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] cutils: Cleanup, improve documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This series is a fairly trivial cleanup of "cutils.h"
(size_to_str() and ctype macros moved into it), and
some documentation improvements.

Since v2:
- Fixed RISC-V (Laurent)

Since v1:
- Fixed checkpatch errors (patchew)
- Added Stefano R-b

$ git backport-diff -u v2
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/3:[----] [--] 'util/cutils: Move size_to_str() from "qemu-common.h" t=
o "cutils.h"'
002/3:[0001] [FC] 'util/cutils: Move ctype macros to "cutils.h"'
003/3:[----] [--] 'util/cutils: Move function documentations to the heade=
r'

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00629.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05927.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  util/cutils: Move size_to_str() from "qemu-common.h" to "cutils.h"
  util/cutils: Move ctype macros to "cutils.h"
  util/cutils: Move function documentations to the header

 hw/core/bus.c                |   2 +-
 hw/core/qdev-properties.c    |   1 +
 hw/s390x/s390-virtio-ccw.c   |   1 +
 hw/scsi/scsi-generic.c       |   2 +-
 include/qemu-common.h        |  17 ---
 include/qemu/cutils.h        | 262 +++++++++++++++++++++++++++++++++++
 qapi/qapi-util.c             |   2 +-
 qapi/string-output-visitor.c |   2 +-
 qobject/json-parser.c        |   1 -
 target/ppc/monitor.c         |   1 +
 target/riscv/cpu.c           |   1 +
 ui/keymaps.c                 |   1 +
 util/cutils.c                | 191 -------------------------
 util/id.c                    |   2 +-
 util/readline.c              |   1 -
 15 files changed, 272 insertions(+), 215 deletions(-)

--=20
2.20.1
