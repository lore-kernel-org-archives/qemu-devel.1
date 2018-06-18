Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEK-0002RE-SB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEI-0004l2-A8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:16 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45018
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUyEI-0004dl-2l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 18 Jun 2018 18:45:35 +0100
Message-Id: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 0/3] qemu-sparc queue 20180618
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc-20180618

for you to fetch changes up to 46bb0137b8266ab8dedc3b9712f3d246bbd686ba:

  SPARC64: add icount support (2018-06-17 11:13:06 +0100)

----------------------------------------------------------------
qemu-sparc queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      SPARC64: add icount support

Thomas Huth (2):
      hw/sparc64/sun4u: Fix introspection by converting prom instance_init to realize
      hw/sparc/sun4m: Fix problems with device introspection

 hw/sparc/sun4m.c         |  67 ++++++++++++++++++++--------
 hw/sparc64/sun4u.c       |  18 +++++---
 target/sparc/translate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 24 deletions(-)
