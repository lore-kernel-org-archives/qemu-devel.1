Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpTtt-0007un-3A
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 02:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpTtp-0000J5-Nl
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 02:01:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:58459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpTtp-0000Hn-Fc
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 02:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpTtn-0005Bk-G3
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 06:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 750202E808D
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 06:01:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Mar 2017 05:50:44 -0000
From: spongebob <1674056@bugs.launchpad.net>
Reply-To: Bug 1674056 <1674056@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170319055044.30113.9822.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1674056] [NEW] USB keyboard and mouse sucked into
 qemu-kvm (somewhere)
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

i am unable to run a command line qemu that does not "suck in" the keyboard=
 and mouse of the host PC
i tried all that i could from the command line parameters i want to run a h=
eadless gui-less kvm host

if i specify a second set of keyboard and mouse with the -usb the only thin=
g that is diffrent is that i have a keyboard and mouse in the VM if i speci=
fy the host keyboard and mouse same thing ... the vm is working fine but th=
e host has no control , no keyboard. i dont see any output of anything =

the only recourse i have is ctrl+alt+delete  and that resets the host after=
 2-3 times. =


i tried ctrl+alt, ctrl+alt+x , c , z , 2 , etc... also alt + all those comb=
ination and alt with F keys =

no luck. =



my command line looks like this (altough i tried many other variations)
 =

qemu-system-x86_64 -M q35 -enable-kvm \
-cpu host,kvm=3Doff -m 4096 -smp cpu=3D4,sockets=3D1,cores=3D4,treads=3D1 \
-drive file=3Dxyz.qcow2,if=3Dscsi \
-device vfio-pci, ... (GPU) \
-device vfio-pci, .... (GPU audio) \
-usb -usbdevice host:XXXX:XXXX -usbdevice host:XXXX:XXXX \   <<< same behav=
iour with and without
-vga none -vnc localhost:1 -daemonize  =


i tried with -nographics , -curses, -monitor stdio, pty and none, same resu=
lt and with -serial as well
tried </dev/null at the end of the command no luck same with & =


my guess is that the keyboard and mouse gets grabbed by the "window" of
the qemu regardless if there is graphics or not and i have not foud a
"-headless" ,"-nograb" or "-nopussygrab" mode . (yeah had to make the
joke :P)

hardware:
Z97N-wifi =

Intel(R) Core(TM) i5-4690K CPU @ 3.50GHz
ram > 8Gb
keyboard is logitech
mouse is logitech

distro is suse leap 42.1 (made with suseStudio)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1674056

Title:
  USB keyboard and mouse sucked into qemu-kvm (somewhere)

Status in QEMU:
  New

Bug description:
  i am unable to run a command line qemu that does not "suck in" the keyboa=
rd and mouse of the host PC
  i tried all that i could from the command line parameters i want to run a=
 headless gui-less kvm host

  if i specify a second set of keyboard and mouse with the -usb the only th=
ing that is diffrent is that i have a keyboard and mouse in the VM if i spe=
cify the host keyboard and mouse same thing ... the vm is working fine but =
the host has no control , no keyboard. i dont see any output of anything =

  the only recourse i have is ctrl+alt+delete  and that resets the host aft=
er 2-3 times. =


  i tried ctrl+alt, ctrl+alt+x , c , z , 2 , etc... also alt + all those co=
mbination and alt with F keys =

  no luck. =


  =

  my command line looks like this (altough i tried many other variations)
   =

  qemu-system-x86_64 -M q35 -enable-kvm \
  -cpu host,kvm=3Doff -m 4096 -smp cpu=3D4,sockets=3D1,cores=3D4,treads=3D1=
 \
  -drive file=3Dxyz.qcow2,if=3Dscsi \
  -device vfio-pci, ... (GPU) \
  -device vfio-pci, .... (GPU audio) \
  -usb -usbdevice host:XXXX:XXXX -usbdevice host:XXXX:XXXX \   <<< same beh=
aviour with and without
  -vga none -vnc localhost:1 -daemonize  =


  i tried with -nographics , -curses, -monitor stdio, pty and none, same re=
sult and with -serial as well
  tried </dev/null at the end of the command no luck same with & =


  my guess is that the keyboard and mouse gets grabbed by the "window"
  of the qemu regardless if there is graphics or not and i have not foud
  a "-headless" ,"-nograb" or "-nopussygrab" mode . (yeah had to make
  the joke :P)

  hardware:
  Z97N-wifi =

  Intel(R) Core(TM) i5-4690K CPU @ 3.50GHz
  ram > 8Gb
  keyboard is logitech
  mouse is logitech

  distro is suse leap 42.1 (made with suseStudio)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1674056/+subscriptions
