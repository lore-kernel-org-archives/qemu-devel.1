Received: from eggs.gnu.org ([209.51.188.92]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1yw-0005JE-Gx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1yv-00072F-Lu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj1yv-00071o-GN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:08:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A23DFC0587FF
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:08:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 14 Jan 2019 14:08:26 +0100
Message-Id: <20190114130829.21790-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] typedefs: Remove scarcely used
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

Since this file became a hot topic [*], I took previous cleanups
from last year and continue to clean it.

v2:
- reorder fw_cfg (Laszlo), remove forward declarations
- move PixelFormat to "ui/qemu-pixman.h" (Paolo)
- reword comment (Thomas)

Regards,

Phil.

[*] "HACKING: Clarify the paragraph about typedefs"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02132.html
[*] "Fix duplicated typedefs to be able to compile with Clang in gnu99 mo=
de"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02117.html

Based-on: 1547460140-1473-1-git-send-email-thuth@redhat.com

Philippe Mathieu-Daud=C3=A9 (3):
  hw/nvram/fw_cfg: Remove various typedefs from "qemu/typedefs.h"
  ui/console: Remove MouseTransformInfo from qemu/typedefs.h
  ui/console: Remove PixelFormat from qemu/typedefs.h

 include/hw/acpi/vmgenid.h |  1 +
 include/hw/arm/virt.h     |  1 +
 include/hw/devices.h      |  1 +
 include/hw/mem/nvdimm.h   |  1 +
 include/hw/nvram/fw_cfg.h | 22 ++++++++++++----------
 include/qemu/typedefs.h   |  6 ------
 include/ui/console.h      | 14 ++------------
 include/ui/qemu-pixman.h  | 10 ++++++++++
 8 files changed, 28 insertions(+), 28 deletions(-)

--=20
2.17.2
