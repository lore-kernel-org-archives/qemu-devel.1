Received: from eggs.gnu.org ([2001:4830:134:3::10]:42783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTucC-0002iO-Fh
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTuc7-0003eD-4D
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:05:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:41884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTuc6-0003dy-TV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:05:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTuc4-0000oB-IY
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 18:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 87B022E80CA
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 18:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jan 2017 17:51:49 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1657538 <1657538@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170118175149.27340.89188.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657538] [NEW] qemu 2.7.x 2.8 softmmu dont work
 on BE machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Build on Be machine qemu 2.7.1 and 2.8 in pure softmmu (tgc) dont work on b=
ig endian hardware .
tested with ppc-softmmu,i386-softmmu,arm-softmmu same result:

with :
 ./qemu-system-i386 =

Gtk-Message: Failed to load module "overlay-scrollbar"
qemu-system-i386: Trying to execute code outside RAM or ROM at 0x000a0000
This usually means one of the following happened:

(1) You told QEMU to execute a kernel for the wrong machine type, and it cr=
ashed on startup (eg trying to run a raspberry pi kernel on a versatilepb Q=
EMU machine)
(2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU execute=
d a ROM full of no-op instructions until it fell off the end
(3) Your guest kernel has a bug and crashed by jumping off into nowhere

This is almost always one of the first two, so check your command line and =
that you are using the right type of kernel for this machine.
If you think option (3) is likely then you can try debugging your guest wit=
h the -d debug options; in particular -d guest_errors will cause the log to=
 include a dump of the guest register state at this point.

Execution cannot continue; stopping here.


I try to add the -L option with ../pc-bios/bios.bin =

and have the same result.

note the ppc-softmmu and ppc64-softmmu work in kvm mode only emulated
mode have issue.


tested on my hardware a  Qriq P5040 and G5 4x970MP with Ubuntu Mate 16.10 =

thanks
Luigi

** Affects: qemu
     Importance: Undecided
         Status: New

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
