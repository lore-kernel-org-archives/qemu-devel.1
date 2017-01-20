Received: from eggs.gnu.org ([2001:4830:134:3::10]:35607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUbcb-0008QO-4b
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUbcV-0002vb-IR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:01:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:56274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUbcV-0002vT-C0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUbcU-0002qe-5i
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 13C702E80CA
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 15:53:19 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1657538 <1657538@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170118175149.27340.89188.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170120155319.26958.25572.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657538] Re: qemu 2.7.x 2.8 softmmu dont work on
 BE machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

i386-softmmu:
./qemu-system-i386 -nographic
qemu-system-i386: Trying to execute code outside RAM or ROM at 0x000a0000
This usually means one of the following happened: and so and so =


./qemu-system-ppc -nographic =

nothing happen ... no exit on console .


on 2.6.2 i have:

qemu-system-ppc -nographic

>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> OpenBIOS 1.1 [Apr 18 2016 08:20]
>> Configuration device id QEMU version 1 machine id 2
>> CPUs: 1
>> Memory: 128M
>> UUID: 00000000-0000-0000-0000-000000000000
>> CPU type PowerPC,750
milliseconds isn't unique.
Welcome to OpenBIOS v1.1 built on Apr 18 2016 08:20
Trying hd:,\\:tbxi...
Trying hd:,\ppc\bootinfo.txt...
Trying hd:,%BOOT...


note the 2.6.2 work, before on 2.6.1 i had the same issue of 2.7 and 2.8

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657538

Title:
  qemu 2.7.x 2.8 softmmu dont work on BE machine

Status in QEMU:
  New

Bug description:
  Build on Be machine qemu 2.7.1 and 2.8 in pure softmmu (tgc) dont work on=
 big endian hardware .
  tested with ppc-softmmu,i386-softmmu,arm-softmmu same result:

  with :
   ./qemu-system-i386 =

  Gtk-Message: Failed to load module "overlay-scrollbar"
  qemu-system-i386: Trying to execute code outside RAM or ROM at 0x000a0000
  This usually means one of the following happened:

  (1) You told QEMU to execute a kernel for the wrong machine type, and it =
crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb=
 QEMU machine)
  (2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU execu=
ted a ROM full of no-op instructions until it fell off the end
  (3) Your guest kernel has a bug and crashed by jumping off into nowhere

  This is almost always one of the first two, so check your command line an=
d that you are using the right type of kernel for this machine.
  If you think option (3) is likely then you can try debugging your guest w=
ith the -d debug options; in particular -d guest_errors will cause the log =
to include a dump of the guest register state at this point.

  Execution cannot continue; stopping here.

  =

  I try to add the -L option with ../pc-bios/bios.bin =

  and have the same result.

  note the ppc-softmmu and ppc64-softmmu work in kvm mode only emulated
  mode have issue.

  =

  tested on my hardware a  Qriq P5040 and G5 4x970MP with Ubuntu Mate 16.10 =

  thanks
  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657538/+subscriptions
