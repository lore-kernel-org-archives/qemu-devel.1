Received: from eggs.gnu.org ([2001:4830:134:3::10]:55078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsic-0004lp-D4
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsib-00063F-FW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:38:38 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:22:36 +0100
Message-ID: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 0/3] MultiCPU changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

Those are changes that I made to create SoC model with 2xCortexA9
and Cortex-M3. Generally all are done to allow move work further,
not to upstreaming (especially patch 3). I would like to start
discossion if those modification could be upstreamed.

Marcin Krzeminski (3):
  nvic: Add CPU numebr property
  ARM: boot: Add option to skip FDT memory node update
  exec: Allow to change Address Space from board level

 exec.c                |  8 ++++++++
 hw/arm/boot.c         | 29 ++++++++++++++++-------------
 hw/intc/armv7m_nvic.c | 24 ++++++++++++++++++------
 include/hw/arm/arm.h  |  5 +++++
 include/qom/cpu.h     |  1 +
 5 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.7.4
