Received: from eggs.gnu.org ([2001:4830:134:3::10]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dezDc-0006Oh-1p
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dezDY-0005hf-1y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:46:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:40426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dezDX-0005h4-SQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:46:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dezDV-000413-Ih
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 07:46:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 628392E80CC
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 07:46:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 07:31:06 -0000
From: Thomas Huth <1318746@bugs.launchpad.net>
Reply-To: Bug 1318746 <1318746@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140512165208.6408.69277.malonedeb@chaenomeles.canonical.com>
Message-Id: <150217746688.18876.3210911905933172146.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1318746] Re: qemu Windows 7 BSOD when using
 hv-time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1318746

Title:
  qemu Windows 7 BSOD when using hv-time

Status in QEMU:
  Incomplete

Bug description:
  When I use hv-time sub option and run CPU-Z or 3DMark (Physics Test)
  the Windows 7 guest stops with BSOD (SYSTEM_SERVICE_EXCEPTION). It can
  be easily reproduced by running CPU-Z. It will fail every second or
  third time you execute CPU-Z and fail during "PCI detection". If I
  disable hv-time I can run CPU-Z and 3DMark (Physics Test) without any
  problems. QEMU was called with the following options:

  /usr/bin/taskset -c 4,5,6,7 /usr/bin/qemu-system-x86_64 \
  =C2=A0-machine q35,accel=3Dkvm,kernel_irqchip=3Don \
  =C2=A0-enable-kvm \
  =C2=A0-serial none \
  =C2=A0-parallel none \
  =C2=A0-monitor none \
  =C2=A0-vga std \
  =C2=A0-boot order=3Ddc \
  =C2=A0-cpu host,hv-time \
  =C2=A0-smp cores=3D4,threads=3D1,sockets=3D1 \
  =C2=A0-m 8192 \
  =C2=A0-k de \
  =C2=A0-rtc base=3Dlocaltime \
  =C2=A0-drive file=3D/srv/kvm/maggie-drive0.img,id=3Ddrive0,if=3Dnone,cach=
e=3Dnone,aio=3Dthreads \
  =C2=A0-mon chardev=3Dmonitor0 \
  =C2=A0-chardev socket,id=3Dmonitor0,path=3D/tmp/maggie.monitor,nowait,ser=
ver \
  =C2=A0-netdev tap,id=3Dnet0,vhost=3Don,helper=3D/usr/lib/qemu/qemu-bridge=
-helper \
  =C2=A0-device virtio-net-pci,netdev=3Dnet0,mac=3D00:00:00:02:01:01 \
  =C2=A0-device virtio-blk-pci,drive=3Ddrive0,ioeventfd=3Don \
  =C2=A0-device ioh3420,bus=3Dpcie.0,id=3Dpcie0,port=3D1,chassis=3D1,multif=
unction=3Don

  I've removed the VFIO PCI passthrough line of my GPU to make
  reproduction easier. In any case it happens in both scenarios so VGA
  passthrough is not the root cause. It happens with linux-3.15-rc5 and
  linux-3.14.3 with patch from commit mentioned at
  https://bugzilla.kernel.org/show_bug.cgi?id=3D73721#c3

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1318746/+subscriptions
