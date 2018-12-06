Received: from eggs.gnu.org ([2001:4830:134:3::10]:52152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1L-0003M6-FU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1F-0006ax-AY
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1gUx1D-0006XE-8t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:00:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id 96so1235804wrb.2
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:00:52 -0800 (PST)
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Thu,  6 Dec 2018 17:59:04 +0100
Message-Id: <20181206165907.23465-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] Improvements to the netmap backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: g.lettieri@iet.unipi.it, jasowang@redhat.com, Vincenzo Maffione <v.maffione@gmail.com>

Improvements to the netmap backend, mostly to fix the handling of
incomplete multi-slot packets.
This has been tested with and without jumbo frames, using pkt-gen
to send 60, 1500, 5000 or 9000 bytes packets between two VMs connected
through a VALE switch.

Vincenzo Maffione (3):
  net: netmap: small improvements netmap_send()
  net: netmap: simplify netmap_receive()
  net: netmap: improve netmap_receive_iov()

 net/netmap.c | 110 ++++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 63 deletions(-)

-- 
2.19.2
