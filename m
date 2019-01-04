Received: from eggs.gnu.org ([208.118.235.92]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTxS-00021y-D2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTxP-0003A8-9P
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:12:34 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 19:12:05 +0100
Message-Id: <20190104181208.7809-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] cutils: Cleanup, improve documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This series is a fairly trivial cleanup of "cutils.h"
(size_to_str() and ctype macros moved into it), and
some documentation improvements.

Since v1:
- Fixed checkpatch errors (patchew)
- Added Stefano R-b

There are still checkpatch warnings (due to 8c06fbdf36b) for using the
Doxygen '/**' comment opening:

    WARNING: Block comments use a leading /* on a separate line
    #42: FILE: include/qemu/cutils.h:160:
    +/**

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
 ui/keymaps.c                 |   1 +
 util/cutils.c                | 191 -------------------------
 util/id.c                    |   2 +-
 util/readline.c              |   1 -
 14 files changed, 271 insertions(+), 215 deletions(-)

--=20
2.17.2
