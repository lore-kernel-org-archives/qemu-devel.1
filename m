Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crSyx-0001zl-CI
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crSyt-0004Kh-CP
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:26:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1crSyt-0004KZ-66
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:26:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1crSyq-0007aw-Ur
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:26:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6D0FD2E80D6
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:26:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2017 17:14:55 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <AM5P194MB0129F8B8B38FDF21BD118CD3C83E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Qemu-ppc] [Bug 1674925] Re: Qemu PPC64 kvm no
 display if --device virtio-gpu-pci is selected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi C=C3=A8dric,

i had been build the kernel with the Xics option enabled and all work on
G5 970MP on Mate 17.04

i will test the same kernel of Fedora server PPC64 and see if there will
work too.

but it is strange thing, because the option was not needed (by the
kernel default)

on PowerMacs and was not need to be enabled on Qemu 2.8.

I suggest to add this in the user faq PowerPC.


I  will test it on Qoriq too if kernel build with this option enabled and i=
f all work ok there too

in case i will report as usual.


I will warn all the PowerPc comunity about if the qemu devs will need to ha=
ve Xics turned on as default in the kernel

Thanks for your support
Luigi

________________________________

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1674925

Title:
  Qemu PPC64 kvm no display if  --device virtio-gpu-pci is selected

Status in QEMU:
  New

Bug description:
  Hi,
  i did many tests on qemu 2.8 on my BE machines and i found an issue that =
i think was need to be reported

  Test Machines BE 970MP

  if i setup qemu with

  qemu-system-ppc64 -M 1024 --display sdl(or gtk),gl=3Don --device virtio-
  gpu-pci,virgl --enable-kvm and so and so

  result is doubled window one is vga other is virtio-gpu-pci without
  any start of the VM . pratically i dont have any output of openbios
  and on the virtual serial output

  the same issue i found is if i select:
  qemu-system-ppc64 -M 1024 --display gtk(or sdl) --device virtio-gpu-pci -=
-enable-kvm and so and so

  =

  i had been try to change all the -M types of all kind of pseries without =
any positive result.

  Ciao =

  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1674925/+subscriptions
