Received: from eggs.gnu.org ([2001:4830:134:3::10]:45605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvF-0001Jr-Q6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvF-0003JP-2W
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:05 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:57:54 +0200
Message-Id: <20180618095758.5006-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Vga 20180618 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180618-pull-request

for you to fetch changes up to 58d632c7ce66c272868b057491cec7ee5a6a1050:

  Add ramfb MAINTAINERS entry (2018-06-18 11:24:25 +0200)

----------------------------------------------------------------
vga: add ramfb, print virglrenderer version

----------------------------------------------------------------

Gerd Hoffmann (3):
  hw/display: add ramfb, a simple boot framebuffer living in guest ram
  hw/display: add standalone ramfb device
  Add ramfb MAINTAINERS entry

Marc-Andr=C3=A9 Lureau (1):
  configure: print virglrenderer version

 configure                     |  3 +-
 include/hw/display/ramfb.h    | 12 ++++++
 hw/arm/sysbus-fdt.c           |  7 ++++
 hw/arm/virt.c                 |  2 +
 hw/display/ramfb-standalone.c | 62 ++++++++++++++++++++++++++++
 hw/display/ramfb.c            | 95 +++++++++++++++++++++++++++++++++++++=
++++++
 hw/i386/pc_piix.c             |  2 +
 hw/i386/pc_q35.c              |  2 +
 MAINTAINERS                   |  6 +++
 hw/display/Makefile.objs      |  3 ++
 10 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb-standalone.c
 create mode 100644 hw/display/ramfb.c

--=20
2.9.3
