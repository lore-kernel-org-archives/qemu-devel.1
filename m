Received: from eggs.gnu.org ([2001:4830:134:3::10]:59840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUXiW-0003qk-K9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUXiS-0005ma-MQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:50:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUXiS-0005lb-BT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:50:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUXiQ-0000ZB-1g
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:50:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55DA22E80D6
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 11:39:31 -0000
From: Thomas Huth <1657538@bugs.launchpad.net>
Reply-To: Bug 1657538 <1657538@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170118175149.27340.89188.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170120113931.21568.95702.malone@gac.canonical.com>
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

I can not reproduce this issue. QEMU 2.8 works fine here on a POWER8 big
endian host (running RHEL7). Can you still run older versions of QEMU
that used to work for you in the past, to check whether it is QEMU or
whether it is Ubuntu 16.10 that is causing the trouble here? Could you
please also post the full output of the "configure" run on your system?

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
