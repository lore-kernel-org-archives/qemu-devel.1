Received: from eggs.gnu.org ([2001:4830:134:3::10]:34770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPieB-0002Np-2H
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPieA-00015e-24
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:27 -0500
Received: from indium.canonical.com ([91.189.90.7]:34896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPie9-00014O-Sl
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPie8-0000jf-V7
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 04:30:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E93F52E8019
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 04:30:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 04:17:47 -0000
From: Launchpad Bug Tracker <485258@bugs.launchpad.net>
Reply-To: Bug 485258 <485258@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091119104216.9545.34446.malonedeb@potassium.ubuntu.com>
Message-Id: <20170107041747.790.28461.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 485258] Re: 64-bit win2003r2 with sp2 64-bit with
 network type rtl8139 generates blue screen after running network test
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
https://bugs.launchpad.net/bugs/485258

Title:
  64-bit win2003r2 with sp2 64-bit with network type rtl8139 generates
  blue screen after running network test

Status in QEMU:
  Expired

Bug description:
  64-bit win2003r2 with sp2 64-bit with network type rtl8139 generates
  blue screen after running network test

  Steps to recreate:
  1) install qemu frm git clone git://git.savannah.nongnu.org/qemu.git

  2)Download Soap Stone Benchmark(http://soap-stone.sourceforge.net/)
  and IBM java 1.4 for windows

  3)use  win2k3r2sp2 64-bit as the server and win2k3r2sp2 32-bit as
  client (this bug does not occur when win2k3r2sp2 64-bit is the client)

  4) Running the test will reset the  network interface on the
  server(win2k3r2sp264bit).

  5)Then shutdown the server(win2k3r2sp2 64bit), which will generate a
  blue screen.

  =

  Qemu cmd line used:
  /usr/local/bin/qemu-system-x86_e 'vm1'  -drive file=3Dwin2003r2-64.raw,bo=
ot=3Don -net nic,vlan=3D0,macaddr=3D20:20:20:00:00:01,model=3Drtl8139  -net=
 tap,vlan=3D0,script=3D/home/yogi/qemu-ifup  -m 10240   -usbdevice tablet -=
vnc :0 -enable-kvm

  uname -a
  Linux bc1cn9 2.6.30.9-96.fc11.x86_64 #1 SMP Wed Nov 4 00:02:04 EST 2009 x=
86_64 x86_64 x86_64 GNU/Linux

  Distro: fedora 11

  I have attached the generated Blue Screen..

  Thx
  yogi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/485258/+subscriptions
