Received: from eggs.gnu.org ([2001:4830:134:3::10]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wI-0001rS-GA
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wE-0003g0-KP
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56765
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d55wE-0003fn-DH
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:06 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 08:39:33 +0100
Message-Id: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] tcx/cg3: fix warnings reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

This patchset fixes up a couple of issues from my last set of tcx/cg3 updates
spotted by Coverity as reported by Peter.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (2):
  tcx: fix cut/paste error in update_palette_entries()
  cg3: add explicit ram_addr_t cast to scanline page variable

 hw/display/cg3.c |    2 +-
 hw/display/tcx.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
1.7.10.4
