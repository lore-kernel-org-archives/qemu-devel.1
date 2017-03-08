Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clhKq-0000sS-9i
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clhKo-0006gw-RH
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:33:20 -0500
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
	<91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
	<cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
	<20170308184610.GE5211@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63437c2c-239e-a0af-d02e-c2993018ea93@redhat.com>
Date: Wed, 8 Mar 2017 13:33:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170308184610.GE5211@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IDHRg15BiIno6HvElGnMh7Ph85qlva0Gh"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IDHRg15BiIno6HvElGnMh7Ph85qlva0Gh
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>
Message-ID: <63437c2c-239e-a0af-d02e-c2993018ea93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
References: <20170308181833.32110-1-mreitz@redhat.com>
 <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
 <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
 <cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
 <20170308184610.GE5211@noname.redhat.com>
In-Reply-To: <20170308184610.GE5211@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 12:46 PM, Kevin Wolf wrote:
>>> Oh, I meant to add:
>>>
>>> Should probably mention that it was commit da34e65 that introduced th=
e
>>> problem (if I'm right?).  Does that mean we have not been compiling
>>> archipelago.c since Mar 2016?
>>
>> At least here on my machine it does indeed compile before that commit
>> and fails afterwards. So, yes, maybe we actually have not. :-)
>=20
> In that case, maybe we should rather remove the driver because very
> obviously nobody is interested in it, not even the maintainer. Keeping
> things around that nobody tests (and consequently, nobody uses) is just=

> a useless maintenance burden.

We've released 2.6, 2.7, and 2.8 with no complaints about failure to
compile. Sounds like a good candidate for removal in 2.9.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IDHRg15BiIno6HvElGnMh7Ph85qlva0Gh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwFxyAAoJEKeha0olJ0NqelcH/10I3ez1uavK2nJwLaZ0ov34
ovW+7th8lyKa+E7k8C4VFfY3UGqU+QVEdnKEqfDCDFJxY2kAXtebRpJw84pXF/a0
j/zzdi1YSyUtv3iHqJ3rqmBgelTEOGeSAgzYKlHbHjMSvLjvqd1Y7KBlfC+eqILg
q5aFZZXsdq7manUa3WnWUt9p7vGcwTRvSdlW8L4iU4yFRmDL+tRAjtooqhtwwtRY
6gWv1BOytSVoTL6v78wScRcdXaERd/9sPQigGNUgGuquL3NyqRuLEVXCu/+5aXAT
9INqyzO3KX/Icm1gcF8K7Jlq0NAmF4tlkM2x6Uh5vfC96rtB2GG1S8Kum2hRMcU=
=9tiF
-----END PGP SIGNATURE-----

--IDHRg15BiIno6HvElGnMh7Ph85qlva0Gh--
