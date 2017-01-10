Received: from eggs.gnu.org ([2001:4830:134:3::10]:47760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQl7V-0007FY-Jj
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQl7Q-00021T-6d
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:21:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:51208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQl7P-00020S-UD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:20:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQl7M-0001rv-6m
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 01:20:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5C9552E80D6
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 01:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 01:10:54 -0000
From: Hansni Bu <1653063@bugs.launchpad.net>
Reply-To: Bug 1653063 <1653063@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161229080217.16446.50840.malonedeb@wampee.canonical.com>
Message-Id: <20170110011054.14666.40576.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1653063] Re: qemu-system-arm hangs with -icount
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

** Description changed:

- I tested with the latest git repo, (commit:
+ I tested with release 2.8.0 and the latest git repo, (commit:
  dbe2b65566e76d3c3a0c3358285c0336ac61e757).
  =

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
  =

  My host OS is Redhat RHEL-6.5. uname command gives:
  Linux rslpc1 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x8=
6_64 x86_64 x86_64 GNU/Linux
  =

  The test image is downloaded from http://wiki.qemu.org/download/arm-
  test-0.2.tar.gz
  =

  The command to re-produce the problem:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 -nodefaults -chardev stdio,mux=
=3Don,id=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"
  =

  After console prints the message below:
  "Uncompressing Linux.....................................................=
..................... done, booting the kernel."
  there's no further action noticed.
  =

  If "-icount" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -nodefaults -chardev stdio,mux=3Don,id=
=3Dchar0 -serial chardev:char0 --append "console=3DttyAMA0"
  =

  or if "-nodefaults" is not set, namely run as:
  qemu-system-arm -M integratorcp -kernel arm-test/zImage.integrator -initr=
d arm-test/arm_root.img -nographic -icount 1 --append "console=3DttyAMA0"
  =

  The Linux boot procedure can finish successfully.
  =

  Thanks.
  Hansni

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653063

Title:
  qemu-system-arm hangs with -icount and -nodefaults

Status in QEMU:
  New

Bug description:
  I tested with release 2.8.0 and the latest git repo, (commit:
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
