Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1d9JPq-0005Wz-Fa
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1d9JPp-0000qX-OQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:52:06 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:35472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viniciusfre@gmail.com>)
	id 1d9JPp-0000p6-KF
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:52:05 -0400
Received: by mail-ua0-x22a.google.com with SMTP id e55so54734141uaa.2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:52:03 -0700 (PDT)
MIME-Version: 1.0
From: Vinicius Maciel <viniciusfre@gmail.com>
Date: Fri, 12 May 2017 19:52:02 -0300
Message-ID: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel]  MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I'm trying to emulate a MIPS 74Kc using a custom machine in order to run a
CFE bootloader from broadcom. The CPU is Broadcom BCM5357. The problem
happens when Qemu calculates physaddr inside io_readx(), cputlb.c:line 784

physaddr = (physaddr & TARGET_PAGE_MASK) + addr;

After run this line the the value is 0x18000000, which is clearly wrong.
More informations:

BUG function: io_readx
Assembly instruction: lw t1,0(a2)
Machine code: 0x8cc90000 (Little endian)
Access address: 0xb8000000

Assembly code:
80702f30 <board_earlyinit>:
80702f30: 3c06b800 lui a2,0xb800
80702f34: 24075350 li a3,21328
80702f38: 8cc90000 lw t1,0(a2) <----

Thanks,
Vinicius
