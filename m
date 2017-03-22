Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqdOH-0000ab-H5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqdOE-0004h5-TZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:48419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqdOE-0004gk-NS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:21:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqdOA-0006dC-Pg
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 10:21:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 49E582E80E1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 10:21:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Mar 2017 10:11:54 -0000
From: Thomas Huth <1674925@bugs.launchpad.net>
Reply-To: Bug 1674925 <1674925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
Message-Id: <20170322101154.25835.93989.malone@gac.canonical.com>
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

Hi! I think unless you use "-vga none" or "-nodefaults", QEMU will always s=
tart your guest with a VGA card by default, so if you add an additional "--=
device virtio-gpu-pci", you'll end up with a guest that has two video cards=
, one VGA and one virtio-gpu.
Also there is a known bug in the SLOF version that has been shipped with QE=
MU 2.8, which causes trouble with virtio-gpu:
http://git.qemu-project.org/?p=3DSLOF.git;a=3Dcommitdiff;h=3D38bf852e73ce6f=
0ac801dfe8ef1545c4cd0b5ddb
Please try again with the latest release candidate of QEMU 2.9, it should b=
e fixed there.
(But please note that SLOF does not contain a driver for virtio-gpu, so you=
 won't see any output from the firmware when starting your guest ... i.e. y=
ou'll just see some output once Linux has been started)

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
