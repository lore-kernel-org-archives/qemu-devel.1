Received: from eggs.gnu.org ([2001:4830:134:3::10]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clgKF-0007pJ-2z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clgKD-0006sO-Sa
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:28:39 -0500
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
Date: Wed, 8 Mar 2017 12:28:30 -0600
MIME-Version: 1.0
In-Reply-To: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kQsoAEEbbHJ5NAAf3E0T1aR457gLsTiGE"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kQsoAEEbbHJ5NAAf3E0T1aR457gLsTiGE
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>
Message-ID: <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
References: <20170308181833.32110-1-mreitz@redhat.com>
 <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
In-Reply-To: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 12:25 PM, Eric Blake wrote:
> On 03/08/2017 12:18 PM, Max Reitz wrote:
>> In order to use error_setg() and similar functions, we need to include=

>> qapi/error.h.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/archipelago.c | 1 +
>>  1 file changed, 1 insertion(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Does this mean our automated buildbots aren't building archipelago by
> default?
>=20

Oh, I meant to add:

Should probably mention that it was commit da34e65 that introduced the
problem (if I'm right?).  Does that mean we have not been compiling
archipelago.c since Mar 2016?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kQsoAEEbbHJ5NAAf3E0T1aR457gLsTiGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwE1OAAoJEKeha0olJ0NqSXQIAItHfeZoBdBE1bDEjygSZWS4
eybXIR/C2nOOiTqQtB4AM76z5hp7uSsbL4I+2fnwrFb3eI8E7IMqyG/avo+3pKeW
Rq8PEoObLQhQRQXURyQhc6ZrmhQ1s9nT83ZRz8VURMyzRQHNEj9bS2zx+Jz5Fip2
iNCtxEkKLFpbVs35qp03/eUfjsA2GZj8VzLelvNGIbZolAKomqW0Urdhva5x6Tj2
SKBMKIZnMt0owy1p3ozBHCWdncpbpthg8T98iEv2XUAn5/JCDcCWUcQowK/+F4QF
c6q06fXIkRnS6n2IHIUoBk46MZO2YbEwkeSB5xVShhddCbqWslBL1FAqxahiuGg=
=O+Mx
-----END PGP SIGNATURE-----

--kQsoAEEbbHJ5NAAf3E0T1aR457gLsTiGE--
