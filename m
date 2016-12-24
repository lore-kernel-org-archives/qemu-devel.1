Received: from eggs.gnu.org ([2001:4830:134:3::10]:59450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKe0o-0001Jm-Tf
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKe0n-0000gH-PN
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKe0n-0000g7-JY
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKe0m-0003Bg-5H
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 04:32:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C72B2E8214
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 04:32:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Dec 2016 04:17:25 -0000
From: Launchpad Bug Tracker <1469978@bugs.launchpad.net>
Reply-To: Bug 1469978 <1469978@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150630072558.11284.93260.malonedeb@soybean.canonical.com>
Message-Id: <20161224041726.24507.62304.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1469978] Re: compile qemu use with KVM machine
 not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1469978

Title:
  compile qemu use with KVM machine not supported

Status in QEMU:
  Expired

Bug description:
  I have to compile qemu 2.3.0 and 2.2.0. and install follow this.
       ./configure --enable-kvm --target-list=3Dx86_64-softmmu
       make
       make install
  It's located in /usr/local/bin
  I want to use qemu with KVM so I copy /usr/local/bin/qemu-system-x86_64 t=
o /usr/bin

  and I run VMM for start my VM.


  -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------
  Error starting domain: internal error: process exited while connecting to=
 monitor: qemu-system-x86_64: -device virtio-balloon-pci,id=3Dballoon0,bus=
=3Dpci.0,addr=3D0x6: Unsupported machine type
  Use -machine help to list supported machines!

  =

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 96, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 117, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/domain.py", line 1162, in sta=
rtup
      self._backend.create()
    File "/usr/lib/python2.7/dist-packages/libvirt.py", line 866, in create
      if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed', dom=
=3Dself)
  libvirtError: internal error: process exited while connecting to monitor:=
 qemu-system-x86_64: -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,a=
ddr=3D0x6: Unsupported machine type
  Use -machine help to list supported machines!

  -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------

  I can't use my VM except reinstall kvm, qemu-kvm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1469978/+subscriptions
