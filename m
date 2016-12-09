Received: from eggs.gnu.org ([2001:4830:134:3::10]:36411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFJIo-0001A9-BU
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFJIj-00005h-8d
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:25:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:44790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFJIj-0008WI-45
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:25:17 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFJIg-0001R9-Ri
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 11:25:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C95522E80AF
	for <qemu-devel@nongnu.org>; Fri,  9 Dec 2016 11:25:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Dec 2016 11:10:57 -0000
From: Thomas Huth <797905@bugs.launchpad.net>
Reply-To: Bug 797905 <797905@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110615203525.9195.5744.malonedeb@gac.canonical.com>
Message-Id: <20161209111057.25740.99930.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 797905] Re: virsh live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, as this is a libvirt issue, not a QEMU bug.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/797905

Title:
  virsh live migration

Status in QEMU:
  Invalid

Bug description:
  Hi,
  i do not manage to do a virsh migrate live command.
  Using Ubuntu Server 10.04 x64

  root@svr50abl:~# virsh list
   Id Nome                 Estado
  ----------------------------------
   18 Winxp                executando
   19 teste                executando

  root@svr50abl:~# sudo virsh migrate --live 19 qemu+ssh://10.1.5.1/system
  root@10.1.5.1's password: =

  erro: unable to set user and group to '116:127' on '/var/lib/libvirt/imag=
es/teste.img': No such file or directory

  teste.img has root:root (xrw)

  10.1.5.1 is a functional kvm host too

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/797905/+subscriptions
