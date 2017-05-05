Received: from eggs.gnu.org ([2001:4830:134:3::10]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Z3k-00023T-NM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Z3h-0003eX-Lc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:57:56 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42914
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d6Z3h-0003e1-DM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:57:53 -0400
Date: Fri, 5 May 2017 09:57:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170505085724.GB7278@kentang.lan>
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
To: stefanha@gmail.com, qemu-devel@nongnu.org

Hi Stefan,

This pull request contains just the fixes for the Coverity warnings spotted by Peter from
the last set of cg3/tcx patches. Please pull.


ATB,

Mark.


The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into staging (2017-05-02 15:16:29 +0100)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-sparc-signed

for you to fetch changes up to 8eb57ae3f9afdd8d911f3b2862e05cd0bb042b4e:

  cg3: add explicit ram_addr_t cast to scanline page variable (2017-05-05 09:49:00 +0100)

----------------------------------------------------------------
qemu-sparc update

----------------------------------------------------------------
Mark Cave-Ayland (2):
      tcx: fix cut/paste error in update_palette_entries()
      cg3: add explicit ram_addr_t cast to scanline page variable

 hw/display/cg3.c |    2 +-
 hw/display/tcx.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
