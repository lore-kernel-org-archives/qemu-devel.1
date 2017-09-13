Received: from eggs.gnu.org ([2001:4830:134:3::10]:49254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41v-00068E-5K
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41s-0004KV-1m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds41r-0004Jv-SS
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1FDC80F94
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:32:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 11:32:11 +0200
Message-Id: <20170913093215.10043-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Usb 20170913 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 619c200f6ce2f44fbc8a5732174530c3b4782a=
ab:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-signe=
d' into staging (2017-09-11 11:44:30 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20170913-pull-request

for you to fetch changes up to 2041649f0b04f61869589571ddf5ecd4f0695ea2:

  usb: only build usb-host with CONFIG_USB=3Dy (2017-09-13 10:44:49 +0200=
)

----------------------------------------------------------------
usb: misc small fixes.

----------------------------------------------------------------

Alexey Kardashevskiy (1):
  xhci: Avoid DMA when ERSTBA is set to zero

Gerd Hoffmann (2):
  usb: drop HOST_USB
  usb: only build usb-host with CONFIG_USB=3Dy

Philippe Mathieu-Daud=C3=A9 (1):
  MAINTAINERS: add missing USB entry

 configure            | 7 -------
 hw/usb/hcd-xhci.c    | 4 ++--
 MAINTAINERS          | 1 +
 hw/usb/Makefile.objs | 6 +++++-
 4 files changed, 8 insertions(+), 10 deletions(-)

--=20
2.9.3
