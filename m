Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWPJe-0002gp-1E
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWPJa-0000ix-SA
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:25:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:43242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gWPJa-0000hw-Lk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:25:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gWPJY-00056J-1T
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:25:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B440E2E8083
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Dec 2018 17:17:34 -0000
From: MVoloshin <1743441@bugs.launchpad.net>
Reply-To: Bug 1743441 <1743441@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151604323239.5020.7297818634644485125.malonedeb@wampee.canonical.com>
Message-Id: <154446225496.16288.15309783349193784506.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743441] Re: OS/2 Warp 4.52 OS2LVM failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As far as I know it has never worked. I have checked it on version 2.11
and attached a link to my disk image. I used qemu-system-i386w -cpu
pentium3 -m 128 -hda c.img -boot c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743441

Title:
  OS/2 Warp 4.52 OS2LVM failure

Status in QEMU:
  Incomplete

Bug description:
  When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). Tried both FAT and HPF=
S. You can reproduce the bug using this disk image: https://drive.google.co=
m/open?id=3D1zzjs9hTS0TK-Xb5hnon8SQ-2C1EmlYfy
  P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743441/+subscriptions
