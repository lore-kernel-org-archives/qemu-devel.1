Received: from eggs.gnu.org ([2001:4830:134:3::10]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX7Rx-0004wo-VI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX7Ru-0005iA-4H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:42 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dX7Rt-0005i2-VV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:38 -0400
Received: by mail-io0-x232.google.com with SMTP id r36so44563609ioi.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:56:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
Date: Mon, 17 Jul 2017 10:56:35 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 17, 2017, at 1:40 AM, Michael Walle <michael@walle.cc> wrote:
>=20
> Am 2017-07-09 17:39, schrieb Programmingkid:
>> I just made a documentation page for the LatticeMicro32 target. I =
need
>> to know its current status, how much of this system is implemented,
>> what software runs on it. If anyone could supply more information =
that
>> would be appreciated. Pictures of this target running would be great
>> as well. Thanks.
>> Here is the page: =
http://wiki.qemu.org/Documentation/Platforms/LatticeMico32
>=20
> Hi,
>=20
> thank you for your efforts. I have to admit that the current status is =
unknown.
>=20
> I've just compiled the latest head and it looks like the BQL is =
missing for the interrupt helpers. I'll post a patch soon. With the =
patch, the basic stuff is working but there seems to be an issue with =
OpenGL.
>=20
> You can read the quickstart instructions at:
> http://milkymist.walle.cc/README.qemu
>=20
> The flash image isn't working because it will boot right into the =
visualization mode, which is using the OpenGL stuff. The "-kernel =
flickernoise" method is working though. You can get the flickernoise =
binary at:
> http://milkymist.walle.cc/updates/current/flickernoise
>=20
> Besides the milkymist emulation, there is plain lm32 emulation based =
on the Lattice reference design which should be ok, because the tests =
are working (=EF=BF=BCmake -C tests/tcg/lm32 check)
>=20
> -michael

Thank you for all this information. It has been added to the wiki page.=20=
