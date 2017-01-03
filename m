Received: from eggs.gnu.org ([2001:4830:134:3::10]:40178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOPg8-0007En-77
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cOPg2-0001KL-P4
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:03:04 -0500
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
From: =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
In-Reply-To: <20170102222831.GB12761@umbus.fritz.box>
Date: Tue, 3 Jan 2017 22:02:21 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
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

Hi=A3=ACdavid=A3=BA

   To my understanding=A3=ACwhat must be put in the realize function  is cod=
e which depends on property values. What's the benefit of moving memory regi=
on initialization into realize function?  I can not figure out, can you make=
 some explanations?
    Thanks for your review.

Best wishes =A3=A1

> =D4=DA 2017=C4=EA1=D4=C23=C8=D5=A3=AC06:28=A3=ACDavid Gibson <david@gibson=
.dropbear.id.au> =D0=B4=B5=C0=A3=BA
>=20
>> On Sat, Dec 31, 2016 at 09:18:27AM +0800, xiaoqiang zhao wrote:
>> This is some QOM'ify work relate with ppc.
>> See each commit message for details.
>>=20
>> xiaoqiang zhao (4):
>>  hw/gpio: QOM'ify mpc8xxx.c
>>  hw/ppc: QOM'ify e500.c
>>  hw/ppc: QOM'ify ppce500_spin.c
>>  hw/ppc: QOM'ify spapr_vio.c
>>=20
>> hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
>> hw/ppc/e500.c         | 17 ++++-------------
>> hw/ppc/ppce500_spin.c | 18 ++++++++----------
>> hw/ppc/spapr_vio.c    |  2 --
>> 4 files changed, 23 insertions(+), 34 deletions(-)
>=20
> Patches 1-3 all have the same problem - they move memory region
> initialization and similar to an instance_init function.  This is not
> how things are generally done in the qdev model.  Instead that phase
> of initialization should be done from a dc->realize() function.
>=20
> --=20
> David Gibson            | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au    | minimalist, thank you.  NOT _the_ _oth=
er_
>                | _way_ _around_!
> http://www.ozlabs.org/~dgibson
> [attachment]
>=20
> signature.asc
> download: http://preview.mail.163.com/xdownload?filename=3Dsignature.asc&m=
id=3D1tbiqBVTxlc67OfNrwABst&part=3D2&sign=3D95585277ead1794d396d48ba29e73240=
&time=3D1483402980&uid=3Dzxq_yx_007%40163.com
>=20
> preview: http://preview.mail.163.com/preview?mid=3D1tbiqBVTxlc67OfNrwABst&=
part=3D2&sign=3D95585277ead1794d396d48ba29e73240&time=3D1483402980&uid=3Dzxq=
_yx_007%40163.com
>=20
