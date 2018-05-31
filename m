Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fOE7R-0006NV-OE
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fOE7Q-0005W4-NR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:19:17 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:43856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <akalita@cs.stonybrook.edu>)
	id 1fOE7Q-0005VV-Ck
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:19:16 -0400
Received: by mail-lf0-x22a.google.com with SMTP id n18-v6so7452859lfh.10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 20:19:15 -0700 (PDT)
MIME-Version: 1.0
From: Arnabjyoti Kalita <akalita@cs.stonybrook.edu>
Date: Wed, 30 May 2018 23:19:13 -0400
Message-ID: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all,

I am trying to implement a 'minimal' record-replay mechanism for KVM, which
is similar to the one existing for TCG via -icount. I am trying to record
I/O events only (specifically disk and network events) when KVM does a
VMEXIT. This has led me to the function kvm_cpu_exec where I can clearly
see the different ways of handling all of the possible VMExit cases (like
PIO, MMIO etc.). To record network packets, I am working with the e1000
hardware device.

Can I make sure that all of the network I/O, atleast for the e1000 device
happens through the KVM_EXIT_MMIO case and subsequent use of the
address_space_rw() function ? Do I also need to look at other functions as
well ? Also for recording disk activity, can I make sure that looking out
for the KVM_EXIT_MMIO and/or KVM_EXIT_PIO cases in the vmexit mechanism,
will be enough ?

Let me know if there are other details that I need to take care of. I am
using QEMU 2.11 on a x86-64 CPU and the guest runs a Linux Kernel 4.4 with
Ubuntu 16.04.

Thanks and Regards,
Arnab
