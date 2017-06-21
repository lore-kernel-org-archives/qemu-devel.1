Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dNXLH-0007Fo-NL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dNXLE-0003OO-Lm
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:11 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:29985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dNXLE-0003Mz-Fx
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:08 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Wed, 21 Jun 2017 06:33:59 +0200
Message-Id: <20170621043401.19842-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Support multiple adlib sound cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hi,

This patchset removes a global variable in adlib emulation, and allows to
have multiple adlib sound cards.
Note that indentation seem off because I have replaced some tabulations b=
y spaces.

Before:
qemu-system-i386 -device adlib,iobase=3D0x220 -device adlib,iobase=3D0x24=
0
qemu-system-i386: -device adlib,iobase=3D0x240: Cannot create more than 1=
 adlib device

After:
qemu-system-i386 -device adlib,iobase=3D0x220 -device adlib,iobase=3D0x24=
0
Machine starts.

Herv=C3=A9

Herv=C3=A9 Poussineau (2):
  audio/fmopl: modify timer callback to give opaque and channel
    parameters in two arguments
  audio/adlib: remove limitation of one adlib card

 hw/audio/adlib.c | 14 +++-----------
 hw/audio/fmopl.c | 18 +++++++++++++-----
 hw/audio/fmopl.h |  7 ++++---
 3 files changed, 20 insertions(+), 19 deletions(-)

--=20
2.11.0
