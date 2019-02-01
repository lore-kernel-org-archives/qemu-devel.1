Received: from eggs.gnu.org ([209.51.188.92]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXyq-0002M0-Ae
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpXye-0004cg-C0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gpXyZ-0004as-BF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:31:19 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Feb 2019 13:30:55 +0100
Message-Id: <20190201123100.27419-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Ui 20190201 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e8977901b79fb678f288dd372261b640bbeccd=
0d:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-01-31 15:40:39 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190201-pull-request

for you to fetch changes up to 0015ca5cbabe0b31d31610ddfaafd90a9e5911a4:

  ui: remove support for SDL1.2 in favour of SDL2 (2019-02-01 11:59:12 +0=
100)

----------------------------------------------------------------
ui: fix build with SDL disabled, drop SDL1 support.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  ui: remove support for SDL1.2 in favour of SDL2

Philippe Mathieu-Daud=C3=A9 (4):
  hw/display: Move Milkymist specific hardware out of common-obj list
  configure: LM32 Milkymist Texture Mapping Unit (tmu2) also depends of
    X11
  hw/display/milkymist-tmu2: Explicit the dependency to both X11 /
    OpenGL
  hw/display/milkymist-tmu2: Move inlined code from header to source

 configure                           |   70 +--
 hw/lm32/milkymist-hw.h              |   63 ---
 include/hw/display/milkymist_tmu2.h |   41 ++
 ui/sdl_zoom.h                       |   25 -
 ui/sdl_zoom_template.h              |  219 --------
 hw/display/milkymist-tmu2.c         |   49 ++
 hw/lm32/milkymist.c                 |    1 +
 ui/sdl.c                            | 1027 -----------------------------=
------
 ui/sdl_zoom.c                       |   93 ----
 MAINTAINERS                         |    1 +
 default-configs/lm32-softmmu.mak    |    2 +-
 hw/display/Makefile.objs            |    8 +-
 qemu-deprecated.texi                |    9 -
 ui/Makefile.objs                    |    5 -
 14 files changed, 114 insertions(+), 1499 deletions(-)
 create mode 100644 include/hw/display/milkymist_tmu2.h
 delete mode 100644 ui/sdl_zoom.h
 delete mode 100644 ui/sdl_zoom_template.h
 delete mode 100644 ui/sdl.c
 delete mode 100644 ui/sdl_zoom.c

--=20
2.9.3
