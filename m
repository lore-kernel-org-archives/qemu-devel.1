Received: from eggs.gnu.org ([2001:4830:134:3::10]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZwRJ-0005TW-Ag
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZwRG-0002Uz-4g
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:19:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:43268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZwRF-0002US-VU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:19:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZwRE-0001ky-9q
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:19:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2C1432E80E0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:19:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2018 10:02:25 -0000
From: ChristianEhrhardt <1162644@bugs.launchpad.net>
Reply-To: Bug 1162644 <1162644@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130401031929.8788.58878.malonedeb@gac.canonical.com>
Message-Id: <151575134690.31556.5061036257693528460.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1162644] Re: qemu-system-x86_64 crashed with
 SIGABRT in __assert_fail_base()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu (Ubuntu)
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1162644

Title:
  qemu-system-x86_64 crashed with SIGABRT in __assert_fail_base()

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  Description:
  When QEMU tries to boot with a usb 3.0 tablet (xhci) on a Raring ringtail=
 box (QEMU package1.4.0+dfsg-1expubuntu4)  it will crash soon afterwards:

  qemu-system-x86_64: /build/buildd/qemu-1.4.0+dfsg/hw/usb/core.c:552:
  usb_packet_setup: Assertion `p->iov.iov !=3D ((void *)0)' failed.

  Component:
  qemu-system -> 1.4.0+dfsg-1expubuntu4

  Ubuntu Version:

  Description:	Ubuntu Raring Ringtail (development branch)
  Release:	13.04

  Steps to reproduce it:

  I met this bug while running the virt-test suite

  https://github.com/autotest/virt-test

  Instructions to install and run it can be seen on the README file

  https://github.com/autotest/virt-test#readme

  After the suite is set, it can be reproduced on a raring (13.04)
  simply by running:

  ./run -t qemu --tests usb.usb_reboot.usb_tablet.xhci

  Command line:

  23:52:42 INFO | Running qemu command (reformatted):
  /usr/bin/kvm \
      -S \
      -name 'virt-tests-vm1' \
      -nodefaults \
      -chardev socket,id=3Dhmp_id_hmp1,path=3D/tmp/monitor-hmp1-20130331-23=
3911-ndvUEvrV,server,nowait \
      -mon chardev=3Dhmp_id_hmp1,mode=3Dreadline \
      -chardev socket,id=3Dserial_id_serial1,path=3D/tmp/serial-serial1-201=
30331-233911-ndvUEvrV,server,nowait \
      -device isa-serial,chardev=3Dserial_id_serial1 \
      -chardev socket,id=3Dseabioslog_id_20130331-233911-ndvUEvrV,path=3D/t=
mp/seabios-20130331-233911-ndvUEvrV,server,nowait \
      -device isa-debugcon,chardev=3Dseabioslog_id_20130331-233911-ndvUEvrV=
,iobase=3D0x402 \
      -device ich9-usb-uhci1,id=3Dusb1 \
      -device nec-usb-xhci,id=3Dusbtest \
      -drive file=3D'/home/lmr/Code/virt-test.git/shared/data/images/jeos-1=
7-64.qcow2',if=3Dnone,id=3Dvirtio0 \
      -device virtio-blk-pci,drive=3Dvirtio0,bootindex=3D1 \
      -device virtio-net-pci,netdev=3DidumV1TE,mac=3D'9a:c0:c1:c2:c3:c4',id=
=3D'idmN7iHv' \
      -netdev user,id=3DidumV1TE,hostfwd=3Dtcp::5000-:22 \
      -m 1024 \
      -smp 2,maxcpus=3D2,cores=3D1,threads=3D1,sockets=3D2 \
      -cpu 'SandyBridge' \
      -M pc \
      -device usb-tablet,id=3Dusb-tablet1,bus=3Dusb1.0,port=3D1 \
      -device usb-tablet,id=3Dusb-testdev,bus=3Dusbtest.0,port=3D1 \
      -vnc :0 \
      -vga std \
      -rtc base=3Dutc,clock=3Dhost,driftfix=3Dnone  \
      -boot order=3Dcdn,once=3Dc,menu=3Doff  \
      -enable-kvm

  ProblemType: Crash
  DistroRelease: Ubuntu 13.04
  Package: qemu-system-x86 1.4.0+dfsg-1expubuntu4
  ProcVersionSignature: Ubuntu 3.8.0-15.25-generic 3.8.4
  Uname: Linux 3.8.0-15-generic x86_64
  ApportVersion: 2.9.2-0ubuntu5
  Architecture: amd64
  Date: Sun Mar 31 23:52:46 2013
  EcryptfsInUse: Yes
  ExecutablePath: /usr/bin/qemu-system-x86_64
  InstallationDate: Installed on 2013-03-31 (0 days ago)
  InstallationMedia: Ubuntu 12.10 "Quantal Quetzal" - Release amd64 (201210=
17.5)
  MarkForUpload: True
  ProcEnviron:
   TERM=3Ddumb
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  Signal: 6
  SourcePackage: qemu
  StacktraceTop:
   raise () from /lib/x86_64-linux-gnu/libc.so.6
   abort () from /lib/x86_64-linux-gnu/libc.so.6
   ?? () from /lib/x86_64-linux-gnu/libc.so.6
   __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
   ?? ()
  Title: qemu-system-x86_64 crashed with SIGABRT in raise()
  UpgradeStatus: Upgraded to raring on 2013-03-31 (0 days ago)
  UserGroups: adm cdrom dip libvirtd lpadmin plugdev sambashare sudo

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1162644/+subscriptions
