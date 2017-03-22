Received: from eggs.gnu.org ([2001:4830:134:3::10]:55730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqkU4-0006Bo-4g
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqkU1-0004We-05
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:55:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:40522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqkU0-0004WD-Pm
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqkTz-0007vh-Jk
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F2CE2E80C1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Mar 2017 17:49:59 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <AM5P194MB01291ABD7713F7A68E517AB6C83C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
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

Hi C=C3=A9dric,

i have the 4.11 rc1 . on fedora 25 ppc 64 on both machine Qoriq and on
G5 Quad.

On the 2.8 this issue isnt present but
I did the test o Qoriq  e5500 a book3e processor and on 2.8 if i made:

qemu-system-ppc64 --enable-kvm the true result is:
qemu-system-ppc64: Unable to find CPU definition: host

on qemu 2.9 rc1

./qemu-system-ppc64 --enable-kvm i have :
qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kerne=
l XICS

On Qoriq if i pass the -cpu e500 (normal thing) all is working right
qemu 2.9rc1 all boot and so and so.

On G5 the -cpu variable dont fix the issue.

I can build a new kernel release , usually mine dont have xics enabled
because G5 dont have that feature, if needed i can enable it for
testing.


Hope my english is understandable.

ciao

Luigi

________________________________
Da: Qemu-ppc <qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org> per c=
onto di C=C3=A9dric Le Goater <clg@kaod.org>
Inviato: mercoled=C3=AC 22 marzo 2017 18.29
A: Thomas Huth; Bug 1674925; qemu-devel@nongnu.org
Cc: qemU-ppc@nongnu.org
Oggetto: Re: [Qemu-ppc] [Qemu-devel] [Bug 1674925] Re: Qemu PPC64 kvm no di=
splay if --device virtio-gpu-pci is selected

On 03/22/2017 03:15 PM, Thomas Huth wrote:
> On 22.03.2017 14:35, luigiburdo wrote:
>> Hi Thomas with 2.9 rc1 i have this with --enable-kvm
>>
>> emu-system-ppc64 --enable-kvm
>> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-ke=
rnel XICS
>>
>> and the qemu dont run.
>
> Does it exit, or just hang afterwards? Was this with or without --device
> virtio-gpu-pci option? Do you get any output if you run QEMU with
> "-nographic" instead?

I guess this is an issue with the host kernel. Which one are you running
?

C.

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
