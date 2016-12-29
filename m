Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cMVsK-0001fC-3Q
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cMVsG-0003Fu-Ur
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:15:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:60729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cMVsG-0003Fd-Nw
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:15:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cMVsE-0001Lp-Kc
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 08:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9ABE12E80C9
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 08:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Dec 2016 08:02:16 -0000
From: Hansni Bu <1653063@bugs.launchpad.net>
Reply-To: Bug 1653063 <1653063@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1653063] [NEW] qemu-system-arm hangs with -icount
 and -nodefaults
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

I tested with the latest git repo, (commit:
dbe2b65566e76d3c3a0c3358285c0336ac61e757).

My configure options when building QEMU:
'../configure' '--prefix=3D$HOME/local/qemu.git' '--target-list=3Daarch64-s=
oftmmu,arm-softmmu' '--cpu=3Dx86_64' '--cc=3Dgcc' '--disable-user' '--disab=
le-sdl' '--disable-stack-protector' '--disable-attr' '--disable-pie' '--dis=
able-linux-aio' '--disable-tpm' '--without-system-pixman' '--disable-docs' =
'--disable-guest-agent' '--disable-guest-agent-msi' '--disable-modules' '--=
disable-sparse' '--disable-gnutls' '--disable-nettle' '--disable-gcrypt' '-=
-disable-gtk' '--disable-vte' '--disable-curses' '--disable-vnc' '--disable=
-cocoa' '--disable-virtfs' '--disable-xen' '--disable-brlapi' '--disable-cu=
rl' '--disable-bluez' '--disable-rdma' '--disable-uuid' '--disable-vde' '--=
disable-netmap' '--disable-cap-ng' '--disable-attr' '--disable-vhost-net' '=
--disable-spice' '--disable-rbd' '--disable-libiscsi' '--disable-libnfs' '-=
-disable-smartcard' '--disable-libusb' '--disable-usb-redir' '--disable-lzo=
' '--disable-snappy' '--disable-bzip2' '--disable-seccomp' '--disable-glust=
erfs' '--disable-archipelago' '--disable-libssh2' '--disable-vhdx' '--disab=
le-numa' '--disable-werror' '--disable-blobs' '--disable-vhost-scsi' '--ena=
ble-debug' '--disable-strip' '--enable-debug-tcg' '--enable-debug-info' '--=
extra-cflags=3D-fPIC'

My host OS is Redhat RHEL-6.5. uname command gives:
Linux rslpc1 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x86_=
64 x86_64 x86_64 GNU/Linux

The test image is downloaded from http://wiki.qemu.org/download/arm-
test-0.2.tar.gz

The command to re-produce the problem:
qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initrd =
arm-test/arm_root.img -nographic -icount 1 -nodefaults -chardev stdio,mux=
=3Don,id=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"

After console prints the message below:
"Uncompressing Linux.......................................................=
................... done, booting the kernel."
there's no further action noticed.

If "-icount" is not set, namely run as:
qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initrd =
arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Don,id=3Dc=
har0 -serial chardev:char0 --append "console=3DttyAMA0"

or if "-nodefaults" is not set, namely run as:
qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initrd =
arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyAMA0"

The Linux boot procedure can finish successfully.

Thanks.
Hansni

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: icount nodefaults

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653063

Title:
  qemu-system-arm hangs with -icount and -nodefaults

Status in QEMU:
  New

Bug description:
  I tested with the latest git repo, (commit:
  dbe2b65566e76d3c3a0c3358285c0336ac61e757).

  My configure options when building QEMU:
  '../configure' '--prefix=3D$HOME/local/qemu.git' '--target-list=3Daarch64=
-softmmu,arm-softmmu' '--cpu=3Dx86_64' '--cc=3Dgcc' '--disable-user' '--dis=
able-sdl' '--disable-stack-protector' '--disable-attr' '--disable-pie' '--d=
isable-linux-aio' '--disable-tpm' '--without-system-pixman' '--disable-docs=
' '--disable-guest-agent' '--disable-guest-agent-msi' '--disable-modules' '=
--disable-sparse' '--disable-gnutls' '--disable-nettle' '--disable-gcrypt' =
'--disable-gtk' '--disable-vte' '--disable-curses' '--disable-vnc' '--disab=
le-cocoa' '--disable-virtfs' '--disable-xen' '--disable-brlapi' '--disable-=
curl' '--disable-bluez' '--disable-rdma' '--disable-uuid' '--disable-vde' '=
--disable-netmap' '--disable-cap-ng' '--disable-attr' '--disable-vhost-net'=
 '--disable-spice' '--disable-rbd' '--disable-libiscsi' '--disable-libnfs' =
'--disable-smartcard' '--disable-libusb' '--disable-usb-redir' '--disable-l=
zo' '--disable-snappy' '--disable-bzip2' '--disable-seccomp' '--disable-glu=
sterfs' '--disable-archipelago' '--disable-libssh2' '--disable-vhdx' '--dis=
able-numa' '--disable-werror' '--disable-blobs' '--disable-vhost-scsi' '--e=
nable-debug' '--disable-strip' '--enable-debug-tcg' '--enable-debug-info' '=
--extra-cflags=3D-fPIC'

  My host OS is Redhat RHEL-6.5. uname command gives:
  Linux rslpc1 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x8=
6_64 x86_64 x86_64 GNU/Linux

  The test image is downloaded from http://wiki.qemu.org/download/arm-
  test-0.2.tar.gz

  The command to re-produce the problem:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 -nodefaults -chardev stdio,mux=
=3Don,id=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"

  After console prints the message below:
  "Uncompressing Linux.....................................................=
..................... done, booting the kernel."
  there's no further action noticed.

  If "-icount" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Don,id=
=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"

  or if "-nodefaults" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyAMA0"

  The Linux boot procedure can finish successfully.

  Thanks.
  Hansni

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1653063/+subscriptions
