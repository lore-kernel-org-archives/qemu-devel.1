Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgJ7-0007Ea-Qz
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgJ6-0006Nw-KL
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:27:29 -0500
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a1ba003c-9737-4d3d-a495-c8267f11beb2@redhat.com>
Date: Wed, 8 Mar 2017 19:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pvt4mrTrT4EkEH6qGj7lBpjB74P4A2th2"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pvt4mrTrT4EkEH6qGj7lBpjB74P4A2th2
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>,
 Fam Zheng <famz@redhat.com>
Message-ID: <a1ba003c-9737-4d3d-a495-c8267f11beb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
References: <20170308181833.32110-1-mreitz@redhat.com>
 <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
In-Reply-To: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 19:25, Eric Blake wrote:
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

Well, at least patchew didn't catch that I definitely broke archipelago
in my bdrv_truncate() errp series...

[CC-ing Fam]

Max


--pvt4mrTrT4EkEH6qGj7lBpjB74P4A2th2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljATQcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbtUIAKzrnCLT5R/jLWPKyOrEPVEtZ2Z0x702
AWAZnT/CaEhzIohQVyJXQXR2aP0SMEJhyju2wKaO37kikjYnODf2wxjARCuwnw33
YXq3TRJ/MUiAmOJG+adJulQreDhi8u5HoToA9DIgIUQ+Twvfjeddcey+HxzX4Jzo
sRLErgqbs4QOqIqrwt5iV81z0e3tmV+6cVH3hTCcJYDZxSGro6iJ5yL/c3AyN127
W0qfQg6HeE9RiGEFzVBpetQPS197b0gqoLqRwLChoQ2V2yvxaPy1Ka9mTohykt8t
AFfP0SfeqwkB823DxUvYfmMNCPM466ndh5RmR9qoCuFI3ITTxKPajGI=
=HHUh
-----END PGP SIGNATURE-----

--pvt4mrTrT4EkEH6qGj7lBpjB74P4A2th2--
