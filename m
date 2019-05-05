Received: from eggs.gnu.org ([209.51.188.92]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNP3-00026D-1c
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNOz-0002oO-Vd
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:29 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 22:05:57 +0200
Message-Id: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] hw/block/pflash: Add DeviceReset() handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The pflash device lacks a reset() function.
When a machine is resetted, the flash might be in an
inconsistent state, leading to unexpected behavior:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713

Resolve this issue by adding a DeviceReset() handler.

Both CFI01/CFI02 devices are fixed by this series.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/block/pflash_cfi01: Removed an unused timer
  hw/block/pflash_cfi01: Extract the pflash_reset() code
  hw/block/pflash_cfi01: Add the DeviceReset() handler
  hw/block/pflash_cfi02: Extract the pflash_reset() code
  hw/block/pflash_cfi02: Add the DeviceReset() handler

 hw/block/pflash_cfi01.c | 31 ++++++++++++-------------------
 hw/block/pflash_cfi02.c | 31 +++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 29 deletions(-)

--=20
2.20.1
