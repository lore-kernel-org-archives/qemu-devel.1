Received: from eggs.gnu.org ([2001:4830:134:3::10]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijZ-0004Gg-DJ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijW-00054r-By
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 29 May 2018 14:48:17 -0300
Message-Id: <20180529174821.19964-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>

Hi,

This series converts error_setg(&error_fatal) to error_report() + exit() as
suggested by the "qapi/error.h" documentation.

This reduce Coverity and Clang static analyzer positive falses.

See http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07585.html:

    On 07/24/2017 04:52 PM, Eric Blake wrote:
    That's a shame.  Rather, we should patch this file (and others) to avoid
    all the inconsistent uses of error_setg(&error_*), to comply with the
    error.h documentation.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  hw/block/fdc: Replace error_setg(&error_abort) by error_report() + abort()
  hw/ppc/spapr_drc: Replace error_setg(&error_abort) by error_report() +
    abort()
  hw/arm/sysbus-fdt: Replace error_setg(&error_fatal) by error_report()
    + exit()
  device_tree: Replace error_setg(&error_fatal) by error_report() + exit()

 device_tree.c       | 23 +++++++++++++----------
 hw/arm/sysbus-fdt.c | 45 ++++++++++++++++++++++++++-------------------
 hw/block/fdc.c      |  7 ++++---
 hw/ppc/spapr_drc.c  |  3 ++-
 4 files changed, 45 insertions(+), 33 deletions(-)

-- 
2.17.0
