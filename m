Received: from eggs.gnu.org ([2001:4830:134:3::10]:34041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRkTX-0000PS-83
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRkTT-0008NN-9J
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:57996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gRkTR-0008Fn-D3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gRkTP-0002DL-3H
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 17BC82E80C8
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Nov 2018 20:54:02 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1805445 <1805445@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154332864629.32687.7125797278920412825.malonedeb@wampee.canonical.com>
Message-Id: <154335204222.9786.17626516776701994149.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1805445] Re: QEMU arm virt machine was stopped by
 STMFD command while debug process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You would need to write a model of the hardware you're trying to
emulate. That would require documentation of it and quite a lot of time
(it's about equivalent in effort to writing a Linux port to the
hardware, as a rule of thumb).

I'm not sure what your suggestion about the SPI flash is: I assume that
what we have for the aspeed boards is correct for that hardware.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805445

Title:
  QEMU arm virt machine was stopped by STMFD command while debug process

Status in QEMU:
  New

Bug description:
  Hello, i have a big problem with QEMU arm virtual machine. So...
  I run QEMU machine with bare-metal ThreadX fullflash from Texet TM-333 ph=
one  (Spreadtrum platform)
  [CODE]qemu-system-arm -S -gdb tcp::1234,ipv4 -drive file=3DC:\cygwin64\ho=
me\flash.bin,if=3Dmtd,format=3Draw -M palmetto-bmc -cpu arm926 -m 64M[/CODE]
  I use palmetto-bmc platform because it have ARM926EJ-S core and support S=
PI Flash.
  Then, i attach to gdb qemu process from IDA and run code step-by-step.
  [IMG]https://pp.userapi.com/c847218/v847218546/13ec1c/iSIcre5-js4.jpg[/IM=
G]

  When the IDA run 00032534 STR R11, [R10] command
  [IMG]https://pp.userapi.com/c846416/v846416708/133f60/GQzxORvf4Tg.jpg[/IM=
G]

  instead of store R11 on R10 adress, it jump 000328DC STMFD SP!, {R0-R12,L=
R} instruction...
  [IMG]https://pp.userapi.com/c847218/v847218546/13ec26/32A0VcaJywg.jpg[/IM=
G]
  and virt machine not execute new instruction... =

  [IMG]https://pp.userapi.com/c850624/v850624111/528f3/N7FTpgloWVU.jpg[/IMG]

  and why i did not change flash from n25q256a to n25q032a11 in aspeed.c
  without rebuild qemu?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805445/+subscriptions
