Received: from eggs.gnu.org ([209.51.188.92]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSo-0003i6-Vy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSo-0000IZ-7W
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmDSn-0000Gl-Ui
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:46 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 09:00:01 +0100
Message-Id: <20190123080005.31078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] audio: rework driver probing.
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



Gerd Hoffmann (4):
  audio: use pkg-config
  audio: allow optional audio drivers.
  audio: use try-sdl and try-pa for openbsd
  [RfC] audio: probe audio drivers by default

 configure | 83 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

-- 
2.9.3
