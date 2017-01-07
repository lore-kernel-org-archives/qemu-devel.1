Received: from eggs.gnu.org ([2001:4830:134:3::10]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPieC-0002Om-22
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPieB-00017m-6d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:34926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPieB-00016Y-0k
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPieA-0000jf-0Y
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 04:30:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB1552E80CA
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 04:30:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 04:17:46 -0000
From: Launchpad Bug Tracker <485250@bugs.launchpad.net>
Reply-To: Bug 485250 <485250@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091119103034.30387.95497.malonedeb@wampee.canonical.com>
Message-Id: <20170107041746.790.18459.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 485250] Re: nic e1000 network interface does not
 work with 32-bit windows 2003r2 with sp2
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
https://bugs.launchpad.net/bugs/485250

Title:
  nic e1000 network interface does not work with 32-bit windows 2003r2
  with  sp2

Status in QEMU:
  Expired

Bug description:
  nic e1000 network interface does not work with win2k3r2 32bit

  e1000 driver in win2k3r2 32bit seems to be broken. The interface is able =
to
  receive ip from the dhcp server, but not able to ping it from any linux g=
uest or
  host, but was able to ping it from windows guest.

  Running network test, netperf, between the windows guest fails with the m=
essage =

  "netperf: receive_response: no response received. errno 104 counter 0"

  cmdline used:
  /usr/local/bin/qemu-system-x86_64 -drive file=3Dwin2003r2sp2-32.raw,boot=
=3Don -net nic,vlan=3D0,macaddr=3D20:20:20:00:00:04,model=3De1000  -net tap=
,vlan=3D0,script=3D/home/yogi/qemu-ifup  -m 2048 -enable-kvm  -usbdevice ta=
blet -vnc :1

  uname -a
  Linux bc1cn9 2.6.30.9-96.fc11.x86_64 #1 SMP Wed Nov 4 00:02:04 EST 2009 x=
86_64 x86_64 x86_64 GNU/Linux

  Distro: fedora 11

  Thx
  yogi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/485250/+subscriptions
