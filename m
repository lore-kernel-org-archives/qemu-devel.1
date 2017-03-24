Received: from eggs.gnu.org ([2001:4830:134:3::10]:49303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crO5j-00042s-Gs
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1crO5e-0004FD-Fv
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:13:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:56365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1crO5e-0004Er-99
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:13:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1crO5a-0007hi-O8
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 12:13:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D494C2E822F
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 12:12:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2017 11:31:03 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <AM5P194MB0129DD9D4ADC6D711725D4D8C83E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
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

first of all thanks for your relpy.


>I have some difficulty sorting out what is going on and what
>could be considered a regression :/ you are reporting many
>issues at the same time with a home made kernel.

>Could you please use the kernel shipped with the distro to
>start with ?

I can do it and report.

> yes usually with 2.8 i  boot  the VM without issue on G5 Quad  with the o=
ption
> -M  pseries from 2.1 to 2.5 with kvm-pr enabled.
> i did the tests and with all pseries now on 2.9 i have the same issue.
> example:
> qemu-system-ppc64 --enable-kvm -cpu 970fx_v2.0 -m 1024 -M pseries-2.1
> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-ker=
nel XICS

>This error message is because your host kernel lacks in-kernel XICS,
>but you are saying that was not an issue with QEMU-2.8. Correct ?

Exactly i have the same on Qoriq too.

>Here is the command line I used on a 17.04 host :
>qemu-system-ppc64 -M pseries-2.[1-8],accel=3Dkvm,kvm-type=3DPR -cpu 970fx_=
v2.0 -m 1024 -nographic

I will try your same command line and see what will exit on me.
I cant use qemu on 17.04 host because there is no more support for PPC32, P=
PC64 dead line is 16.10 and last working version
of qemu on PPC  is 2.6.1  i dint try 2.9 there if needed i can do i have ub=
untu mate 17.04 installed too.

>Did we introduce a regression in compatibility in QEMU 2.9 ?  or
Im facing many issue on this last update im try to help how i can before al=
l come upstream.
i like really much qemu. i can help in testing on PPC64 Be if need with my =
hw.
>was it bogus before ? That needs a little digging. I did not work
>on that part.
dont worry you did much

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
