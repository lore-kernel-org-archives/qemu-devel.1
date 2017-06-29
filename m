Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlQ-0002Ab-9C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlM-0001XM-CW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:28 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43357
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQVlM-0001Wn-6X
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:24 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 29 Jun 2017 11:28:50 +0200
Message-Id: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 0/3] Some armv7m fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com, alistair@alistair23.me, frederic.konrad@adacore.com

Hi,

While playing with armv7m, I found two little bugs:
  - When there is an alias @0x00000000 to a flash memory the cpu state isn't
    reset correctly which leads later to an exception as ARM instruction-set is
    used. Presumably this bug might be present with the netduino2 board.
  - If the developer omits to set system_clock_rate we later go in a livelock
    when systick is triggered. Better aborting before to avoid the pain chasing
    the livelock.

Thanks,
Fred

KONRAD Frederic (3):
  add memory_region_get_offset_within_address_space
  arm: fix the armv7m reset state
  armv7m_systick: abort instead of locking on a bad rate

 hw/timer/armv7m_systick.c |  3 +++
 include/exec/memory.h     | 10 ++++++++++
 memory.c                  | 22 ++++++++++++++++++++--
 target/arm/cpu.c          | 14 ++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

-- 
1.8.3.1
