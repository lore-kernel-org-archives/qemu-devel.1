Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mZ-00063f-T6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mZ-0004nU-6a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:03 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6mY-0004nC-WB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:03 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:25:15 +0200
Message-Id: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH 0/8] usb-ccid: Misc fixes and T=1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>

From: Stefan Fritsch <stefan_fritsch@genua.de>

This set of changes contains fixes and extensions to allow to use ccid
card passthru with a physical smartcard using the T=1 protocol.

Unfortunately, our vscard client program ist not public, therefore it
is difficult for other people to test the functionality. But maybe you
are still interested to include some bits of it in qemu?

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
