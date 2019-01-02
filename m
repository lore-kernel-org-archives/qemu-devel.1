Received: from eggs.gnu.org ([208.118.235.92]:48033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geogX-0001YI-NC
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 17:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geogQ-0001K7-G9
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 17:08:19 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
Date: Wed, 2 Jan 2019 16:08:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190102180158.GA6015@natto.ory.fergeau.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eaVP7cW4OlfJKKY9RiwNm6zb5hB4d4x4t"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eaVP7cW4OlfJKKY9RiwNm6zb5hB4d4x4t
From: Eric Blake <eblake@redhat.com>
To: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org
Message-ID: <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
In-Reply-To: <20190102180158.GA6015@natto.ory.fergeau.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/2/19 12:01 PM, Christophe Fergeau wrote:
> Adding Markus to cc: list, I forgot to do it when sending the patch.

Also worth backporting via qemu-stable, now in cc.

>=20
> Christophe
>=20
> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
>> commit 8bca4613 added support for %% in json strings when interpolatin=
g,
>> but in doing so, this broke handling of % when not interpolating as th=
e
>> '%' is skipped in both cases.
>> This commit ensures we only try to handle %% when interpolating.
>>
>> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
>> ---
>>  qobject/json-parser.c | 10 ++++++----
>>  tests/check-qjson.c   |  5 +++++
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--eaVP7cW4OlfJKKY9RiwNm6zb5hB4d4x4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwtNkoACgkQ3g5py3or
ov0Fbwf/b1kGguB4pDaGkbV42Sj6ABwgKJRK7Espl/z4se8rxASJiuQuXWdh7C4g
f94hXGxX7o0DXlzireve4qXziQTWSye8XOmgIAQ14FItLFVkgECjtOvSnYfyCyIy
UFirj/SbPV4IDmToTIXvZd7ckiSi3S5JUbtZGoevY1iBqs41tkoX5CpGyMc5FfU3
Lwi+APiAGe/8rGqwx4prxMND4F/1XLdevEK18ZTIA5wwCt+wFzAaKSvSOSBm6sPi
LusezwGio+k5O6DfI53xuSJo8v8MNutC25XF96U+3YNihp+m7y0zzeu+TOuafH0Y
356dXtKzpOAttqBV5rmaxTKc6piOWg==
=z/hK
-----END PGP SIGNATURE-----

--eaVP7cW4OlfJKKY9RiwNm6zb5hB4d4x4t--
