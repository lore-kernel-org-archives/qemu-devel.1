Received: from eggs.gnu.org ([2001:4830:134:3::10]:35847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crWry-0004lM-3s
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 17:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crWrt-00066H-91
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 17:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:57889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1crWrt-000667-34
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 17:35:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1crWrr-00015O-Ic
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 21:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 430722E80C1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 21:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2017 21:27:00 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <VI1P194MB0144413B3A0BFA00583045C3C83E0@VI1P194MB0144.EURP194.PROD.OUTLOOK.COM>
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

Hi,

now i understand .  xics  have to be build in kernel and is needed by qemu =
2.9 with kvm.
if is not present in the kernel have the issue that i  been reported about =
xics.
I make a test on ubuntu 16.10 and on 17.04. the two distro are ppc 32 and g=
eneric.
i had build the stable kernel 4.10.5 two times with the same config  the  o=
nly parameter that  i had change  was the xics one was yes and the other wa=
s no.

On the two ubuntu version when  i run kernel without xics i had  the issue =
reported. if i run the kernel with xics enabled qemu 2.9 is working and was=
 gave no issue.
but ...
on Fedora server 25 ppc64 if xics is present in the kernel the system (fedo=
ra) not run and freeze after the kernel bootstrap.


Hope all is understandable

Thanks
Luigi

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
