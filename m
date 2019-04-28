Received: from eggs.gnu.org ([209.51.188.92]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKacz-0001sm-4c
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKaVt-00051a-E3
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:30:02 -0400
Received: from pv50p00im-ztdg10011901.me.com ([17.58.6.50]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hKaVt-00050l-5f
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:30:01 -0400
From: Chen Zhang <tgfbeta@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
Date: Sun, 28 Apr 2019 11:29:54 +0800
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND 0/2] ui/cocoa: Fix absolute and relative
 input issues on Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

The following patches fixed absolute and relative input device issues on =
macOS Mojave.

Chen Zhang (2):
  ui/cocoa: Fix absolute input device grabbing issue on Mojave
  ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
    device

 ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

--=20
2.19.2=
