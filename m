Received: from eggs.gnu.org ([2001:4830:134:3::10]:53995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fHF6l-00026O-Pa
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fHF6i-00052v-OY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:57:43 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:56045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cyrus296@gmail.com>) id 1fHF6i-00052m-Ib
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:57:40 -0400
Received: by mail-it0-x241.google.com with SMTP id 144-v6so3556096iti.5
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 13:57:40 -0700 (PDT)
From: Calvin Lee <cyrus296@gmail.com>
Date: Fri, 11 May 2018 14:57:22 -0600
Message-Id: <20180511205724.4039-1-cyrus296@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] Fix UART serial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, Calvin Lee <cyrus296@gmail.com>

Hello,

While developing a serial implementation for my OS, I found several bugs
in QEMU's serial device. I confirmed (by testing on my x64 laptop) that
there are several inconsistancies between QEMU and hardware in this
regard. For both patches, I used "http://www.sci.muni.cz/docs/pc/serport.txt"
for reference.

First, QEMU has several errors for setting the UART divisor that are
fixed in my first patch. Second, (and more importantly) QEMU does not
transmit serial bytes at the correct rate, and this is fixed in my
second patch.

I have neither contributed to QEMU nor sent patches to a mailing list
before, so I marked this patch-series as RFC. I would appreciate any
comments you have. Also, I am not very confident in VM migration between
versions, so I would appreciate if someone could help me make sure this
is correct in my patches.

Much thanks,
Calvin Lee

Calvin Lee (2):
  PC Chipset: Improve serial divisor calculation
  PC Chipset: Send serial bytes at correct rate

 hw/char/serial.c         | 70 +++++++++++++++++++++++++++++++---------
 include/hw/char/serial.h |  2 ++
 2 files changed, 56 insertions(+), 16 deletions(-)

-- 
2.17.0
