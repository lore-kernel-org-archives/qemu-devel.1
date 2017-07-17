Received: from eggs.gnu.org ([2001:4830:134:3::10]:55283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dWymM-00040F-1q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 01:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dWymI-0002eT-V8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 01:41:10 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:40791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1dWymI-0002cj-KO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 01:41:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 17 Jul 2017 07:40:57 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
Message-ID: <d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Am 2017-07-09 17:39, schrieb Programmingkid:
> I just made a documentation page for the LatticeMicro32 target. I need
> to know its current status, how much of this system is implemented,
> what software runs on it. If anyone could supply more information that
> would be appreciated. Pictures of this target running would be great
> as well. Thanks.
>=20
> Here is the page:=20
> http://wiki.qemu.org/Documentation/Platforms/LatticeMico32

Hi,

thank you for your efforts. I have to admit that the current status is=20
unknown.

I've just compiled the latest head and it looks like the BQL is missing=20
for the interrupt helpers. I'll post a patch soon. With the patch, the=20
basic stuff is working but there seems to be an issue with OpenGL.

You can read the quickstart instructions at:
http://milkymist.walle.cc/README.qemu

The flash image isn't working because it will boot right into the=20
visualization mode, which is using the OpenGL stuff. The "-kernel=20
flickernoise" method is working though. You can get the flickernoise=20
binary at:
http://milkymist.walle.cc/updates/current/flickernoise

Besides the milkymist emulation, there is plain lm32 emulation based on=20
the Lattice reference design which should be ok, because the tests are=20
working (=EF=BF=BCmake -C tests/tcg/lm32 check)

-michael
