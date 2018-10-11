Received: from eggs.gnu.org ([2001:4830:134:3::10]:46606)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gAgfA-0000E3-R7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gAgf7-0004QV-Kj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:30:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gAgf7-0004Nh-5p
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:30:21 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
	<CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
	<cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
	<486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
Date: Thu, 11 Oct 2018 21:31:23 +0200
MIME-Version: 1.0
In-Reply-To: <486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wOOhxRzsDfj8wIX0CkC5OVHJMUSxT7eeD"
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
To: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wOOhxRzsDfj8wIX0CkC5OVHJMUSxT7eeD
From: Kamil Rytarowski <n54@gmx.com>
To: Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <6225f3eb-5f1e-d63d-c39c-d67a92fa1a2e@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
References: <20181007153731.GA32288@humpty.home.comstyle.com>
 <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
 <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
 <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
 <a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
 <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
 <cae2d61f-c643-5be7-4200-fcafd2f92cc5@gmx.com>
 <486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
In-Reply-To: <486f95ef-db10-e0f2-e9a8-dd3eff0d3200@comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.2018 16:25, Brad Smith wrote:
> On 10/11/2018 5:41 AM, Kamil Rytarowski wrote:
>=20
>> On 11.10.2018 11:36, Peter Maydell wrote:
>>> On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
>>>> And from FreeBSD...
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_STACK MAP_STACK implies MAP_ANON,=
 and offset of 0.=C2=A0 The fd
>>>> argument must be -1 and prot must include at least
>>>> PROT_READ and PROT_WRITE.
>>>>
>>>> This option creates a memory region that grows to at
>>>> most len bytes in size, starting from the stack top
>>>> and growing down.=C2=A0 The stack top is the starting
>>>> address returned by the call, plus len bytes.=C2=A0 The
>>>> bottom of the stack at maximum growth is the starting
>>>> address returned by the call.
>>>>
>>>> Stacks created with MAP_STACK automatically grow.
>>>> Guards prevent inadvertent use of the regions into
>>>> which those stacks can grow without requiring mapping
>>>> the whole stack in advance.
>>> Hmm. That "automatically growing" part sounds like
>>> behaviour we definitely do not want for our use case.
>>> So we're going to need to make this OS-specific :-(
>>>
>> I propose to restrict MAP_STACK it to OpenBSD (with a comment in the
>> code). Once it will be needed by someone else will be able to enable i=
t
>> for other OSes.
>=20
> I was going to propose doing something like that but you had replied
> before I did.
> What sort of comment did you have in mind?
>=20

Why do we want it only on OpenBSD and its either unneeded or meaning
something else on other OSes.

#ifdef __OpenBSD__
flags |=3D MAP_STACK;
#endif


--wOOhxRzsDfj8wIX0CkC5OVHJMUSxT7eeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlu/pQsMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsbfoP/14Sy5JujzVoU+pYEcKb3sjqn+9H9eBm0sGD7UMW
ISgcrY+v5OAXvgWol3Yw+05X3uCK4daj23rRZtKyXhZbNMXx8/uHIU4viabf+AMs
W06VHA+8Nvfax0qHr/Svx0Au6qQswDeHHUnfiYz2th4qjNoVtxgREtN8jkajgG6G
KpzMhAyyec1Mu7ZNcr1qhwAgsuDVEuzp1La5m3ULhrvAc5WEvV1fQJkeBiCZSbY8
sTm6FNk4ftiVpAbb2quIOSNJE8kGdCSOgqFImP6MeX3RtVKKkhANvZu6NzABGPJ9
qwftgAKK+25k5t0bXSOcIl627QiJifSbfvEotVBXf4+kzCFpVsoudMSuNp3qxGf8
83DhqmnzSGZeMW1U0vM2rleV5jvJLThl+w5A/s75gRYFmL4QMZQ3/1c39opAFlLW
GU4GTi7UP5TWPqtbZgfAvlCVUyo+KtdJiTd7EFsDk98fvuVOKiL7yUcMElBJyvio
lT/mpy5HiNeDQ31v7HauJJCpcYGEUeqObJVUpcDlPJRDYAnLYGXxPWR56AX4GVKC
yHAG/+YIFNyJWWbjGCVqbqC/0VMLesx3/zTuzs7oBKUORNfGoxUmxXiI9qAebVWQ
OVXEeLdUBKGoEk+zsWxFKfjSvkWhCgBpoAyi8hxpBxHIbuF0fLl2A7gi/LL+1AtQ
klQA
=geER
-----END PGP SIGNATURE-----

--wOOhxRzsDfj8wIX0CkC5OVHJMUSxT7eeD--
