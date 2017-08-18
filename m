Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3p-0006Pn-9z
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dii3m-0006Nf-0Y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57471
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dii3l-0006Az-De
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:37 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 18 Aug 2017 15:15:04 +0100
Message-Id: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/4] net: introduce common net_crc32() and
 net_crc32_le() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com

Whilst trying to debug a CRC32 endian issue for NIC multicast hash lookups, it
struck me that it would make sense to have a common set of standard ethernet
CRC32 functions (both little and big endian variants) in net.c.

The first two patches introduce the relevant functions while the last two patches
switch the pcnet and eepro100 drivers over to use them, allowing us to remove
their private implementations.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (4):
  net: move CRC32 calculation from compute_mcast_idx() into its own
    net_crc32() function
  net: introduce net_crc32_le() function
  pcnet: switch lnc_mchash() over to use net_crc32_le()
  eepro100: switch e100_compute_mcast_idx() over to use net_crc32()

 hw/net/eepro100.c |   19 +------------------
 hw/net/pcnet.c    |   16 +---------------
 include/net/net.h |    5 ++++-
 net/net.c         |   38 +++++++++++++++++++++++++++++++++-----
 4 files changed, 39 insertions(+), 39 deletions(-)

-- 
1.7.10.4
