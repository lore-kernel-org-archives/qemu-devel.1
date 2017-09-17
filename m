Received: from eggs.gnu.org ([2001:4830:134:3::10]:35217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtaMb-0002u9-Ly
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 10:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtaMW-0000T6-HR
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 10:16:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:53020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dtaMW-0000S7-Ae
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 10:15:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dtaMU-0002E7-5K
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 14:15:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 261EC2E8489
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 14:15:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Sep 2017 14:10:22 -0000
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Message-Id: <150565742305.24740.16869960124083764240.malone@chaenomeles.canonical.com>
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

"D:\Program Files\qemu\qemu-system-aarch64.exe" -device virtio-scsi-
pci,id=3Dscsi -drive if=3Dnone,id=3Dcd,file=3D\path\to\iso -device scsi-
cd,drive=3Dcd,bootindex=3D0 -m 2048 -cpu cortex-a57 -smp 4 -machine virt
-device virtio-gpu-pci -bios "QEMU_EFI .fd" -device usb-ehci -device
usb-kbd -device usb-mouse -usb

The QEMU_EFI .fd is downloaded from https://releases.linaro.org
/reference-platform/enterprise/17.08/uefi/release/qemu64/QEMU_EFI.fd

While I've tried the 16353.1000.170825-1423
.RS_PRERELEASE_CLIENTENTERPRISE_VOL_ARM64FRE_ES-ES.ISO, bios could find
the EFI/BOOT/BOOTAA64.EFI file, but the installer doesn't boot up.

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
