Received: from eggs.gnu.org ([2001:4830:134:3::10]:53771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsn-0007HN-OQ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsm-0002Uc-6o
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:33 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsm-0002Tl-2p
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:32 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Fri, 10 Nov 2017 15:25:55 -0500
Message-ID: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/1] Add 8-byte wide AMD flash support,
 partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

This patch set does a few things. First, it switches the AMD CFI flash MMIO
operations from the old MMIO API to the new one. Second, it enables 8-byte wide
flash arrays. Finally, it adds flash interleaving using the "device-width" and
"max-device-width" properties, using the same interface as pflash_cfi01.c. Much
of the code was taken and adapted from that file.

Version 1 of the patch set changed the flash register function (and all
usages), version 2 localizes changes to the pflash_cfi02.c file.

Mike Nawrocki (1):
  Add 8-byte access, interleaving to AMD CFI devices

 hw/block/pflash_cfi02.c | 491 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 337 insertions(+), 154 deletions(-)

-- 
2.14.2
