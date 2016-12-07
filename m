Received: from eggs.gnu.org ([2001:4830:134:3::10]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdsz-0001IA-RY
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdsu-0008J4-Ge
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:11:53 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-5-eblake@redhat.com>
	<20161207143521.GF4773@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2976d1ba-7515-edec-00ca-e16ebf0735d8@redhat.com>
Date: Wed, 7 Dec 2016 09:11:39 -0600
MIME-Version: 1.0
In-Reply-To: <20161207143521.GF4773@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CLtnSO1Qo2WfnGUMR4q7cJrETXXkqFTN6"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CLtnSO1Qo2WfnGUMR4q7cJrETXXkqFTN6
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <2976d1ba-7515-edec-00ca-e16ebf0735d8@redhat.com>
Subject: Re: [PATCH v3 4/5] blkdebug: Add ability to override unmap geometries
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-5-eblake@redhat.com>
 <20161207143521.GF4773@noname.str.redhat.com>
In-Reply-To: <20161207143521.GF4773@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 08:35 AM, Kevin Wolf wrote:

>> +++ b/qapi/block-core.json
>> @@ -2068,6 +2068,29 @@
>>  # @align:           #optional required alignment for requests in byte=
s,
>>  #                   must be power of 2, or 0 for default
>>  #
>> +# @max-transfer:    #optional maximum size for I/O transfers in bytes=
,
>> +#                   must be multiple of the larger of @align and and =
512
>=20
> s/and and/and/
>=20
>> +#                   (but need not be a power of 2), or 0 for default
>> +#                   (since 2.9)
>=20
> What is the reason for the 512 bytes restriction?

Probably because I wrote the patch prior to your work to make blkdebug
byte-based, and then forgot to touch it up on rebase.

> Not really a problem,
> though, allowing more values later is easier than restricting them.

I'll see if I can drop the restriction, or at least improve the text,
for v4.

>=20
> The rest looks good.
>=20
> Kevin
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CLtnSO1Qo2WfnGUMR4q7cJrETXXkqFTN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSCasAAoJEKeha0olJ0Nq4XIH/R2j8qKAfpIpPVn0nu6r5ZAF
Xm81inBnd3Eyac/QtrvZBzG+k6vX0hp+h37J5Jz4rJv6pGTnlAkKzOBQKjsgHxVT
9R1hQTun68IR5/ANgwNsX6jgMe2ibFBKR0Obln0ov66DEGJ0gPqjJ0TqjSxS1Dti
LjNYbaZcT/YTkACPwHoyLRHtQcrvDzp6aMTYPPHUhqRK9fCnmjT9KsdTO6Z6+ynH
A+Iwu4TlXR51WkTEtwi4pTNnzbY8Rsg4ErksfCzwVBfcr/8GgCfVih/m0NgopwxS
sjYe1BhRMe6zOtnLHHX0G1zACEcyqstMTqQfm3GLhv4ECGG+Q+Vo5oVDXedYf0s=
=K4l7
-----END PGP SIGNATURE-----

--CLtnSO1Qo2WfnGUMR4q7cJrETXXkqFTN6--
