Received: from eggs.gnu.org ([2001:4830:134:3::10]:48164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d6rMO-0004mJ-Pq
	for qemu-devel@nongnu.org; Sat, 06 May 2017 00:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d6rMK-00061g-Pk
	for qemu-devel@nongnu.org; Sat, 06 May 2017 00:30:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:52545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d6rMK-000617-K7
	for qemu-devel@nongnu.org; Sat, 06 May 2017 00:30:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d6rMJ-0005ZM-B6
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 04:30:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 348602E80CE
	for <qemu-devel@nongnu.org>; Sat,  6 May 2017 04:30:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 May 2017 04:17:39 -0000
From: Launchpad Bug Tracker <1289788@bugs.launchpad.net>
Reply-To: Bug 1289788 <1289788@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140308144808.7594.3614.malonedeb@soybean.canonical.com>
Message-Id: <20170506041739.4680.44544.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1289788] Re: MIDI access (not only adlib) hangs
 WinNT on QEMU 1.7.x
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
https://bugs.launchpad.net/bugs/1289788

Title:
  MIDI access (not only adlib) hangs WinNT on QEMU 1.7.x

Status in QEMU:
  Expired

Bug description:
  Windows NT 4.0 and 2000 (including the latest git release), when enabling=
 adlib (with sb16 already enabled) or the built-in synth of the es1370, han=
g on QEMU 1.7.x (also with 1.7.50) when they try to play MIDI files (like c=
anyon.mid, etc). I have already tried bisecting but seems that this bug has=
 been introduced sometime in 1.7.0's development time.
  Screenshot attached: http://goput.it/ig2l.png

  OS Used: Windows 7 x64 Ultimate SP1
  command-line used: qemu-system-i386w.exe -L pc-bios -m 64 -cpu pentium -d=
rive file=3Dvbent40.img,if=3Dfloppy,id=3Dfda -drive file=3Dvhd.vhd,if=3Dide=
,media=3Ddisk,bus=3D0,unit=3D0,id=3Dharddisk0 -drive file=3DE:,if=3Dide,med=
ia=3Dcdrom,bus=3D1,unit=3D0,id=3Dcdrom -net nic,model=3Dpcnet -net user -vg=
a std -device ES1370 -boot menu=3Don -monitor telnet:127.0.0.1:4444,server,=
nowait

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1289788/+subscriptions
