Received: from eggs.gnu.org ([2001:4830:134:3::10]:51937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTV-0002ET-MD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTS-0004jA-OO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZqTS-0004ij-Hj
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZqTR-0001LF-Ft
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 04:30:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 775352E819E
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 04:30:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1312668@bugs.launchpad.net>
Reply-To: Bug 1312668 <1312668@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140425111153.4225.71587.malonedeb@soybean.canonical.com>
Message-Id: <153050504836.6988.5934331028689445603.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1312668] Re: x86 cpu nx feature: guest reboots
 after migrate exec
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
https://bugs.launchpad.net/bugs/1312668

Title:
  x86 cpu nx feature: guest reboots  after migrate exec

Status in QEMU:
  Expired

Bug description:
  Using instruction on =

  http://www.linux-kvm.org/page/Migration
  I save VM state to external file and try load it, but VM starts, shows sa=
ved screen and reboots immediatly.

  Cmdline for vm state saving:

  $ sudo ./i386-softmmu/qemu-system-i386 -machine accel=3Dkvm,kernel_irqchi=
p=3Don -enable-kvm  -m 512 -hda image.raw -vga std -net none  -M pc -monito=
r stdio -cpu SandyBridge =

  (or  -cpu "n270" , or "kvm32,+sse2,+pae,+nx")

  Monitor cmd:
  (qemu) stop
  (qemu) migrate_set_speed 4095m
  (qemu) migrate "exec:gzip -c > STATEFILE.gz"  =

  (qemu) q

  Cmdline for vm state loading:

  $ sudo ./i386-softmmu/qemu-system-i386 -machine accel=3Dkvm,kernel_irqchi=
p=3Don -enable-kvm  -m 512 -hda image.raw -vga std -net none  -M pc -monito=
r stdio -cpu SandyBridge -incoming "exec: gzip -c -d STATEFILE.gz"
  (or  -cpu "n270" , or "kvm32,+sse2,+pae,+nx")

  If I do the same without NX cpu feature (-cpu option "n270,-nx" /
  "SandyBridge,-nx" / "kvm32,+pae,+sse2") or on qemu-system-x86_64, VM
  save/load works correctly.

  Log kvm-all.c, DEBUG_KVM=3Dy:

  QEMU 2.0.0 monitor - type 'help' for more information
  (qemu) kvm_init_vcpu
  ...handle_io.../...handle_mmio...
  kvm_cpu_exec()
  shutdown
  kvm_cpu_exec()
  interrupt exit requested
  io window exit
  kvm_cpu_exec()

  Host:

   $ lsb_release -rd
   Description:	Ubuntu 12.04.4 LTS
   Release:	12.04

   $ uname -a
   Linux <username> 3.8.0-38-generic #56~precise1 SMP Tue Apr 22 12:46:44 M=
SK 2014 x86_64 x86_64 x86_64 GNU/Linux

  Guest:
   1. Ubuntu 12.04 32bit =

   2. WIndows 8 32bit

  Qemu: v2.0.0
  commit a9e8aeb3755bccb7b51174adcf4a3fc427e0d147
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Thu Apr 17 13:41:45 2014 +0100

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1312668/+subscriptions
