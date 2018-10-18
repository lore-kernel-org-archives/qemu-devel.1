Received: from eggs.gnu.org ([2001:4830:134:3::10]:39578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gD4Zm-0007t9-I8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gD4Zl-0001ky-JF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:26:42 -0400
Date: Thu, 18 Oct 2018 10:26:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181018092621.GC557@stefanha-x1.localdomain>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
	<5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
	<CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
	<c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 01:24:28PM +0200, Paolo Bonzini wrote:
> On 17/10/2018 12:57, Artem Pisarenko wrote:
> >> Further down in this patch the notation is QEMU_TIMER_ATTR_<id>, which=
 I
> >> think is clearer because QEMU_TIMER_ATTR(id) looks like a (non-existen=
t)
> >> macro.=A0 Please use the QEMU_TIMER_ATTR_<id> notation consistently.
> >=20
> > Yes, I've just forgot to update comments after previous patch version,
> > where it actually was macro.
> >=20
> >> What is the purpose of this bit?=A0 I guess it's just here as a
> >> placeholder because no real bits have been defined yet.=A0 Hopefully t=
he
> >> next patch removes it (/* This placeholder is removed in the next patch
> >> */ would be a nice way to document this for reviewers).
> >=20
> > It's just to prevent compilation errors, as required by
> > https://wiki.qemu.org/Contribute/SubmitAPatch#Split_up_long_patches
> >=20
> >> The enum isn't needed and makes debugging harder since the bit number =
is
> >> implicit in the enum ordering.=A0 This alternative is clearer and more
> >> concise:
> >>=A0
> >>=A0 =A0#define QEMU_TIMER_ATTR_foo BIT(n)
> >=20
> > Agree.
>=20
> Like this?

Yes, something like that is good.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbyFG9AAoJEJykq7OBq3PIDZAH/3CrGdLnb8fNFIn+eN9M2+HD
TLcb4r6HNPmOkpGD49qKihnvS556PpRIkK1Ozc9lTEQUJqLR6EMIza506n2goGqq
DakD/aNCDlWwPXhw/WTJIdpSutFctPmahpwV1ECZackTiVuWExW3iuZqHqidW0g1
ErkCmibKgeLEQ9qvIZXdxDn2TicW6En7f5+2hDbJ2Z3UEXuem90MQhYQgTevjmHz
QkpHjpDqa0hOl+fu9Ms5RqQvnSZapRfbLH4wNK40jE15PbVbTmJvhQMBm3UlyKW9
7xWT7cdvt6mX/zh1YgCka5YHa8Z6fqgFNYOvytAwZPHONRAhM6NdRGY+qENRP7Q=
=nest
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
