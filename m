Received: from eggs.gnu.org ([2001:4830:134:3::10]:35148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d1ZaE-0000ah-AH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d1ZaB-0006YN-6Z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:55643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d1ZaB-0006Y5-0S
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d1Za9-0002jJ-1Z
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 14:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1D762E80CB
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 14:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Apr 2017 14:23:19 -0000
From: flumm <dominik.csapak@gmail.com>
Reply-To: Bug 1685242 <1685242@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170421142319.16919.35932.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1685242] [NEW] ovmf hangs at efi with virtio-net
 memory hotplug
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

with qemu 2.9 it hangs at the efi stage when memory-hotplug is enabled
and it has a virtio-net devices

the ovmf images where compiled from https://github.com/tianocore/edk2
(current master)

reproducer:

qemu-system-x86_64 -drive
'if=3Dpflash,unit=3D0,format=3Draw,readonly,file=3D./OVMF_CODE.fd' -drive
'if=3Dpflash,unit=3D1,format=3Draw,file=3D./my_OVMF_VARS.fd' -smp 1 -vga std
-netdev 'type=3Dtap,id=3Dmynet' -device 'virtio-net-pci,netdev=3Dmynet'
-display sdl -nodefaults -m 'size=3D1G,slots=3D256,maxmem=3D1024G'

interestingly, it works when you do the following:

- omit the virtio-net-pci device
- use seabios
- use less maxmem, e.g. 512G

qemu was compiled from source (v2.9.0) with following options:

./configure --target-list=3Dx86_64-softmmu --disable-xen --enable-gnutls --=
enable-sdl --enable-linux-aio --enable-rbd --enable-libiscsi --disable-smar=
tcard --audio-drv-list=3D"alsa" --enable
-spice --enable-usb-redir --enable-glusterfs --enable-libusb --disable-gtk =
--enable-xfsctl --enable-numa --disable-strip --enable-jemalloc --enable-vi=
rtfs --disable-libnfs --disable-fdt --disable-guest-agent --disable-guest-a=
gent-msi

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1685242

Title:
  ovmf hangs at efi with virtio-net memory hotplug

Status in QEMU:
  New

Bug description:
  with qemu 2.9 it hangs at the efi stage when memory-hotplug is enabled
  and it has a virtio-net devices

  the ovmf images where compiled from https://github.com/tianocore/edk2
  (current master)

  reproducer:

  qemu-system-x86_64 -drive
  'if=3Dpflash,unit=3D0,format=3Draw,readonly,file=3D./OVMF_CODE.fd' -drive
  'if=3Dpflash,unit=3D1,format=3Draw,file=3D./my_OVMF_VARS.fd' -smp 1 -vga =
std
  -netdev 'type=3Dtap,id=3Dmynet' -device 'virtio-net-pci,netdev=3Dmynet'
  -display sdl -nodefaults -m 'size=3D1G,slots=3D256,maxmem=3D1024G'

  interestingly, it works when you do the following:

  - omit the virtio-net-pci device
  - use seabios
  - use less maxmem, e.g. 512G

  qemu was compiled from source (v2.9.0) with following options:

  ./configure --target-list=3Dx86_64-softmmu --disable-xen --enable-gnutls =
--enable-sdl --enable-linux-aio --enable-rbd --enable-libiscsi --disable-sm=
artcard --audio-drv-list=3D"alsa" --enable
  -spice --enable-usb-redir --enable-glusterfs --enable-libusb --disable-gt=
k --enable-xfsctl --enable-numa --disable-strip --enable-jemalloc --enable-=
virtfs --disable-libnfs --disable-fdt --disable-guest-agent --disable-guest=
-agent-msi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1685242/+subscriptions
