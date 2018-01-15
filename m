Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eb1Ue-0006tG-Dm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eb1Ub-0002s5-DE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:55:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:39642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eb1Ub-0002rE-6r
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:55:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eb1UY-0007Xt-79
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B0EE42E855C
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:55:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2018 09:48:20 -0000
From: MVoloshin <1743337@bugs.launchpad.net>
Reply-To: Bug 1743337 <1743337@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151600970022.20222.12880965081591608460.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743337] [NEW] OS/2 Warp 4 HPFS corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

How to reproduce:
Install OS/2 Warp 4 onto HPFS-formatted partition. After reboot there will =
be messages about "missing" files and OS2.INI not found. Chkdsk C: complain=
s about FS corruption. Nothing changes even after fixing errors and next re=
boot. If you install OS/2 onto FAT partition instead, everything will be OK=
. I also tried booting images with OS/2 pre-installed through VBOX with sam=
e results. Is that HPFS driver or QEMU fault?

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: corruption hpfs i386 os2 warp4

** Description changed:

  How to reproduce:
- Install OS/2 Warp 4 onto HPFS-formatted partition. After reboot there wil=
l be messages about "missing" files and OS2.INI not found. Chkdsk C: compla=
ins about FS corruption. Nothing changes evwn after fixing errors and next =
reboot. If you install OS/2 onto FAT partition instead, everything will be =
OK. I also tried booting images with OS/2 pre-installed through VBOX with s=
ame results. Is that HPFS driver or QEMU fault?
+ Install OS/2 Warp 4 onto HPFS-formatted partition. After reboot there wil=
l be messages about "missing" files and OS2.INI not found. Chkdsk C: compla=
ins about FS corruption. Nothing changes even after fixing errors and next =
reboot. If you install OS/2 onto FAT partition instead, everything will be =
OK. I also tried booting images with OS/2 pre-installed through VBOX with s=
ame results. Is that HPFS driver or QEMU fault?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743337

Title:
  OS/2 Warp 4 HPFS corruption

Status in QEMU:
  New

Bug description:
  How to reproduce:
  Install OS/2 Warp 4 onto HPFS-formatted partition. After reboot there wil=
l be messages about "missing" files and OS2.INI not found. Chkdsk C: compla=
ins about FS corruption. Nothing changes even after fixing errors and next =
reboot. If you install OS/2 onto FAT partition instead, everything will be =
OK. I also tried booting images with OS/2 pre-installed through VBOX with s=
ame results. Is that HPFS driver or QEMU fault?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743337/+subscriptions
