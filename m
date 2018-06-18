Received: from eggs.gnu.org ([2001:4830:134:3::10]:55944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUloD-0006JU-Ea
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUlo7-00054M-Hp
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUlo7-00053X-Ao
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:30:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUlo6-0004RT-B6
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:30:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52B332E802E
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 04:30:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Jun 2018 04:17:38 -0000
From: Launchpad Bug Tracker <1228285@bugs.launchpad.net>
Reply-To: Bug 1228285 <1228285@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130920172123.20190.55970.malonedeb@wampee.canonical.com>
Message-Id: <152929545901.23342.13254026854170505639.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1228285] Re: e1000 nic TCP performances
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
https://bugs.launchpad.net/bugs/1228285

Title:
  e1000 nic TCP performances

Status in QEMU:
  Expired

Bug description:
  Hi,

  Here is the context :

  $ qemu -name A -m 1024 -net nic vlan=3D0,model=3De1000 -net socket,vlan=
=3D0,listen=3D127.0.0.1:7000
  $ qemu -name B -m 1024 -net nic vlan=3D0,model=3De1000 -net socket,vlan=
=3D0,connect=3D127.0.0.1:7000

  The bandwidth is really tiny :

      . Iperf3 reports about 30 Mb/sec
      . NetPerf reports about 50 Mb/sec

  =

  With UDP sockets, there is no problem at all :

      . Iperf3 reports about 1 Gb/sec
      . NetPerf reports about 950 Mb/sec

  =

  I've noticed this fact only with the e1000 NIC, not with others (rtl8139,=
virtio, etc.)
  I've used the main GIT version of QEMU.

  =

  Thanks in advance.

  See you,
  VInce

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1228285/+subscriptions
