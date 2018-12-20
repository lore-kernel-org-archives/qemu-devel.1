Received: from eggs.gnu.org ([2001:4830:134:3::10]:56939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga35p-0001Aq-TO
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga35m-00045p-OK
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:30:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:33740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ga35m-00044Z-I4
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ga35l-0002AJ-EC
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 18:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5DBD52E80C7
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 18:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2018 18:21:49 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1809291@bugs.launchpad.net>
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <154533010975.25119.17692011472611409037.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809291] Re: ARM PL181 (mmc for Security Digital
 Card) not working in Ubuntu 18.10 (CMD 2,
 3 timeout). The SDC driver worked fine in Ubuntu 18.04 and earlier versions
 but not in Ubuntu 18.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, from this report your setup is unclear to me.
Are you saying that QEMU used to work on Ubuntu 15.10/18.04 and stopped wor=
king on 18.10,
or than current QEMU works with the default Linux kernel from Ubuntu 15.10/=
18.04 and does not work with the 18.10 kernel?
What is the size of your 'sdimage', what is the kernel used in 't.bin'?
Please provide more info.
Thanks,
Phil.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  ARM PL181 (mmc for Security Digital Card) not working in Ubuntu 18.10
  (CMD 2,3 timeout).  The SDC driver worked fine in Ubuntu 18.04 and
  earlier versions but not in Ubuntu 18.10

Status in QEMU:
  New

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions
