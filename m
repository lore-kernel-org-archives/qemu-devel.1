Received: from eggs.gnu.org ([2001:4830:134:3::10]:39839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGw-0003DA-Fm
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGt-0008IG-OE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:22 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:44515
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dcSGt-0008H4-IQ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:19 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Tue,  1 Aug 2017 10:10:46 +0200
Message-Id: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] mmio-execution and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, alistair.francis@xilinx.com, dgilbert@redhat.com, quintela@redhat.com, frederic.konrad@adacore.com

mmio-execution has incompatibilities with migration so this informs the
potential developer that implementing request_ptr will break migration and
adds a migration blocker in xilinx-spips when using mmio-execution.

This bug affects the user which wants to execute code from SPI (which wasn't
possible before) and uses migration at the same time.

Let's fix that in the next stable release?

Thanks,
Fred

KONRAD Frederic (2):
  mmio-execution: warn the potential developer about migration
  xilinx-spips: add a migration blocker when using mmio_execution

 hw/ssi/xilinx_spips.c | 11 +++++++++++
 include/exec/memory.h |  4 ++++
 2 files changed, 15 insertions(+)

-- 
1.8.3.1
