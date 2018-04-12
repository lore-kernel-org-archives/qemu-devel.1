Received: from eggs.gnu.org ([2001:4830:134:3::10]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6dz9-0008In-LR
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6dz4-0001Zu-UY
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:18:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6dz4-0001Zm-O8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:17:58 -0400
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
	<c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
	<20180410133335.zzvgg7lqe2lb2zdx@sirius.home.kraxel.org>
	<20180412141153.GA16814@Nikki.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce62f38b-1b93-0eca-bd86-f55256a6db40@redhat.com>
Date: Thu, 12 Apr 2018 10:17:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180412141153.GA16814@Nikki.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g1WGrQ524AHV6SFWQQMgTW4ci3a4mv17r"
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g1WGrQ524AHV6SFWQQMgTW4ci3a4mv17r
From: Eric Blake <eblake@redhat.com>
To: Elie Tournier <tournier.elie@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Elie Tournier <elie.tournier@collabora.com>
Message-ID: <ce62f38b-1b93-0eca-bd86-f55256a6db40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
References: <20180410120222.31845-1-tournier.elie@gmail.com>
 <20180410120222.31845-2-tournier.elie@gmail.com>
 <c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
 <20180410133335.zzvgg7lqe2lb2zdx@sirius.home.kraxel.org>
 <20180412141153.GA16814@Nikki.localdomain>
In-Reply-To: <20180412141153.GA16814@Nikki.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 09:11 AM, Elie Tournier wrote:
> Hello,
>=20
> On Tue, Apr 10, 2018 at 03:33:35PM +0200, Gerd Hoffmann wrote:
>>> # @off: Disable OpenGL (default).
>=20
> Just to be sure, I have to add @ in front of all parameter, right?

Yes.


>>> You may be in luck - there is no instance of 'window-close' in the
>>> introspection output, which means 'DisplayType' exists only for ease =
of
>>> command-line parsing and is not currently used by QMP, so tweaks here=

>>> are not affecting the command line.
>>
>> Yes, right now the struct is only used to store the parsed command lin=
e
>> opts, so no effect on QMP.
>>
>> Plan for the future is to also parse command line options with generic=

>> qapi/json code instead of the home-grown parser, but that switch didn'=
t
>> happen yet.
>>
>>> That said, you can STILL name the enum value something smarter than '=
on'
>>> IF you make the change now, for 2.12, given that the QAPI type was on=
ly
>>> introduced in 2.12 (you only have to worry about backwards compatibil=
ity
>>> if 2.11 already parsed gl=3Don).
>>
>> gl=3Don is older, so that must continue to work.  Making both "on" and=

>> "auto" work isn't a problem for our home-grown parser (aka
>> parse_display() in vl.c).  But having quirks like this makes the switc=
h
>> to generic parser code more difficuilt, so I'd prefer to avoid that ..=
=2E
>=20
> Is it possible to upstream this change before 2.12 release?

At this point, no, we've missed -rc3, and it's not a big enough bug to
warrant needing -rc4 on its own.  And as Gerd said, we already parsed
'gl=3Don' in 2.11 (the QAPI representation is new to 2.12, but only to
simplify how the existing command line parser was coded), so that's
different than if 2.12 were introducing brand-new content in a form that
should be fixed before it is baked into existing uses.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g1WGrQ524AHV6SFWQQMgTW4ci3a4mv17r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPeKIACgkQp6FrSiUn
Q2oscwf+NSI83me+joLPlU6z6vIzVflEsZ4wod+G9z1JGgox3MOy9aV4OxkmKacK
7NYLGlsraOCHf4knoxAY96U5irmFa6nzvny41NEHQR+sC+pQnhqX6nBN6rPP03Kz
boToI90Aiog7UEX6+YzDbcJFP1/Y4ItGBFrkf/7DjjEFaFEeh0QGdUSFpc84lZfx
kJCURGPPdMkfyEW3eXQacKJBCyANhh0ZOSNb2wlHw5MhEr+JNcfCgs00NABNDGqm
edvPhJ46hlrQa9qIRUaci75sVD7eBsNrz8PpJPqpJXxRLWgXlSBXMGYVtVMEHMGx
bWPKSaPHhuR79a6M5zOCCUoIn7Orcg==
=lr55
-----END PGP SIGNATURE-----

--g1WGrQ524AHV6SFWQQMgTW4ci3a4mv17r--
