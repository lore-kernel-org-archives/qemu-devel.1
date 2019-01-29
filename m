Received: from [209.51.188.92] (port=50693 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUum-0000k3-PI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUtl-0003nv-UL
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:02:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goUtl-0003Zo-MX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:02:01 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 16:00:24 +0100
Message-Id: <20190129150029.29829-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] sdl: Let it be optional (in particular,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg590116.html
[lists.gnu.org down?]

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[down] 'hw/lm32: Move LM32 specific hardware out of common-obj list=
'
002/5:[----] [--] 'configure: LM32 Milkymist Texture Mapping Unit (tmu2) =
also depends of X11'
003/5:[----] [-C] 'hw/display/milkymist-tmu2: Explicit the dependency to =
both X11 / OpenGL'
004/5:[0002] [FC] 'configure: Let SDL support be optional on OpenBSD'
005/5:[----] [--] 'hw/display/milkymist-tmu2: Move inlined code from head=
er to source'

Philippe Mathieu-Daud=C3=A9 (5):
  hw/lm32: Move LM32 specific hardware out of common-obj list
  configure: LM32 Milkymist Texture Mapping Unit (tmu2) also depends of
    X11
  hw/display/milkymist-tmu2: Explicit the dependency to both X11 /
    OpenGL
  configure: Let SDL support be optional on OpenBSD
  hw/display/milkymist-tmu2: Move inlined code from header to source

 MAINTAINERS                         |  1 +
 configure                           | 16 +++++++-
 default-configs/lm32-softmmu.mak    |  2 +-
 hw/audio/Makefile.objs              |  2 +-
 hw/char/Makefile.objs               |  6 +--
 hw/display/Makefile.objs            |  8 ++--
 hw/display/milkymist-tmu2.c         | 49 ++++++++++++++++++++++
 hw/intc/Makefile.objs               |  2 +-
 hw/lm32/milkymist-hw.h              | 63 -----------------------------
 hw/lm32/milkymist.c                 |  1 +
 hw/timer/Makefile.objs              |  4 +-
 include/hw/display/milkymist_tmu2.h | 41 +++++++++++++++++++
 12 files changed, 119 insertions(+), 76 deletions(-)
 create mode 100644 include/hw/display/milkymist_tmu2.h

--=20
2.20.1
