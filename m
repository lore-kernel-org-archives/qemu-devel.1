Received: from eggs.gnu.org ([2001:4830:134:3::10]:49224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOn-0002Wt-HB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOm-0002FO-Tc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dNKOm-0002C4-M2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:44:44 +0100
Message-Id: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 0/2] risu: Fix handling of ARM sigframe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, patches@linaro.org

This patchset has two patches: the major one fixes bugs in
our code for parsing the VFP parts of the ARM signal frame
structures. These weren't causing a practical problem because
of the way the kernel happens to lay out the sigframe,
but I noticed them while looking at the code for another
reason.

The second is just moving an orphan comment to somewhere
more appropriate.

thanks
-- PMM

Peter Maydell (2):
  risu_reginfo_arm.c: Fix handling of size values in sigframe
  risu_reginfo_arm.c: Move orphan comment to risu.h.

 risu.h             |  5 +++++
 risu_reginfo_arm.c | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.7.4
