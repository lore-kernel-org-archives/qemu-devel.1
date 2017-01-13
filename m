Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRxZJ-00029z-Pu
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRxZG-00080P-Jt
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:50:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:52399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRxZG-000803-Do
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRxZD-0006P4-8f
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 212672E80C7
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 08:40:22 -0000
From: Robert Hu <robert.hu@intel.com>
Reply-To: Bug 1656234 <1656234@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170113084022.20152.24498.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1656234] [NEW] Qemu core dumped if using
 virtio-net
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

System Environment
=3D=3D=3D=3D=3D=3D=3D
Qemu commit/branch: e92fbc75
Host OS: RHEL7.2 ia32e
Host Kernel: 4.9.0
Guest OS: RHEL7.2 ia32e
Guest Kernel: 4.9.0

Bug detailed description
=3D=3D=3D=3D=3D=3D=3D
While create a kvm guest using virtio-net, the qemu will core dump with sho=
wing "Aborted (core dumped)".
Reproduce Steps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
create a guest:
qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -device virtio-net-pci,netdev=
=3Dnic0,mac=3D00:16:3e:49:be:24 -netdev tap,id=3Dnic0,script=3D/etc/kvm/qem=
u-ifup -drive file=3D/ia32e_rhel7u2_kvm.qcow2,if=3Dnone,id=3Dvirtio-disk0 -=
device virtio-blk-pci,drive=3Dvirtio-disk0 -serial file:serial.log

Current Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

qemu-system-x86_64: /workspace/ia32e/nightly/kvm-next-20170105-ef85b6-e92fb=
c/kvm/qemu/hw/virtio/virtio.c:214: virtio_queue_set_notification: Assertion=
 `vq->notification_disabled > 0' failed.
Aborted (core dumped)

add info
=3D=3D=3D=3D=3D=3D=3D=3D
[root@hsw-ep2 Desktop]# dmesg |grep -v virbr0 |tail -n 10
[ 1760.265000] device tap0 left promiscuous mode
[ 1879.148642] device tap0 entered promiscuous mode
[ 1885.213702] kvm [14186]: vcpu0, guest rIP: 0xffffffff81066784 disabled p=
erfctr wrmsr: 0xc2 data 0xffff
[ 1912.258783] device tap0 left promiscuous mode
[ 1995.972267] device tap0 entered promiscuous mode
[ 2001.990207] kvm [14335]: vcpu0, guest rIP: 0xffffffff81066784 disabled p=
erfctr wrmsr: 0xc2 data 0xffff
[ 2024.703072] device tap0 left promiscuous mode
[ 2145.374239] device tap0 entered promiscuous mode
[ 2151.409948] kvm [14541]: vcpu0, guest rIP: 0xffffffff81066784 disabled p=
erfctr wrmsr: 0xc2 data 0xffff
[ 2178.281446] device tap0 left promiscuous mode

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "guest serial log"
   https://bugs.launchpad.net/bugs/1656234/+attachment/4803773/+files/seria=
l.log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656234

Title:
  Qemu core dumped if using virtio-net

Status in QEMU:
  New

Bug description:
  System Environment
  =3D=3D=3D=3D=3D=3D=3D
  Qemu commit/branch: e92fbc75
  Host OS: RHEL7.2 ia32e
  Host Kernel: 4.9.0
  Guest OS: RHEL7.2 ia32e
  Guest Kernel: 4.9.0

  Bug detailed description
  =3D=3D=3D=3D=3D=3D=3D
  While create a kvm guest using virtio-net, the qemu will core dump with s=
howing "Aborted (core dumped)".
  Reproduce Steps
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  create a guest:
  qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -device virtio-net-pci,netd=
ev=3Dnic0,mac=3D00:16:3e:49:be:24 -netdev tap,id=3Dnic0,script=3D/etc/kvm/q=
emu-ifup -drive file=3D/ia32e_rhel7u2_kvm.qcow2,if=3Dnone,id=3Dvirtio-disk0=
 -device virtio-blk-pci,drive=3Dvirtio-disk0 -serial file:serial.log

  Current Result:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  qemu-system-x86_64: /workspace/ia32e/nightly/kvm-next-20170105-ef85b6-e92=
fbc/kvm/qemu/hw/virtio/virtio.c:214: virtio_queue_set_notification: Asserti=
on `vq->notification_disabled > 0' failed.
  Aborted (core dumped)

  add info
  =3D=3D=3D=3D=3D=3D=3D=3D
  [root@hsw-ep2 Desktop]# dmesg |grep -v virbr0 |tail -n 10
  [ 1760.265000] device tap0 left promiscuous mode
  [ 1879.148642] device tap0 entered promiscuous mode
  [ 1885.213702] kvm [14186]: vcpu0, guest rIP: 0xffffffff81066784 disabled=
 perfctr wrmsr: 0xc2 data 0xffff
  [ 1912.258783] device tap0 left promiscuous mode
  [ 1995.972267] device tap0 entered promiscuous mode
  [ 2001.990207] kvm [14335]: vcpu0, guest rIP: 0xffffffff81066784 disabled=
 perfctr wrmsr: 0xc2 data 0xffff
  [ 2024.703072] device tap0 left promiscuous mode
  [ 2145.374239] device tap0 entered promiscuous mode
  [ 2151.409948] kvm [14541]: vcpu0, guest rIP: 0xffffffff81066784 disabled=
 perfctr wrmsr: 0xc2 data 0xffff
  [ 2178.281446] device tap0 left promiscuous mode

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656234/+subscriptions
