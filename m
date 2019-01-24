Received: from eggs.gnu.org ([209.51.188.92]:54503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew7-0006CS-1W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew5-0007Xp-2G
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmew1-0007Lb-7x
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:47 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 14:20:13 +0100
Message-Id: <20190124132020.13571-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Audio 20190124 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit f6b06fcceef465de0cf2514c9f76fe01928967=
81:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-requ=
est' into staging (2019-01-23 17:57:47 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20190124-pull-request

for you to fetch changes up to 6a48541873f14b597630283f8f5397674ad82ea9:

  audio: probe audio drivers by default (2019-01-24 13:11:08 +0100)

----------------------------------------------------------------
audio: pc speaker init fix, rework driver probing

----------------------------------------------------------------

Gerd Hoffmann (7):
  audio: fix pc speaker init
  audio: use pkg-config
  audio: allow optional audio drivers.
  audio: use try-sdl for openbsd
  audio: check for pulseaudio daemon pidfile
  audio: error message tweak
  audio: probe audio drivers by default

 configure        | 81 +++++++++++++++++++++++++++++++-------------------=
------
 audio/audio.c    | 12 +++++----
 audio/paaudio.c  | 15 +++++++++++
 hw/audio/pcspk.c | 35 +++++++++++-------------
 4 files changed, 82 insertions(+), 61 deletions(-)

--=20
2.9.3
