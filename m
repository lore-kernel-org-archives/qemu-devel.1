Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFviY-0006Me-Fj
	for qemu-devel@nongnu.org; Sat, 18 Nov 2017 00:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFviT-0003Wj-I6
	for qemu-devel@nongnu.org; Sat, 18 Nov 2017 00:31:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:37348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFviT-0003Uf-BE
	for qemu-devel@nongnu.org; Sat, 18 Nov 2017 00:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFviR-0005Jh-KD
	for <qemu-devel@nongnu.org>; Sat, 18 Nov 2017 05:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 973AF2E80CD
	for <qemu-devel@nongnu.org>; Sat, 18 Nov 2017 05:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Nov 2017 05:21:08 -0000
From: Andrew Baumann <launchpad.net@ab.id.au>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Message-Id: <151098246822.1317.436831196418823156.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1717708] Re: QEMU aarch64 can't run Windows ARM64
 iso's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I just noticed this bug via qemu-devel. For the record, recent QEMU
(2.11-rc1 and later) can run recent arm64 Windows images using -M virt
and the virtio storage/input/networking drivers in the guest. I was
using older UEFI build that still includes the VGA framebuffer support.
(I only just learned via this bug that it had been removed, but as
PeterM pointed out this isn't the right place to discuss it.)

Here's a sample invocation:
qemu-system-aarch64 -M virt -cpu cortex-a57 -m 4G -smp 4 -bios QEMU_EFI-arm=
64.fd \
  -serial stdio -device VGA -device virtio-keyboard-pci -device virtio-mous=
e-pci \
  -netdev user,id=3Dnet0 -device virtio-net-pci,disable-legacy=3Don,netdev=
=3Dnet0,mac=3D00:11:22:33:44:55,addr=3D08 \
  -drive if=3Dnone,file=3Dmyimage.vhdx,id=3Dhd0 -device virtio-blk-pci,driv=
e=3Dhd0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717708

Title:
  QEMU aarch64 can't run Windows ARM64 iso's

Status in QEMU:
  New

Bug description:
  Hi,
  recently Windows ARM64 ISOs have been posted on the internet..
  just checked with latest QEMU 2.10 release from =

  https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe =

  "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom h:\iso\16353.1000.170825=
-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-ES.ISO -m 2048 -cpu cortex=
-a57 -smp 1 -machine virt
  seems no video output..
  checked various machine options for example versatilepb (says guest has n=
ot initialized the guest)..

  so don't know if it's a QEMU bug or lacking feature but can support
  running Windows ARM64 builds (would be nice if you can add a
  Snapdragon835 machine type which is which first machines will be
  running..)

  =

  note running a Windows x64 ISO with similar parameters works (removing -c=
pu and -machine as not needed)

  thanks..

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717708/+subscriptions
