Received: from eggs.gnu.org ([2001:4830:134:3::10]:45747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX7mi-00061K-Ia
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dX7mf-0006gK-Aa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:18:08 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dX7mf-0006g2-53
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:18:05 -0400
Received: by mail-io0-x241.google.com with SMTP id z62so7718203ioi.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:18:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
Date: Mon, 17 Jul 2017 11:18:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
	<4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
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


> On Jul 17, 2017, at 10:56 AM, Programmingkid =
<programmingkidx@gmail.com> wrote:
>=20
>=20
>> On Jul 17, 2017, at 1:40 AM, Michael Walle <michael@walle.cc> wrote:
>>=20
>> Am 2017-07-09 17:39, schrieb Programmingkid:
>>> I just made a documentation page for the LatticeMicro32 target. I =
need
>>> to know its current status, how much of this system is implemented,
>>> what software runs on it. If anyone could supply more information =
that
>>> would be appreciated. Pictures of this target running would be great
>>> as well. Thanks.
>>> Here is the page: =
http://wiki.qemu.org/Documentation/Platforms/LatticeMico32
>>=20
>> Hi,
>>=20
>> thank you for your efforts. I have to admit that the current status =
is unknown.
>>=20
>> I've just compiled the latest head and it looks like the BQL is =
missing for the interrupt helpers. I'll post a patch soon. With the =
patch, the basic stuff is working but there seems to be an issue with =
OpenGL.
>>=20
>> You can read the quickstart instructions at:
>> http://milkymist.walle.cc/README.qemu
>>=20
>> The flash image isn't working because it will boot right into the =
visualization mode, which is using the OpenGL stuff. The "-kernel =
flickernoise" method is working though. You can get the flickernoise =
binary at:
>> http://milkymist.walle.cc/updates/current/flickernoise
>>=20
>> Besides the milkymist emulation, there is plain lm32 emulation based =
on the Lattice reference design which should be ok, because the tests =
are working (=EF=BF=BCmake -C tests/tcg/lm32 check)
>>=20
>> -michael
>=20
> Thank you for all this information. It has been added to the wiki =
page.=20
>=20

I just tried qemu-system-lm32 and it crashed.

Command-line: qemu-system-lm32 -M milkymist -kernel flickernoise

Error message: audio: Failed to create voice `mm_ac97.in'
**
ERROR: /accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion failed: =
(qemu_mutex_iothread_locked())
Abort trap: 6

Host: Mac OS 10.12.5=
