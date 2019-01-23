Received: from eggs.gnu.org ([209.51.188.92]:59975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLb-0008Fj-M8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLZ-0008G1-Bp
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmKLY-00087Q-8k
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:44 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 16:21:06 +0100
Message-Id: <20190123152112.15757-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] audio: rework driver probing.
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



Gerd Hoffmann (6):
  audio: use pkg-config
  audio: allow optional audio drivers.
  audio: use try-sdl for openbsd
  audio: check for pulseaudio daemon pidfile
  audio: error message tweak
  audio: probe audio drivers by default

 configure       | 81 ++++++++++++++++++++++++++++++++-------------------------
 audio/audio.c   | 11 ++++----
 audio/paaudio.c | 13 +++++++++
 3 files changed, 64 insertions(+), 41 deletions(-)

-- 
2.9.3
