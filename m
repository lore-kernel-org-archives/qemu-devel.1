Received: from eggs.gnu.org ([209.51.188.92]:48027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gooXn-0005Fr-89
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gooXb-0000Yg-2o
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gooXS-0000VT-DL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:20 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 30 Jan 2019 13:00:01 +0100
Message-Id: <20190130120005.23123-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/4] Milkymist: Allow building on OpenBSD
 (without SDL)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

since v3:
- simply move LM32 'display' specific hardware (Gerd)
- drop ./configure patch (Gerd)

since v2:
- move LM32 specific hardware out of common-obj to bypass make rules limi=
tations
- use "WARNING" string in configure

v1 was too simple to work, so here we go again.
I hit a problem with the Milkymist TMU device when disabling SDL,
so I fixed it and added another patch in this series which clean
a bit the device, but is not required for this series.
The important patches are 1-3, and eventually 1-2 could be squashed
altogether, although the changes are slighly different.

Regards,

Phil.

v1 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05509.html
v2 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06072.html
v3 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07482.html

Philippe Mathieu-Daud=C3=A9 (4):
  hw/display: Move Milkymist specific hardware out of common-obj list
  configure: LM32 Milkymist Texture Mapping Unit (tmu2) also depends of
    X11
  hw/display/milkymist-tmu2: Explicit the dependency to both X11 /
    OpenGL
  hw/display/milkymist-tmu2: Move inlined code from header to source

 MAINTAINERS                         |  1 +
 configure                           | 10 +++++
 default-configs/lm32-softmmu.mak    |  2 +-
 hw/display/Makefile.objs            |  8 ++--
 hw/display/milkymist-tmu2.c         | 49 ++++++++++++++++++++++
 hw/lm32/milkymist-hw.h              | 63 -----------------------------
 hw/lm32/milkymist.c                 |  1 +
 include/hw/display/milkymist_tmu2.h | 41 +++++++++++++++++++
 8 files changed, 107 insertions(+), 68 deletions(-)
 create mode 100644 include/hw/display/milkymist_tmu2.h

--=20
2.20.1
