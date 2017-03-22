Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqloY-0007rf-Pb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqloT-0007Up-T3
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:20:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:40828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqloT-0007Uf-Fm
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:20:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqloP-0005A0-MT
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 19:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E7EE2E819A
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 19:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Mar 2017 19:15:29 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <AM5P194MB01297823A835C4F56CE786AAC83C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
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

Hello C=C3=A9dric,

with your last message you made me think about and make more test.

>The default machine for qemu-system-ppc64 is pseries.
yes usually with 2.8 i  boot  the VM without issue on G5 Quad  with the opt=
ion  -M  pseries from 2.1 to 2.5 with kvm-pr enabled.
i did the tests and with all pseries now on 2.9 i have the same issue.
example:
qemu-system-ppc64 --enable-kvm -cpu 970fx_v2.0 -m 1024 -M pseries-2.1
qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kerne=
l XICS

but no issue if i run with -M mac99 before 2.9 was not possible use it on q=
emu-system-ppc64
It means it will no possible anymore in future release of qemu use open fir=
mware on powermacs any moore?


>I admit the message is not very clear, but the host kernel is
>using a dev config.

Im so sorry, i learn English by my self reading ml and on irc chatting
is too difficult where no one speak English  around.

>> On Qoriq if i pass the -cpu e500 (normal thing) all is working right qem=
u 2.9rc1
>> all boot and so and so.
>but you must be changing the machine right ?
not on Qoriq because it is book3e and is not so flexible like the G5 Quad w=
ho is book3s machine.
i can run qemu kvm only with emb hardware on Qoriq

>>On G5 the -cpu variable dont fix the issue.
>with which machine ?
On PowerMac G5 Quad 970MP it have similar hardware configuration of IBM int=
ellistation power 285

> >I can build a new kernel release , usually mine dont have xics enabled b=
ecause G5
>> dont have that feature, if needed i can enable it for testing.**
>Yes that would be interesting.

I will do ASAP just the time to build it .

Thank you really much for your time and patience.
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
