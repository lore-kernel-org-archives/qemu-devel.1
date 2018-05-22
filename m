Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7bp-00072y-NK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7bl-0003lK-0w
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:51098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7bk-0003kX-RO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7bj-0008Hr-Q9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C39A52E8F39
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:33:58 -0000
From: Thomas Huth <1404278@bugs.launchpad.net>
Reply-To: Bug 1404278 <1404278@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141219153639.25009.84583.malonedeb@wampee.canonical.com>
Message-Id: <152699603815.8523.4346946182504984444.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1404278] Re: tap connections not working on
 windows host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1404278

Title:
  tap connections not working on windows host

Status in QEMU:
  Incomplete

Bug description:
  using latest qemu 2.2.0 64bit for windows host (installed from
  qemu-w64-setup-20141210.exe obtained from http://qemu.weilnetz.de/w64/
  ),OpenVPN 2.6.3-I601 64bit tap adapter named tap01 and calling qemu
  using the following.

  qemu-system-x86_64.exe -m 512 -net nic -net tap,ifname=3Dtap01 -hda
  "c:\\data\\images\\test.img"

  where the image contains a slackware 14.0 64bit install.
  The tap is bridged with the real network adapter and the bridge is given =
an ip of 10.1.1.41 (which works as the ip for the windows host). The tap ad=
apter (in network connections) shows connected when the qemu vm is running.=
 inside the vm, the network is given an ip of 10.1.1.143 (the netmask and d=
efault gateway are the same for the virtual and real pc).
  fault.
  The vm cannot see the rest of the local network or visa-versa. This used =
to work in early (0.9 32bit) versions of qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1404278/+subscriptions
