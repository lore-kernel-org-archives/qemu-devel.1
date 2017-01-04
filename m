Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOm6s-0005P7-Tp
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOm6o-0004wi-12
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:00:11 -0500
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
From: =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
In-Reply-To: <20170104032811.GY12761@umbus.fritz.box>
Date: Wed, 4 Jan 2017 21:59:14 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <B05168C7-1D2C-4936-A0AD-9AFDCF7C0F56@163.com>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
	<20170104032811.GY12761@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de

Hmm=A3=ACsounds reasonable. I will take a look.

PS: guys, some other comments about this?

Best wishes =A3=A1

>> =D4=DA 2017=C4=EA1=D4=C24=C8=D5=A3=AC11:28=A3=ACDavid Gibson <david@gibso=
n.dropbear.id.au> =D0=B4=B5=C0=A3=BA
>>=20
>> On Tue, Jan 03, 2017 at 10:02:21PM +0800, =D5=D4=D0=A1=C7=BF wrote:
>> Hi=A3=ACdavid=A3=BA
>>=20
>>  To my understanding=A3=ACwhat must be put in the realize function  is
>>  code which depends on property values. What's the benefit of
>>  moving memory region initialization into realize function?  I can
>>  not figure out, can you make some explanations?
>=20
> If nothing else it's better in realize() for consistency with other
> devices.
>=20
> I'm not familiar enough with the details to be sure, but I also think
> it's not safe in instance_init.  Once memory regions are registered,
> the device can potentially interact with other devices in the virtual
> machine.  realize() is sequenced to expect that, instance_init is not.
>=20
>>   Thanks for your review.
>>=20
>> Best wishes =A3=A1
>>=20
>>>> =D4=DA 2017=C4=EA1=D4=C23=C8=D5=A3=AC06:28=A3=ACDavid Gibson <david@gib=
son.dropbear.id.au> =D0=B4=B5=C0=A3=BA
>>>>=20
>>>> On Sat, Dec 31, 2016 at 09:18:27AM +0800, xiaoqiang zhao wrote:
>>>> This is some QOM'ify work relate with ppc.
>>>> See each commit message for details.
>>>>=20
>>>> xiaoqiang zhao (4):
>>>> hw/gpio: QOM'ify mpc8xxx.c
>>>> hw/ppc: QOM'ify e500.c
>>>> hw/ppc: QOM'ify ppce500_spin.c
>>>> hw/ppc: QOM'ify spapr_vio.c
>>>>=20
>>>> hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
>>>> hw/ppc/e500.c         | 17 ++++-------------
>>>> hw/ppc/ppce500_spin.c | 18 ++++++++----------
>>>> hw/ppc/spapr_vio.c    |  2 --
>>>> 4 files changed, 23 insertions(+), 34 deletions(-)
>>>=20
>>> Patches 1-3 all have the same problem - they move memory region
>>> initialization and similar to an instance_init function.  This is not
>>> how things are generally done in the qdev model.  Instead that phase
>>> of initialization should be done from a dc->realize() function.
>=20
> --=20
> David Gibson            | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au    | minimalist, thank you.  NOT _the_ _oth=
er_
>               | _way_ _around_!
> http://www.ozlabs.org/~dgibson
> =A1=BE=C0=B4=D7=D4=CD=F8=D2=D7=D3=CA=CF=E4=B5=C4=B3=AC=B4=F3=B8=BD=BC=FE=A1=
=BF
> =D3=CA=BC=FE=B4=F8=D3=D0=B8=BD=BC=FE=D4=A4=C0=C0=C1=B4=BD=D3=A3=AC=C8=F4=C4=
=FA=D7=AA=B7=A2=BB=F2=BB=D8=B8=B4=B4=CB=D3=CA=BC=FE=CA=B1=B2=BB=CF=A3=CD=FB=B6=
=D4=B7=BD=D4=A4=C0=C0=B8=BD=BC=FE=A3=AC=BD=A8=D2=E9=C4=FA=CA=D6=B6=AF=C9=BE=B3=
=FD=C1=B4=BD=D3=A1=A3
>=20
> signature.asc
> =CF=C2=D4=D8: http://u.163.com/t0/wilj3q882UKg
>=20
> =D4=A4=C0=C0: http://u.163.com/t0/KpNY8oHelqjD
>=20
