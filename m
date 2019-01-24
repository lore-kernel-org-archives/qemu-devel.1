Received: from eggs.gnu.org ([209.51.188.92]:51614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4B-0001wz-P0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4B-00051T-3K
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmd4A-00050U-RI
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 12:20:49 +0100
Message-Id: <20190124112055.547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] audio: rework driver probing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

v3:
 * drop pa driver for *bsd.
 * codestyle fixes.

Gerd Hoffmann (6):
  audio: use pkg-config
  audio: allow optional audio drivers.
  audio: use try-sdl for openbsd
  audio: check for pulseaudio daemon pidfile
  audio: error message tweak
  audio: probe audio drivers by default

 configure       | 81 ++++++++++++++++++++++++++++++++-------------------------
 audio/audio.c   | 12 +++++----
 audio/paaudio.c | 15 +++++++++++
 3 files changed, 67 insertions(+), 41 deletions(-)

-- 
2.9.3
