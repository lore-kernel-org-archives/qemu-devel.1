Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVxHg-0006tl-T6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVxHe-00043C-6x
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:21:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVxHe-00042v-2E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:20:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVxHb-0000Ng-IR
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:20:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B409A2E80D4
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:20:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jan 2017 09:09:08 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
Message-Id: <20170124090908.2186.15499.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658634] Re: Can't get correct display with
 latest QEMU and OVMF BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For reference, this is my script:

ISO=3Dubuntu-16.04.1-desktop-amd64.iso
CODE=3DOVMF_CODE.fd
TMPL=3DOVMF_VARS.fd

cp $TMPL vars.fd

qemu-system-x86_64 \
  -m 1024 \
  -M pc,accel=3Dkvm \
  -device VGA \
  -drive if=3Dpflash,readonly,format=3Draw,file=3D$CODE \
  -drive if=3Dpflash,format=3Draw,file=3Dvars.fd \
  -drive id=3Dcdrom,if=3Dnone,readonly,format=3Draw,file=3D$ISO \
  -device virtio-scsi-pci,id=3Dscsi0 \
  -device scsi-cd,bus=3Dscsi0.0,drive=3Dcdrom,bootindex=3D0 \
  -debugcon file:debug.log \
  -global isa-debugcon.iobase=3D0x402 \
  -chardev stdio,signal=3Doff,mux=3Don,id=3Dchar0 \
  -mon chardev=3Dchar0,mode=3Dreadline,default \
  -serial chardev:char0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  Confirmed

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
