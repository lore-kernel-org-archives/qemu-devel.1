Received: from eggs.gnu.org ([2001:4830:134:3::10]:48962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmYfx-0007un-0g
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmYft-0000Bz-V1
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:39646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmYft-0000Ad-O0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmYfp-0001BM-SA
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 04:30:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42CB72E80DC
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 04:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Mar 2017 04:17:20 -0000
From: Launchpad Bug Tracker <526653@bugs.launchpad.net>
Reply-To: Bug 526653 <526653@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100223201642.21324.1038.malonedeb@soybean.canonical.com>
Message-Id: <20170311041720.7718.59266.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 526653] Re: Breakpoint on Memory address fails
 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/526653

Title:
  Breakpoint on Memory address fails with KVM

Status in QEMU:
  Expired

Bug description:
  Using QEMU version 0.12.50 under ubuntu Karmic x64

  To reproduce the error using a floppy with a bootloder:
  qemu-system-x86_64 -s -S -fda floppy.img -boot a -enable-kvm

  connect with gdb:
  (gdb) set arch i8086
  The target architecture is assumed to be i8086
  (gdb) target remote localhost:1234
  Remote debugging using localhost:1234
  0x0000fff0 in ?? ()
  (gdb) break *0x7c00
  Breakpoint 1 at 0x7c00
  (gdb) continue
  Continuing.

  The breakpoint is not hit.

  If you close qemu and start it without kvm support:

  qemu-system-x86_64 -s -S -fda floppy.img -boot a

  (gdb) set arch i8086
  The target architecture is assumed to be i8086
  (gdb) target remote localhost:1234
  Remote debugging using localhost:1234
  0x0000fff0 in ?? ()
  (gdb) break *0x7c00
  Breakpoint 1 at 0x7c00
  (gdb) continue
  Continuing.

  Breakpoint 1, 0x00007c00 in ?? ()
  (gdb) =


  The breakpoint is hit.  If you wait until after the bootloader has
  been loaded into memory, you can properly set breakpoints with or
  without kvm enabled.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/526653/+subscriptions
