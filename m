Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LN-0001N7-4s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LI-0003ge-DI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gG-6z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31A40C049D5D
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:29:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:29:20 +0200
Message-Id: <20170717092923.12317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Audio 20170717 patches
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

The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb5=
4f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70711' into staging (2017-07-13 10:47:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20170717-pull-request

for you to fetch changes up to 639b49ef9a4dc9555ed6aaefa8dfda621e4165cf:

  audio/adlib: remove limitation of one adlib card (2017-07-17 11:09:02 +=
0200)

----------------------------------------------------------------
audio: fixes for 2.10

----------------------------------------------------------------

Herv=C3=A9 Poussineau (2):
  audio/fmopl: modify timer callback to give opaque and channel
    parameters in two arguments
  audio/adlib: remove limitation of one adlib card

Peng Hao (1):
  audio: st_rate_flow exist a infinite loop

 audio/rate_template.h |  6 ++++++
 hw/audio/fmopl.h      |  7 ++++---
 hw/audio/adlib.c      | 14 +++-----------
 hw/audio/fmopl.c      | 18 +++++++++++++-----
 4 files changed, 26 insertions(+), 19 deletions(-)

--=20
2.9.3
