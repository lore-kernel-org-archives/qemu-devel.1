Received: from eggs.gnu.org ([2001:4830:134:3::10]:44497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewoxi-0004QB-NG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewoxd-0006sB-Up
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:59:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:35362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewoxd-0006ro-Ow
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:59:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewoxc-0003qj-QI
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:59:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C62692E80CC
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:59:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Mar 2018 12:47:03 -0000
From: Thomas Huth <1435101@bugs.launchpad.net>
Reply-To: Bug 1435101 <1435101@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150323004114.9810.22436.malonedeb@soybean.canonical.com>
Message-Id: <152120442312.6578.13724022335236668218.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1435101] Re: Windows,
 QEMU 2.2.50 fails to boot XP CD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1435101

Title:
  Windows, QEMU 2.2.50 fails to boot XP CD

Status in QEMU:
  Incomplete

Bug description:
  Running XP Pro SP3 host 32bit.  When I launch qemu booting from CD, it fa=
ils to complete load, getting stuck at "Setup is starting Windows". It does=
 not proceed past. I tried to disable floppy but still no go. Download olde=
r version 1.5.1-win32, 0.9.1, same problem. =

  qemu-system-i386w.exe -cdrom "d:\XP.ISO" -hda d:\xp.img -boot d =

  with -global isa-fdc.driveA=3Dc or -no-fd-bootchk switches but no go. I s=
ee others have run into this problem as well but no real solutions. Some fo=
lks says turning off floppy works and I tried.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1435101/+subscriptions
