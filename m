Received: from eggs.gnu.org ([208.118.235.92]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcCml-0006ss-4p
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcCmh-00055v-73
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 26 Dec 2018 18:15:35 +0100
Message-Id: <20181226171538.21984-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] cutils: Cleanup, improve documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This series is a fairly trivial cleanup of "cutils.h"
(size_to_str() and ctype macros moved into it), and
some documentation improvements.

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
 include/qemu/cutils.h        | 261 +++++++++++++++++++++++++++++++++++
 qapi/qapi-util.c             |   2 +-
 qapi/string-output-visitor.c |   2 +-
 qobject/json-parser.c        |   1 -
 target/ppc/monitor.c         |   1 +
 ui/keymaps.c                 |   1 +
 util/cutils.c                | 191 -------------------------
 util/id.c                    |   2 +-
 util/readline.c              |   1 -
 14 files changed, 270 insertions(+), 215 deletions(-)

--=20
2.17.2
