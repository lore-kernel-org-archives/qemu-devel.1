Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSp9-0007U0-Rh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSp3-0007on-W9
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:46796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSp3-0007nK-QM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSp2-00089f-Nc
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:25:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A43292E80C1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:25:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 12:11:05 -0000
From: Thomas Huth <772358@bugs.launchpad.net>
Reply-To: Bug 772358 <772358@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110428132250.19043.64893.malonedeb@soybean.canonical.com>
Message-Id: <20170117121105.14126.73307.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 772358] Re: VNC working depends on command line
 options order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.12 is pretty much outdated nowadays ... can you still reproduce
this problem with the latest version of QEMU, or can we close this bug?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/772358

Title:
  VNC working depends on command line options order

Status in QEMU:
  Incomplete

Bug description:
  OS: Ubuntu 10.04.2, amd64
  Pkg version: 0.12.3+noroms-0ubuntu9.5

  if -nographic option is specified before -vnc, vnc works, if vice-
  versa, it does not. I have been told (thanks, mjt), that -nographic is
  supposed to disable any graphic output, including vnc, so possibly
  it's a documentation bug:

  - kvm man page talks about -nographic disabling SDL , not VNC. While
  it might be the same to you, it was not to me and my colleagues

  - if -vnc and -nographic are conflicting, perhaps kvm should error out
  or at least warn

  - monitor console's message on "change vnc 127.0.0.1:1" command:
  "Could not start server on 127.0.0.1:1" is not helpful either

  - order of the options should not matter

  Example: (VNC works)

  /usr/bin/kvm -name ubuntu.example.com -m 3076 -smp 2 -drive
  if=3Dvirtio,file=3D/dev/vg0/kvm-
  ubuntu,boot=3Don,media=3Ddisk,cache=3Dnone,index=3D0 -net
  nic,vlan=3D0,model=3Dvirtio,macaddr=3D00:03:03:03:03:01 -net
  tap,ifname=3Dkvm_ubuntu,vlan=3D0,script=3Dno,downscript=3Dno -balloon vir=
tio
  -nographic -daemonize -vnc 127.0.0.1:1 -pidfile /var/run/kvm/1

  Example: (VNC does not work, also confuses terminal):

  /usr/bin/kvm -name ubuntu.example.com -m 3076 -smp 2 -drive
  if=3Dvirtio,file=3D/dev/vg0/kvm-
  ubuntu,boot=3Don,media=3Ddisk,cache=3Dnone,index=3D0 -net
  nic,vlan=3D0,model=3Dvirtio,macaddr=3D00:03:03:03:03:01 -net
  tap,ifname=3Dkvm_ubuntu,vlan=3D0,script=3Dno,downscript=3Dno -balloon vir=
tio
  -vnc 127.0.0.1:1 -nographic -daemonize -pidfile /var/run/kvm/1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/772358/+subscriptions
