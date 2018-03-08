Received: from eggs.gnu.org ([2001:4830:134:3::10]:58852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etqH5-0004we-4E
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etqH0-0006ok-91
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:47:39 -0500
Received: from chuckie.co.uk ([82.165.15.123]:46663
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1etqH0-0006m8-23
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:47:34 -0500
Date: Thu, 8 Mar 2018 07:47:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180308074714.flmzofjhz4p45ljr@kentang.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Peter,

Here are a couple of last-minute fixes for SPARC. Please pull.


ATB,

Mark.


The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:

  misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 6e10f37c86068e35151f982c976a85f1bec07ef2:

  sparc: fix leon3 casa instruction when MMU is disabled (2018-03-08 07:22:03 +0000)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
KONRAD Frederic (1):
      sparc: fix leon3 casa instruction when MMU is disabled

Thomas Huth (1):
      hw/sparc/sun4m: Fix implicit creation of "-drive if=scsi" devices

 hw/sparc/sun4m.c         | 1 +
 target/sparc/translate.c | 5 +++++
 2 files changed, 6 insertions(+)
