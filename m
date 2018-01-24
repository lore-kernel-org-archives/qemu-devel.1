Received: from eggs.gnu.org ([2001:4830:134:3::10]:46462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeQIK-0005PI-ME
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeQIH-0001Nf-Lx
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:53140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeQIH-0001N7-F1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeQIG-0003eC-7z
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 19:01:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37CE22E8059
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 19:01:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 18:44:56 -0000
From: Thomas Huth <1381879@bugs.launchpad.net>
Reply-To: Bug 1381879 <1381879@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141016054140.18041.12891.malonedeb@chaenomeles.canonical.com>
Message-Id: <151681949670.20366.5049299049082391764.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1381879] Re: can not run vm with a serial port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Opening a socket with the name of a device file can not work, you've got
to specify a different name for a unix socket instead. So this is not a
bug.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1381879

Title:
  can not run vm with a serial port

Status in QEMU:
  Invalid

Bug description:
  environment:
  server: centOS 6.5, 3.14.19, x86_64
  qemu-kvm: QEMU PC emulator version 0.12.1 (qemu-kvm-0.12.1.2), Copyright =
(c) 2003-2008 Fabrice Bellard
  qemu-system-x86_64 :QEMU emulator version 1.2.0 (qemu-kvm-1.2.0), Copyrig=
ht (c) 2003-2008 Fabrice Bellard
  virt-manager: 0.9.0

  VM: centOS 6.5, 3.12.30, x86_64

  reproduce step:
  1. add serial device
  2. select device type: unix socket
                   device parameters: path=3D/dev/ttyS0
                                                         mode=3Dclient mode=
(connect)
  3. run the VM

  phenomenon:
  Error starting domain: internal error process exited while connecting to =
monitor: qemu-kvm: -chardev socket,id=3Dcharserial0,path=3D/dev/ttyS0,serve=
r,nowait: socket bind failed: Address already in use
  qemu-kvm: -chardev socket,id=3Dcharserial0,path=3D/dev/ttyS0,server,nowai=
t: chardev: opening backend "socket" failed

  =

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 44, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 65, in tmp=
cb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/domain.py", line 1114, in sta=
rtup
      self._backend.create()
    File "/usr/lib64/python2.6/site-packages/libvirt.py", line 678, in crea=
te
      if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed', dom=
=3Dself)
  libvirtError: internal error process exited while connecting to monitor: =
qemu-kvm: -chardev socket,id=3Dcharserial0,path=3D/dev/ttyS0,server,nowait:=
 socket bind failed: Address already in use
  qemu-kvm: -chardev socket,id=3Dcharserial0,path=3D/dev/ttyS0,server,nowai=
t: chardev: opening backend "socket" failed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1381879/+subscriptions
