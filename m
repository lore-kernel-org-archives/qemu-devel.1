Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gAXSd-0005W5-LE
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gAXSa-0000hR-CC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:40:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:58749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gAXSY-0000dy-Dy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:40:47 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
	<CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
Date: Thu, 11 Oct 2018 11:41:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9hhTMvjIMrPg4SXvsgCK3MenT8FEb4eej"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hhTMvjIMrPg4SXvsgCK3MenT8FEb4eej
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
References: <20181007153731.GA32288@humpty.home.comstyle.com>
 <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
 <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
 <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
 <a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
 <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
In-Reply-To: <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.2018 11:36, Peter Maydell wrote:
> On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
>> And from FreeBSD...
>>
>>      MAP_STACK MAP_STACK implies MAP_ANON, and offset of 0.  The fd
>> argument must be -1 and prot must include at least
>> PROT_READ and PROT_WRITE.
>>
>> This option creates a memory region that grows to at
>> most len bytes in size, starting from the stack top
>> and growing down.  The stack top is the starting
>> address returned by the call, plus len bytes.  The
>> bottom of the stack at maximum growth is the starting
>> address returned by the call.
>>
>> Stacks created with MAP_STACK automatically grow.
>> Guards prevent inadvertent use of the regions into
>> which those stacks can grow without requiring mapping
>> the whole stack in advance.
>=20
> Hmm. That "automatically growing" part sounds like
> behaviour we definitely do not want for our use case.
> So we're going to need to make this OS-specific :-(
>=20

I propose to restrict MAP_STACK it to OpenBSD (with a comment in the
code). Once it will be needed by someone else will be able to enable it
for other OSes.

> thanks
> -- PMM
>=20



--9hhTMvjIMrPg4SXvsgCK3MenT8FEb4eej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlu/GuUMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsWtoP/3yqB6J3+3Nt639Gft2KElrTJjzZW+ZmOdIJRRxA
FAOlP8s6AH7hXzM6VSdOZ1ke/mjl2ObqcXatpuf/6pTiC/+1BfFRnO9/oBcIVWUQ
91fuSwE5YNgF3DaLmgS2sIPh6W66cY0et6YXunMtz/yyEHe18uOyUYmvwR2uejXC
fhUfjUgt2lfP7AFKip/34VI6miupw8c6T2jlduX6BAdFOkeopG0XnnhbDvrAhW9M
cd/5u/97ZJPPFLsCs9Drfxb2mIcTMwnX2jktR0qiS+NjlA5oLHbIB3YNZdU9lvFR
9P96Y9rwQeLvLOEsvbVN+Lb7T4G9KAoVnscav0Ko++C/3i+TQv0Xvz2sqOWNqADt
B4M7ZJFkwUalyPtS9vwMTjAzh9NpkDv8iu4ZatlR2OutEtifjLC+9kw880P7Vgdr
TQ+jXhnsBZf0BXNl9lVEjAdAFLVmVbrRI52XYxsgB7rL5pmI3jGqH/PbuDKlI5Ay
dYgr+v0d3y5HZ29WFCzuX2A9BKa8r6M1+jW7u/vqVuyEMoepgw5sTUnx0xi6hiKJ
GrBWS74zMQyXQJrLUtY3HLJ55OXC8ul3ARoDM/OfDQx+AvM/5OsQmxTiM83ApR3m
Q3UwBgKFsHT8DrIQOugIdxZZap3+CpejYZxFS9DqM4k8mPBnMq0tspDPLC0Rpktj
D/Z+
=ImvX
-----END PGP SIGNATURE-----

--9hhTMvjIMrPg4SXvsgCK3MenT8FEb4eej--
