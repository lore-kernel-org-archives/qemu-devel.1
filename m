Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqhHu-0005Uj-Q8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqhHq-00049U-PW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:50619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqhHq-00049J-GM
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqhHo-0008BS-H3
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 14:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 40F052E80E4
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 14:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Mar 2017 14:25:25 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <AM5P194MB01290E67C56B92F2BE0C4411C83C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
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

Hi Thomas,

just exit like it is an error with a wrong option.
the output is only this   qemu-system-ppc64: KVM and IRQ_XICS capability mu=
st be present for in-kernel XICS
Same is if i add all the options i have the seme error.
look like qemu need for run in kvm  a  kernel with XICS option enabled and =
XICS  is present only from ibm power 5 to up if i remember good.
After work i can test it if needed on Qoriq e5500 too for check if there is=
 the same issue on an emb ppc64 processor.

Ciao
Luigi


On 22.03.2017 14:35, luigiburdo wrote:
> Hi Thomas with 2.9 rc1 i have this with --enable-kvm
>
> emu-system-ppc64 --enable-kvm
> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-ker=
nel XICS
>
> and the qemu dont run.

Does it exit, or just hang afterwards? Was this with or without --device
virtio-gpu-pci option? Do you get any output if you run QEMU with
"-nographic" instead?

 Thomas

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
