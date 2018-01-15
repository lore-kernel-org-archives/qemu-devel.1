Received: from eggs.gnu.org ([2001:4830:134:3::10]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ebAXk-0006Fc-GC
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ebAXg-0002IB-4A
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:35:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:44410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ebAXf-0002HL-U4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:35:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ebAXe-0002xG-LA
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9F0B52E854F
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2018 19:30:21 -0000
From: MVoloshin <1743337@bugs.launchpad.net>
Reply-To: Bug 1743337 <1743337@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151600970022.20222.12880965081591608460.malonedeb@chaenomeles.canonical.com>
Message-Id: <151604462171.10645.4651292381448938727.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743337] Re: OS/2 Warp 4 HPFS corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "warp4_3.PNG"
   https://bugs.launchpad.net/qemu/+bug/1743337/+attachment/5037539/+files/=
warp4_3.PNG

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
