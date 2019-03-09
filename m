Received: from eggs.gnu.org ([209.51.188.92]:53081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZP-00011D-9l
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZN-0004BG-3N
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  9 Mar 2019 19:19:18 +0100
Message-Id: <20190309181920.30553-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] fw_cfg: Trivial cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org

Hi Laurent,

These 2 patches are trivial cleanups extracted from a bigger fw_cfg serie=
s.

Please consider for your next Trivial pull request.

Regards,

Phil.

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

Philippe Mathieu-Daud=C3=A9 (2):
  hw/arm/virt: Remove null-check in virt_build_smbios()
  hw/nvram/fw_cfg: Use the ldst API

 hw/arm/virt.c     | 4 ----
 hw/nvram/fw_cfg.c | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

--=20
2.20.1
