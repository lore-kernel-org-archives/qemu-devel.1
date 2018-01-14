Received: from eggs.gnu.org ([2001:4830:134:3::10]:46664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eap05-0008Hd-NT
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 15:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eap00-0003rZ-RG
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 15:35:29 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:50402
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.weil@weilnetz.de>)
	id 1eap00-0003qY-KC
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 15:35:24 -0500
References: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
	<alpine.BSF.2.21.1801141421010.19489@zero.eik.bme.hu>
From: Stefan Weil <stefan.weil@weilnetz.de>
Message-ID: <35265a1e-3474-32e0-1915-2583cd2c306d@weilnetz.de>
Date: Sun, 14 Jan 2018 21:35:21 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1801141421010.19489@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1743214] [NEW] OS/2 Warp 3 support broken in
 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, MVoloshin <1743214@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

Am 14.01.2018 um 14:24 schrieb BALATON Zoltan:
> On Sun, 14 Jan 2018, MVoloshin wrote:
>> Hello, I used to run OS/2 Warp 3 on QEMU with the following command
>> line: qemu-system-i386 -vga cirrus -soundhw sb16 -hda os2warp3v2.img
>> -boot c. It runs OK on QEMU 2.10, but immediately gives TRAP 0006
>> (invalid opcode?) on QEMU 2.11 (see screenshot).
>>
>> If it is important I have Fixpack 40 and GRADD installed in OS/2.
>> Here is the image:
>> https://drive.google.com/open?id=3D15umPecy7JlPLKUP6520MB_87CfrCDWO5
>=20
> This image boots for me without problem with latest version from git so
> either it's already fixed or the problem is elsewhere. Can you try
> latest git version? If it still does not work with that maybe you need
> to provide more details, like configure options or what host arch/OS ar=
e
> you on.


Zoltan, did you run the test with KVM enabled?

I=E2=80=8C get a crash when I run the image with latest QEMU on Linux wit=
h TCG.

Stefan
