Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJmj-00066t-5d
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJme-0000Du-Gg
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpJme-0000Db-7e
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:45:16 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
	<874lt16zdl.fsf@dusky.pond.sub.org>
	<CAFEAcA-8XL_YA7rDpyW6ZU5_R7jv2ZAnF92EoeRL-Y7C1z3EpQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92a63172-28c3-1d27-5123-104be54cb07d@redhat.com>
Date: Tue, 5 Sep 2017 14:45:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8XL_YA7rDpyW6ZU5_R7jv2ZAnF92EoeRL-Y7C1z3EpQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XfoDiGFJ5jX8OXNRHrQLMhhcFUEFBrenl"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XfoDiGFJ5jX8OXNRHrQLMhhcFUEFBrenl
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Message-ID: <92a63172-28c3-1d27-5123-104be54cb07d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert() in
 supported builds
References: <20170818222313.13391-1-eblake@redhat.com>
 <874lt16zdl.fsf@dusky.pond.sub.org>
 <CAFEAcA-8XL_YA7rDpyW6ZU5_R7jv2ZAnF92EoeRL-Y7C1z3EpQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-8XL_YA7rDpyW6ZU5_R7jv2ZAnF92EoeRL-Y7C1z3EpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2017 05:08 AM, Peter Maydell wrote:
> On 21 August 2017 at 10:31, Markus Armbruster <armbru@redhat.com> wrote=
:
>> I'm fine with project-wide, but does it have to be a hard error?  Can =
we
>> make it a warning?  Same effect by default, but it lets people
>> experiment more easily with --disable-werror.
>=20
> It won't be the same effect by default for our releases, which
> don't use -Werror.
>=20
> I don't think we want to make it easy for people to turn this
> off -- and it's only commenting out a single #error line if
> anybody really does want to mess about with it.

Two lines, actually, since we are also prohibiting disabling g_assert().

Anyways, as the topic came up again on the list, should I promote this
patch from RFC to actual patch? Whose tree would it go in through?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XfoDiGFJ5jX8OXNRHrQLMhhcFUEFBrenl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu/sUACgkQp6FrSiUn
Q2pTLQf+LnZFjgAqp5EwQppZRNaSwOWIoprP054+bYnNM5GnrwqpRynmc5mp4J3z
zdxb4ehcdy7HfI9SBbJNv5LBlsqJWXYdaZYLBoIIbb/7GaJ7xJ/isrA7erxn9i7y
FiiUUf/F2vsXnb0f2wQjfO+nmrt3AJlIvHpdy98j69wswB5fxUIE/vuJ9dg451cw
5yr+ktWf9LzA6KdSaBRJYvLOgMwerjz+vFWwBCXwLLq6htvKOk49ioY5MgYFoBxG
KPAFGg30nbGnGXg86bTEaDRjW+TquTbRJAv0NQpRlLnRYluiiN0z/hChQOeRGB3m
z3C3A47qCn4vAdiOJyzktgO7AF//LQ==
=tUDi
-----END PGP SIGNATURE-----

--XfoDiGFJ5jX8OXNRHrQLMhhcFUEFBrenl--
