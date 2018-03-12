Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF68-0007vc-9N
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF67-0005wW-7p
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evF67-0005wK-1O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evF66-0001Jl-8x
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 40F092E806F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2018 04:17:35 -0000
From: Launchpad Bug Tracker <1086745@bugs.launchpad.net>
Reply-To: Bug 1086745 <1086745@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121205112012.6348.41927.malonedeb@gac.canonical.com>
Message-Id: <152082825566.7858.6535861119380547783.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1086745] Re: serial port data THRE comes too early
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
https://bugs.launchpad.net/bugs/1086745

Title:
  serial port data THRE comes too early

Status in QEMU:
  Expired

Bug description:
  When using a serial port with a Linux guest (and host) and the
  application uses hardware handshake, this fails because the handling
  of TEMT and/or THRE is not operating properly in such cases.

  As long as it takes _time_ for the 'real' port to output the data TEMT
  may not return true. After writing characters to a real port, the
  driver should timeout the transmission and after the total time
  expired, TEMT can be set.

  Some applications i.e. with a simplex modem do: RTS_on, WRITE_data, repea=
t IOCTL(GET_LSR_INFO), RTS_off, READ_data.
  At the moment this fails because very early in the transmission, GET_LSR_=
INFO returns true and the modem transmitter is switched off.

  I looked in the source (git)  and found that 'char_transmit_time' is pres=
ent. My skills fail to implement it myself.
  I build and ran the latest git version and found it to fail as decribed a=
bove.  I hope someone can solve it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1086745/+subscriptions
