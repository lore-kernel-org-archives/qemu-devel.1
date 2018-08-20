Received: from eggs.gnu.org ([2001:4830:134:3::10]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frqA5-0006fv-MS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frqA0-0000AG-SQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:46574
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1frq9w-0008Tn-Oz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 20 Aug 2018 20:47:53 +0100
Message-Id: <20180820194755.30731-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/2] qemu-sparc.for-upstream queue 20180820
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc.for-upstream-20180820

for you to fetch changes up to 8498321421e95a822dc7a5dd3184890766a029bb:

  sun4m: don't use legacy fw_cfg_init_mem() function (2018-08-20 19:18:31 +0100)

----------------------------------------------------------------
qemu-sparc.for-upstream queue

----------------------------------------------------------------
Mark Cave-Ayland (2):
      sun4u: ensure kernel_top is always initialised
      sun4m: don't use legacy fw_cfg_init_mem() function

 hw/sparc/sun4m.c   | 12 +++++++++++-
 hw/sparc64/sun4u.c |  4 ++--
 2 files changed, 13 insertions(+), 3 deletions(-)
