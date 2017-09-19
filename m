Received: from eggs.gnu.org ([2001:4830:134:3::10]:46162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHzQ-0004l6-32
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duHzL-0003a7-3y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:51:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:56210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duHzK-0003ZF-Kq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duHzI-0002JW-88
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:50:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DDA742E84B8
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 12:38:15 -0000
From: Gerd Hoffmann <1715700@bugs.launchpad.net>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
	<150582231000.13645.13271569408662777261.malone@gac.canonical.com>
Message-Id: <1505824695.12708.7.camel@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on
 qemu 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> (2) Build the SeaBIOS CSM (CONFIG_CSM=3Dy), and embed it into OVMF,
> like described above. Then, boot Windows 7 in *UEFI Mode*.

> Option #1 and option #2 no longer work because the CSM infrastructure
> in edk2 needs to be able to write 0xc0000.

Well, option #2 works for me.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715700

Title:
  Windows 7 guest won't boot on qemu 2.10 (works on 2.9)

Status in QEMU:
  New

Bug description:
  Qemu version: 2.10 stable.
  Guest: Windows 7 SP1 x64, virtio drivers are already installed in the gue=
st.
  Command line:
  qemu-system-x86_64 \
      -nodefaults \
      -nodefconfig \
      -machine type=3Dq35,accel=3Dkvm \
      -enable-kvm \
      -cpu host \
      -m 2048 \
      -vga virtio \
      -boot menu=3Don \
      -smbios file=3D/path/dmidecode_BIOS.bin \
      -acpitable file=3D/path/acpi_slic.bin \
      -bios /path/OVMF_CODE.fd \
      -net none \
      -drive if=3Dvirtio,media=3Ddisk,file=3D/media/win7.qcow2 \
      -device pcie-root-port \
      -device ich9-usb-ehci1 \
      -device ich9-usb-uhci1 \
      -device ich9-usb-uhci2 \
      -device ich9-usb-uhci3

  Windows hangs at boot with waving flag screen (flag doesn't freeze,
  keeps waving indefinitely). Same command line boots fine with Qemu
  2.9. I tried changing machine type to pc-q35-2.9 - same result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715700/+subscriptions
