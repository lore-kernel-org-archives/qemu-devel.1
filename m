Received: from eggs.gnu.org ([2001:4830:134:3::10]:58199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eqkjl-0003nE-9a
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eqkjf-0003Nh-PD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:16:29 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56624
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eqkjf-0003Lr-IQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:16:23 -0500
Date: Tue, 27 Feb 2018 19:16:13 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20180227191613.bgnl27q237j7quoz@kentang.home>
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

Here is a pull request containing the loader fix which enables qemu-system-sparc to work when
used with -kernel again.


ATB,

Mark.


The following changes since commit 3ec7b5d819da9245dd37a6f7e7d150f064cf584c:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180227-pull-request' into staging (2018-02-27 14:01:19 +0000)

are available in the git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to ca316c11526a1bc221fb542bdce6bac7238dde69:

  loader: don't perform overlapping address check for memory region ROM images (2018-02-27 18:57:14 +0000)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (1):
      loader: don't perform overlapping address check for memory region ROM images

 hw/core/loader.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
