Received: from eggs.gnu.org ([2001:4830:134:3::10]:58559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHOB-0003wD-K9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHO6-0008VB-JA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:11 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:50321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHO6-0008UU-Ei
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:06 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Mon, 13 Nov 2017 11:14:44 -0500
Message-ID: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/3] Add 8-byte wide AMD flash support,
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
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

This patch set does a few things. First, it switches the AMD CFI flash MMIO
operations from the old MMIO API to the new one. Second, it enables 8-byte wide
flash arrays. Finally, it adds flash interleaving using the "device-width" and
"max-device-width" properties, using the same interface as pflash_cfi01.c. Much
of the code was taken and adapted from that file.

Version 3 of the patch splits the patch set into distinct patches based on the
modified functionality.

Mike Nawrocki (3):
  Switch AMD CFI flash to use new MMIO API
  Enable 8-byte wide access to AMD CFI devices
  Add partial flash interleaving to AMD CFI devices

 hw/block/pflash_cfi02.c | 478 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 326 insertions(+), 152 deletions(-)

-- 
2.14.2
