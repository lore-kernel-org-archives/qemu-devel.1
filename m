Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4U1n-0004VY-Nx
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4U1k-0003Cy-JK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:15:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f4U1k-0003Cn-CS
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:15:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f4U1j-0000Pc-0q
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 16:15:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 012142E80C8
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 16:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Apr 2018 16:03:09 -0000
From: Thomas Huth <855800@bugs.launchpad.net>
Reply-To: Bug 855800 <855800@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110921182430.29459.49832.malonedeb@wampee.canonical.com>
Message-Id: <152303059114.29388.12121247844358426644.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 855800] Re: KVM crashes when attempting to
 restart migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu-kvm (Ubuntu)
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/855800

Title:
  KVM crashes when attempting to restart migration

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Incomplete

Bug description:
  Operations performed:
  Sequence to trigger crash:

      * Start two kvm systems, one on gerph (primary), one on nbuild2 (list=
ening for incoming migration) - do not use -daemonize
      * On gerph, connect to monitor.
      * "migrate -d -b tcp:nbuild2:4444"
      * "info migrate"
      * "migrate_cancel"
      * "info migrate"
      * "migrate -d -b tcp:nbuild2:4444"
      * crashed with assertion:
  kvm: block-migration.c:355: flush_blks: Assertion `block_mig_state.read_d=
one >=3D 0' failed.
                   Connection closed by foreign host.
  [1]+  Aborted                 (core dumped) kvm -drive file=3D./copy-disk=
2.img,boot=3Don -m 4096 -serial mon:telnet::23023,server,nowait -balloon vi=
rtio -vnc :99 -usbdevice tablet -net nic,macaddr=3Df6:a6:31:53:89:9a,model=
=3Drtl8139,vlan=3D0 -net tap,vlan=3D0

  =

  Repeating the operations above often dies in different places; just repea=
t the cancel and restart the operation. Because the KVM system dies, the un=
derlying VM is obviously terminated.

  Distribution:

  jfletcher@gerph:~$ lsb_release -rd
  Description:	Ubuntu 10.04.3 LTS
  Release:	10.04

  Package:

  jfletcher@gerph:~$ apt-cache policy kvm
  kvm:
    Installed: 1:84+dfsg-0ubuntu16+0.12.3+noroms+0ubuntu9.15
    Candidate: 1:84+dfsg-0ubuntu16+0.12.3+noroms+0ubuntu9.15
    Version table:
   *** 1:84+dfsg-0ubuntu16+0.12.3+noroms+0ubuntu9.15 0
          500 http://gb.archive.ubuntu.com/ubuntu/ lucid-updates/main Packa=
ges
          500 http://security.ubuntu.com/ubuntu/ lucid-security/main Packag=
es
          100 /var/lib/dpkg/status
       1:84+dfsg-0ubuntu16+0.12.3+noroms+0ubuntu9 0
          500 http://gb.archive.ubuntu.com/ubuntu/ lucid/main Packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/855800/+subscriptions
