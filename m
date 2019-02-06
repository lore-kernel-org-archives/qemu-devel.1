Received: from eggs.gnu.org ([209.51.188.92]:58556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmq-0002jZ-GM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmp-00046j-7s
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:16 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41953
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grUmm-000403-HX
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:12 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  6 Feb 2019 21:30:39 +0000
Message-Id: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/3] qemu-sparc queue 20190206
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc-20190206

for you to fetch changes up to 6031ff8b0ad0feee58cd46ebb0c8d2a6a48d616e:

  sun4m: pass initrd size to OpenBIOS via fw_cfg interface (2019-02-06 21:07:53 +0000)

----------------------------------------------------------------
qemu-sparc queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      sun4m: pass initrd size to OpenBIOS via fw_cfg interface

Prasad J Pandit (1):
      sun4u: add power_mem_read routine

Thomas Huth (1):
      hw/sparc64: Create VGA device only if it has really been requested

 hw/sparc/sun4m.c   | 25 ++++++++++++++-----------
 hw/sparc64/sun4u.c | 16 +++++++++++++++-
 2 files changed, 29 insertions(+), 12 deletions(-)
