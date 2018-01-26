Received: from eggs.gnu.org ([2001:4830:134:3::10]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef4xa-0007nA-Pm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef4xX-0007pR-5P
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:26:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:58987
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ef4xW-0007mx-Vh
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:26:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 26 Jan 2018 09:20:26 +0000
Message-Id: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] ppc: trivial Mac-related trace-events
 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Here is a set of trivial PPC patches which convert grackle and uninorth over
to use trace-events, and also add a missing newline to hw/input/trace-events
which was accidentally omitted when previously converting the ADB devices.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (3):
  grackle: convert to trace-events
  uninorth: convert to trace-events
  input: add missing newline from trace-events

 hw/input/trace-events    |  1 +
 hw/pci-host/grackle.c    | 13 ++-----------
 hw/pci-host/trace-events |  9 +++++++++
 hw/pci-host/uninorth.c   | 24 +++++-------------------
 4 files changed, 17 insertions(+), 30 deletions(-)

-- 
2.11.0
