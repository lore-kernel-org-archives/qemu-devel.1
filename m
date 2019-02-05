Received: from eggs.gnu.org ([209.51.188.92]:40459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr4KD-0002TV-Kk
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr4KC-0004J4-Ne
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:15:57 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-10-vsementsov@virtuozzo.com>
	<8fff6a6e-1030-64d7-4c96-4704970b898c@redhat.com>
	<e78b4a65-e103-7df7-fa77-7d67699b9c91@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5fc24e8-679e-c11f-0fb3-c2d01614de3b@redhat.com>
Date: Tue, 5 Feb 2019 11:15:51 -0600
MIME-Version: 1.0
In-Reply-To: <e78b4a65-e103-7df7-fa77-7d67699b9c91@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cQkNcw4zjkhtVnfOf6NX4okdjb05EgAFs"
Subject: Re: [Qemu-devel] [PATCH v4 09/10] block/nbd-client: nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQkNcw4zjkhtVnfOf6NX4okdjb05EgAFs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <c5fc24e8-679e-c11f-0fb3-c2d01614de3b@redhat.com>
Subject: Re: [PATCH v4 09/10] block/nbd-client: nbd reconnect
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-10-vsementsov@virtuozzo.com>
 <8fff6a6e-1030-64d7-4c96-4704970b898c@redhat.com>
 <e78b4a65-e103-7df7-fa77-7d67699b9c91@virtuozzo.com>
In-Reply-To: <e78b4a65-e103-7df7-fa77-7d67699b9c91@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Or, put another way, we KNOW we have (corner) cases where a mis-aligne=
d
>> image can currently cause the server to return BLOCK_STATUS replies th=
at
>> aren't aligned to the advertised minimumm block size.  Attempting to
>> read the last sector of an image then causes the client to see the
>> misaligned reply and complain, which we are treating as fatal.
>=20
> Do we have fixes for it?

Not yet - it's still on my queue of things to fix after I get libvirt
incremental backup APIs in.  Might make 4.0, might not (but not the end
of the world; it's been known-broken since 3.0, so it's not a new
regression).

>=20
>> But why
>> not instead just fail that particular read, but still attempt a
>> reconnect, in order to attempt further reads elsewhere in the image th=
at
>> do not trip up the server's misaligned reply?
>>
>=20
> Hmm, for these cases, if we consider this errors not fatal, we don't ne=
ed
> even a reconnect..

Well, it all depends on whether the client is still in sync with the
server. If either side has disobeyed the spec, and send too many/too few
bytes compared to what the other side expects, you'll have magic number
mismatches, where you really DO need a reconnect to get back in sync.

>=20
> If we want to consider protocol errors to be recoverable, we need recon=
nect only
> on wrong magic and may be some kind of inconsistent variable data lengh=
ts..
>=20
> And it may need addition option, like --strict=3Dfalse

An option on how hard to try may be reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cQkNcw4zjkhtVnfOf6NX4okdjb05EgAFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZxMcACgkQp6FrSiUn
Q2rAcQf8DlzeFEGu9hKdM9uzygYGtqucC0C3/OMWn05OrlcX3Ay41XbyuQHlB6ah
XnfscJp5ZlhsZzb4H7eijCOITWyTdJB2JiKp1Eo+Gr9+rD27ZlD7tZbtB9CFJ6jR
LTFOFZNg/g2S3PWItmQ77kxoTmRMzlTaLXfanNfyWolfmBnkY/CobSANwyDY375+
6RMR0Dcj39UNZgaFW7K38dkT8pCLnnICiwYYsukp6gKyMi+C1pzRWFwI07SNRyEz
c1M5T3PiWeuerGIv7zNmqNuSHUk1/9LXGPYJ/aEc40ZIHcPX1DwiR+h0q3jGsus9
TKGJGW4fVf0fi6xWYtENwWfiBs8aCA==
=DdYg
-----END PGP SIGNATURE-----

--cQkNcw4zjkhtVnfOf6NX4okdjb05EgAFs--
