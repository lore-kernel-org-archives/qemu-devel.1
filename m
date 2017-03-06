Received: from eggs.gnu.org ([2001:4830:134:3::10]:42563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckuu3-0006u8-MQ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckuu0-00088H-K5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:50:27 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ckuu0-000882-EK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:50:24 -0500
Received: by mail-it0-x244.google.com with SMTP id w185so9981588ita.3
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:50:24 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.56791.1488797131.22740.qemu-devel@nongnu.org>
Date: Mon, 6 Mar 2017 10:50:22 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <5102CE52-05CC-4B15-8D79-860B8557C055@gmail.com>
References: <mailman.56791.1488797131.22740.qemu-devel@nongnu.org>
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
To: Thomas Huth <1289788@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


On Mar 6, 2017, at 5:45 AM, qemu-devel-request@nongnu.org wrote:

>=20
> Is this problem still reproducible with the latest version of QEMU?
>=20
> ** Changed in: qemu
>       Status: New =3D> Incomplete
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1289788
>=20
> Title:
>  MIDI access (not only adlib) hangs WinNT on QEMU 1.7.x
>=20
> Status in QEMU:
>  Incomplete
>=20
> Bug description:
>  Windows NT 4.0 and 2000 (including the latest git release), when =
enabling adlib (with sb16 already enabled) or the built-in synth of the =
es1370, hang on QEMU 1.7.x (also with 1.7.50) when they try to play MIDI =
files (like canyon.mid, etc). I have already tried bisecting but seems =
that this bug has been introduced sometime in 1.7.0's development time.
>  Screenshot attached: http://goput.it/ig2l.png
>=20
>  OS Used: Windows 7 x64 Ultimate SP1
>  command-line used: qemu-system-i386w.exe -L pc-bios -m 64 -cpu =
pentium -drive file=3Dvbent40.img,if=3Dfloppy,id=3Dfda -drive =
file=3Dvhd.vhd,if=3Dide,media=3Ddisk,bus=3D0,unit=3D0,id=3Dharddisk0 =
-drive file=3DE:,if=3Dide,media=3Dcdrom,bus=3D1,unit=3D0,id=3Dcdrom -net =
nic,model=3Dpcnet -net user -vga std -device ES1370 -boot menu=3Don =
-monitor telnet:127.0.0.1:4444,server,nowait
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1289788/+subscriptions

A midi file played very will using SB16. It didn't work at all with =
adlib, and it played poorly in es1370. I used Windows 2000 as the guest. =
There were no hangs.=20
