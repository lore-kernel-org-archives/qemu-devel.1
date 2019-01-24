Received: from eggs.gnu.org ([209.51.188.92]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTck-000418-1w
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTcj-0000QR-Ag
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTcj-0000Po-4f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:05 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:15:50 +0100
Message-Id: <20190124011554.25418-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] sdl: Let it be optional (in particular,
 on OpenBSD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

v1 was too simple to work, so here we go again.
I hit a problem with the Milkymist TMU device when disabling SDL,
so I fixed it and added another patch in this series which clean
a bit the device, but is not required for this series.
The important patches are 1-3, and eventually 1-2 could be squashed
altogether, although the changes are slighly different.

Regards,

Phil.

v1 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05509.html

Philippe Mathieu-Daud=C3=A9 (4):
  configure: LM32 Milkymist Texture Mapping Unit (tmu2) also depends of
    X11
  hw/display/milkymist-tmu2: Explicit the dependency to both X11 /
    OpenGL
  configure: Let SDL support be optional on OpenBSD
  hw/display/milkymist-tmu2: Move inlined code from header to source

 MAINTAINERS                         |  1 +
 configure                           | 16 +++++++-
 default-configs/lm32-softmmu.mak    |  2 +-
 hw/display/Makefile.objs            |  4 +-
 hw/display/milkymist-tmu2.c         | 49 ++++++++++++++++++++++
 hw/lm32/milkymist-hw.h              | 63 -----------------------------
 hw/lm32/milkymist.c                 |  1 +
 include/hw/display/milkymist_tmu2.h | 41 +++++++++++++++++++
 8 files changed, 110 insertions(+), 67 deletions(-)
 create mode 100644 include/hw/display/milkymist_tmu2.h

--=20
2.20.1
