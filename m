Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnUkv-00046h-W5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnUku-0005st-Pb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnUku-0005rd-H7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:31:40 -0400
References: <20170210061200.15373-1-vapier@gentoo.org>
	<CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
	<20170215030211.GL28432@vapier>
	<CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e5c8c2d-35a7-a26a-bd80-379479125d9c@redhat.com>
Date: Mon, 13 Mar 2017 13:31:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="98FMhoVbQwweFoR0srf2MivehJhnFofWx"
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--98FMhoVbQwweFoR0srf2MivehJhnFofWx
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <2e5c8c2d-35a7-a26a-bd80-379479125d9c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
References: <20170210061200.15373-1-vapier@gentoo.org>
 <CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
 <20170215030211.GL28432@vapier>
 <CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 06:50 AM, Peter Maydell wrote:
> On 15 February 2017 at 03:02, Mike Frysinger <vapier@gentoo.org> wrote:=

>> On 10 Feb 2017 09:04, Peter Maydell wrote:
>>> I still think that it's a shame that glibc is breaking
>>> compatibility with where these macros have always been
>>> kept on every OS that's implemented them back to 2BSD...
>>
>> i don't think that characterization is accurate.  if it were,
>> autoconf wouldn't have a AC_HEADER_MAJOR helper.
>=20
> Hmm, Googling suggests that Solaris (and perhaps
> other SysV Unixes) put them in mkdev.h.
> That doesn't explain why glibc is taking yet a third
> approach here rather than using either of the two
> previously used choices...

Whether or not you think glibc broke things, the fact remains that the
build is broken on current Fedora rawhide if we don't apply either this
or the other proposed patch (the one by Christopher Covington, which
I've now pinged)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--98FMhoVbQwweFoR0srf2MivehJhnFofWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxuWKAAoJEKeha0olJ0NqIRMH/RqXzkyoVctyAaNMdlDgmfap
/m6s0YFAJ9we8cQ9iUFxnUjm5sT1yMe5yVU3zHPyY0cSOIWnJcBglUn4xvBaJg++
mtg5rQDr6syPB6FUl+hHC8JAUv5Xdkvyz0nNn5ZONe4e6OGm5x+OA6XEdXKcGgEk
ffRvpxTz1pQKr8GcxMTn/0BmCKbfeBudKf9oRo8yRku17zb/M/li3TZ83To/jKLD
9OoJ1GcdCv/P0/LHIwViLn6rflD4SkeiTf8TLkK/7/tsFUnuISy4XKx7fpHfsven
62AEuoqf1QYSYjuURqHq5kwX/8yTGp5hYkDtM54sSQKlC9a/QeADLqRU7TAKzLg=
=OdD8
-----END PGP SIGNATURE-----

--98FMhoVbQwweFoR0srf2MivehJhnFofWx--
