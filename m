Received: from eggs.gnu.org ([209.51.188.92]:55815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h0QQF-0008A6-SJ
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 07:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h0QQD-0005US-Mi
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 07:40:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:58408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h0QQD-0005TJ-Fk
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 07:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h0QQA-00043z-R9
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 12:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C8D242E8031
	for <qemu-devel@nongnu.org>; Sun,  3 Mar 2019 12:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Mar 2019 12:31:35 -0000
From: Yohann Agrebbe <1818398@bugs.launchpad.net>
Reply-To: Bug 1818398 <1818398@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155161629551.17312.8753163653910781588.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818398] [NEW] No evdev mouse passthrough with
 virtio-vga or kvm
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

Hi,

Using qemu version 3.1.0-1 on a host with the latest Archlinux 64-bit
distribution, and running the same OS as guest, the mouse doesn't work
when using both evdev passthrough and virtio-vga, or when using both
evdev passthrough and kvm.

The following command line runs a machine that does not receive any mouse e=
vent:
qemu-system-x86_64 -machine type=3Dq35,accel=3Dkvm -cpu host -accel kvm -bo=
ot order=3Ddc,menu=3Don -m size=3D2048 -net nic -device virtio-vga -device =
intel-hda -name Linux -drive file=3D/mnt/data/nobody/linux/arch.img,if=3Dvi=
rtio -display sdl,gl=3Don -full-screen -net user -D /dev/null -rtc base=3Du=
tc,clock=3Dhost,driftfix=3Dslew -nodefaults -object input-linux,id=3Dkbd1,e=
vdev=3D/dev/input/event6,grab_all=3Don,repeat=3Don -object input-linux,id=
=3Dmouse1,evdev=3D/dev/input/event7

But with this command line, removing virtio-vga and kvm, the mouse works as=
 expected:
qemu-system-x86_64 -machine type=3Dq35 -boot order=3Ddc,menu=3Don -m size=
=3D2048 -net nic -device cirrus-vga -device intel-hda -name Linux -drive fi=
le=3D/mnt/data/nobody/linux/arch.img,if=3Dvirtio -display sdl,gl=3Don -full=
-screen -net user -D /dev/null -rtc base=3Dutc,clock=3Dhost,driftfix=3Dslew=
 -nodefaults -object input-linux,id=3Dkbd1,evdev=3D/dev/input/event6,grab_a=
ll=3Don,repeat=3Don -object input-linux,id=3Dmouse1,evdev=3D/dev/input/even=
t7

Note: Passing a keyboard by evdev in the same way always works, the
problem is mouse specific.

Thanks in advance for the analysis,
gatestallman

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: evdev kvm mouse virtio-vga

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818398

Title:
  No evdev mouse passthrough with virtio-vga or kvm

Status in QEMU:
  New

Bug description:
  Hi,

  Using qemu version 3.1.0-1 on a host with the latest Archlinux 64-bit
  distribution, and running the same OS as guest, the mouse doesn't work
  when using both evdev passthrough and virtio-vga, or when using both
  evdev passthrough and kvm.

  The following command line runs a machine that does not receive any mouse=
 event:
  qemu-system-x86_64 -machine type=3Dq35,accel=3Dkvm -cpu host -accel kvm -=
boot order=3Ddc,menu=3Don -m size=3D2048 -net nic -device virtio-vga -devic=
e intel-hda -name Linux -drive file=3D/mnt/data/nobody/linux/arch.img,if=3D=
virtio -display sdl,gl=3Don -full-screen -net user -D /dev/null -rtc base=
=3Dutc,clock=3Dhost,driftfix=3Dslew -nodefaults -object input-linux,id=3Dkb=
d1,evdev=3D/dev/input/event6,grab_all=3Don,repeat=3Don -object input-linux,=
id=3Dmouse1,evdev=3D/dev/input/event7

  But with this command line, removing virtio-vga and kvm, the mouse works =
as expected:
  qemu-system-x86_64 -machine type=3Dq35 -boot order=3Ddc,menu=3Don -m size=
=3D2048 -net nic -device cirrus-vga -device intel-hda -name Linux -drive fi=
le=3D/mnt/data/nobody/linux/arch.img,if=3Dvirtio -display sdl,gl=3Don -full=
-screen -net user -D /dev/null -rtc base=3Dutc,clock=3Dhost,driftfix=3Dslew=
 -nodefaults -object input-linux,id=3Dkbd1,evdev=3D/dev/input/event6,grab_a=
ll=3Don,repeat=3Don -object input-linux,id=3Dmouse1,evdev=3D/dev/input/even=
t7

  Note: Passing a keyboard by evdev in the same way always works, the
  problem is mouse specific.

  Thanks in advance for the analysis,
  gatestallman

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818398/+subscriptions
