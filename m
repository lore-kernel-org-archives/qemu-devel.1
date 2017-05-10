Received: from eggs.gnu.org ([2001:4830:134:3::10]:47980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d8Ybc-0008S0-FQ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d8Yba-00086G-CX
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:53:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57059
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d8Yba-00083t-54
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:53:06 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 10 May 2017 21:52:29 +0100
Message-Id: <1494449551-20227-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] cg3/tcx: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com

Now the previous fixes/cleanups have been applied, it is a fairly trivial
exercise to make cg3/tcx display updates thread safe.

Gerd, do you want to take these patches via your vga queue?

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (2):
  cg3: make display updates thread safe
  tcx: make display updates thread safe

 hw/display/cg3.c |   41 ++++++++++++++++----------------
 hw/display/tcx.c |   68 +++++++++++++++++++-----------------------------------
 2 files changed, 45 insertions(+), 64 deletions(-)

-- 
1.7.10.4
