Received: from eggs.gnu.org ([2001:4830:134:3::10]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctd3I-0004Ck-Ly
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctd3F-0006Of-JL
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:36:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:48394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctd3F-0006OA-D0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:35:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctd3C-0000ik-RY
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54A262E80E7
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 16:29:06 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <20170330162906.823.79504.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1674925] Re: Qemu PPC64 kvm no display if
 --device virtio-gpu-pci is selected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

attched the booted mate 16.10 Qemu system ppc64 --kvm on Qoriq without vide=
o initialized
only way i have to see something is with --serial stdio =


here i post the log of Qemu-system-ppc64 i filed a new bug about
https://bugs.launchpad.net/qemu/+bug/1677247

soon the G5 Quad shots

** Attachment added: "Screenshot_2017-03-29_21-15-08.png"
   https://bugs.launchpad.net/qemu/+bug/1674925/+attachment/4850658/+files/=
Screenshot_2017-03-29_21-15-08.png

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
