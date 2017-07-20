Received: from eggs.gnu.org ([2001:4830:134:3::10]:44300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7Mr-0006AF-6b
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7Mq-0004Kn-F7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:33 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY7Mq-0004KS-8n
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:32 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 11:02:43 +0200
Message-Id: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH v2 0/8] usb-ccid: Misc fixes and T=1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

From: Stefan Fritsch <stefan_fritsch@genua.de>

Sorry, I have accidentally sent an old patchset that was missing one
fix.

This set of changes contains fixes and extensions to allow to use ccid
card passthru with a physical cardos smartcard using the T=1 protocol.

Unfortunately, our vscard client program ist not public, therefore it
is difficult for other people to test the functionality. But maybe you
are still interested to include some bits of it in qemu?


v2: Fix 'usb-ccid: Fix chaining fields in CCID USB messages' not
    compiling.


Stefan Fritsch (8):
  usb-ccid: Add support to dump all USB packets
  usb-ccid: Fix USB packet generation for 64-Bytes sized packets.
  usb-ccid: Set protocol parameters based on card ATR
  usb-ccid: Fix ATR parsing
  usb-ccid: Fix USB descriptor
  usb-ccid: Fix chaining fields in CCID USB messages
  usb-ccid: Increase ccid max APDU size
  usb-ccid: Reduce logging at level WARN

 hw/usb/ccid-card-passthru.c   |  34 +++++++---
 hw/usb/dev-smartcard-reader.c | 148 ++++++++++++++++++++++++++++++++----------
 2 files changed, 138 insertions(+), 44 deletions(-)

-- 
2.11.0
